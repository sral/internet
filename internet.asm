MAIN    SEGMENT BYTE PUBLIC USE16 'MAIN'
        ASSUME  cs:MAIN, ds:MAIN
        ORG     100h

	VIDEO_RAM	EQU 0b800h
	BIOS_DATA	EQU 0040h
	TIMER_OFFSET	EQU 006ch
	
	.386
start: 
        mov 	dx, 1800h
        mov 	ah, 02h
        int 	10h 		; Set cursor position
        
        push 	VIDEO_RAM
        pop 	es
        
	call    cls
	push	offset frame9	
	push 	offset end - offset frame9
	push	2dh
	call    draw_frame
	add 	esp, 6h		
	
	Call 	cls
        push	offset frame1
        push    offset frame2 - offset frame1
        push	6h
	call	draw_frame
	add 	esp, 6h		
	
	call 	cls
        push	offset frame2
        push 	offset frame3 - offset frame2
        push	6h
	call   	draw_frame
	add 	esp, 6h		
	
	call 	cls        
        push	offset frame3
        push	offset frame4 - offset frame3
        push	6h
	call   	draw_frame
	add 	esp, 6h		
	
	call   	cls 
        push	offset frame4
        push	offset frame5 - offset frame4
        push	6h
	call   	draw_frame 
	add 	esp, 6h		
	
	call   	cls 
        push	offset frame5
        push	offset frame6 - offset frame5
        push	8h
	call   	draw_frame
	add 	esp, 6h		
	
	call   	cls 
        push	offset frame6
        push	offset frame7 - offset frame6
        push	28h
	call   	draw_frame
	add 	esp, 6h		

	call   	cls 
        push	offset frame7
        push	offset frame8 - offset frame7
        push	28h
	call   	draw_frame
	add 	esp, 6h		

	call   	cls 
        push	offset frame8
	push	offset frame9 - offset frame8
        push	28h
	call 	draw_frame
	add 	esp, 6h		
        
        mov     ax, 4c00h 	
        int     21h      	; Exit

cls:
	push 	di		; Store register(s)

	mov 	ax, 0720h
	mov 	di, 0h
	mov 	cx, 4000 
	rep 	stosw

	pop	di		; Restore register(s)
	ret

draw_frame:
	push	ebp
	mov	ebp, esp
	
	push 	di		; Store register(s)
	push 	si
	push 	es
	
	mov 	bx, [ebp+6]	; delay
	mov	cx, [ebp+8]	; length
	mov	si, [ebp+10]	; src_offset
	
again:  
        mov     ah, [si]	; read char from src_offset
        mov     es:[di], ah	; write char 0b800:dst_offset
        inc     si		; increment src_offset
        inc     di       	; increment dst_offset
loop    again

	push 	BIOS_DATA	; Push timer address
	pop	es		; Pop int to es
	mov 	di, TIMER_OFFSET
	mov 	ax, es:[di]	; Read time0
wait:
	mov 	dx, es:[di]	; Read time1
	sub 	dx, ax		; delta = time1 - time0
	cmp 	dx, bx
	jl 	wait		; Wait while delta < delay (i) 

	pop	es		; Restore register(s)
	pop	si
	pop	di

	mov 	esp, ebp
	pop	ebp
	
	ret
	
frame1  DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 06h
        DB      0dch, 06h, 0dch, 06h, 0dch, 06h, 0dch, 06h, 0dch, 06h, 0dch, 0ch, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 06h, 020h, 06ch, 020h, 06ch, 0b0h, 06ch
        DB      0dch, 06ch, 0dch, 06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0b2h
        DB      06ch, 0dch, 0ch, 0dch, 0ch, 020h, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 0dch, 06h, 020h, 06ch, 020h, 06ch, 0dch, 06ch, 0b2h, 06ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0b2h, 06ch, 0dch, 0ch, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 0dch, 06h, 020h, 06ch, 0b0h, 06ch, 0b2h, 06ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh, 06h, 020h, 06ch, 0b2h, 06ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dfh, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 06h, 020h, 0ch, 020h, 0ch, 020h
        DB      0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 0dch, 0ch, 020h, 0ch, 020h, 0ch, 020h
        DB      0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh, 06h, 020h, 06ch, 0b2h, 06ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch, 06h, 020h, 0ch, 020h
        DB      0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 0dch, 06h, 0dbh, 0ch, 0dch, 0ch, 020h, 0ch, 020h
        DB      0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 06h, 0dbh, 06h, 0dfh
        DB      06ch, 0b2h, 06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch, 06ch
        DB      0dch, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 06ch, 0dfh, 0ch, 0dfh, 0ch, 0dch, 06h, 0dbh, 0ch
        DB      0dch, 0ch, 020h, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 0dfh, 06h, 0dfh, 06h, 0dfh, 06ch, 0dfh, 06ch, 0b2h, 06ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 020h, 0ch, 020h, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 06ch, 020h, 06ch
        DB      0dfh, 06ch, 0b2h, 06ch, 0dfh, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 0ch, 0dfh, 0ch, 0dfh
        DB      0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 02h, 0dch, 02h, 0dbh, 02h, 0dch, 0ah, 0dch, 0ah
        DB      0dch, 0ah, 0dch, 0ah, 0dbh, 0ah, 020h, 0ah, 020h, 0ah, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0eh, 020h, 0eh, 0dch, 06h, 0dch, 0ch
        DB      0dch, 06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch, 0ch, 0dch, 0ch, 020h
        DB      0eh, 020h, 0eh, 020h, 0eh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 0dbh, 02h, 020h, 02ah, 0b2h, 02ah, 0dbh, 0ah, 0dfh, 0ah, 0dbh
        DB      0ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0b2h, 02ah, 0dch, 0ah, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh, 06h, 0deh, 06ch, 0dbh
        DB      06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0b2h
        DB      06ch, 020h, 07h, 020h, 0eh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 0dbh, 02h, 020h, 02ah, 0b2h, 02ah, 0dbh, 0ah, 020h, 0ah, 0b0h, 02ah, 0dbh
        DB      0ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0ddh, 0ah, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0deh, 06h, 020h, 06ch, 0dfh, 0ch, 020h
        DB      0ch, 020h, 07h, 0dfh, 0ch, 0dbh, 0ch, 0dfh, 0ch, 020h, 0ch, 020h, 0ch, 0dfh, 0ch, 0dbh
        DB      0ch, 0ddh, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 0dbh, 02h, 0b0h, 02ah, 0dbh, 0ah, 0dbh, 0ah, 020h, 0ah, 0dbh, 02h, 0b2h
        DB      02ah, 0dbh, 0ah, 020h, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah, 020h, 0ah, 020h
        DB      0ah, 020h, 0ah, 020h, 07h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0b0h, 06ch, 0deh, 06ch
        DB      0dch, 0ch, 0dch, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch, 0ch, 0dch, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 0deh, 02h, 0dbh, 02h, 0b0h, 02ah, 0b2h, 02ah, 0dbh, 0ah, 020h, 0ah
        DB      0dbh, 02h, 0b2h, 02ah, 0dbh, 0ah, 020h, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0ddh, 0ah, 020h, 0ah
        DB      020h, 0ah, 020h, 0ah, 020h, 07h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 06ch
        DB      0b2h, 06ch, 0dch, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dch, 0ch, 0dbh, 0ch, 0b2h
        DB      06ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0ah, 0dfh, 02h, 0dbh, 02h, 0b0h, 02ah, 0b2h, 02ah, 0dbh
        DB      0ah, 020h, 0ah, 0dbh, 02h, 0b2h, 02ah, 0dbh, 0ah, 020h, 0ah, 0dfh, 0ah, 020h, 0ah, 020h
        DB      0ah, 020h, 0ah, 0dch, 08h, 0b2h, 08h, 0dch, 08h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      0dfh, 06h, 0dfh, 0ch, 0dfh, 06ch, 0b2h, 06ch, 0dbh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 01h, 0dch, 01h, 0dfh, 02h, 0dfh, 02h, 0dfh, 0ah
        DB      0dfh, 0ah, 020h, 0ah, 0dfh, 02h, 0dfh, 02ah, 0dbh, 0ah, 0dfh, 0ah, 0dch, 0ch, 0dch, 0ch
        DB      0dfh, 08h, 0dbh, 08h, 0dbh, 08h, 0dbh, 08h, 0dbh, 08h, 0dch, 08h, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 06h, 0dbh, 06h, 0b2h
        DB      06eh, 0dch, 0eh, 0dch, 0eh, 0dch, 0eh, 0dch, 0eh, 0dch, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dch
        DB      0eh, 020h, 0eh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 01h, 020h, 019h, 0deh, 019h, 0dbh, 019h, 0dbh
        DB      09h, 0dbh, 09h, 0dbh, 09h, 020h, 0ah, 020h, 0ah, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dch, 0ch, 0dfh, 08h, 0b2h, 078h, 0dbh, 08h, 0dbh, 08h, 0dbh, 08h, 0dch, 08h, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0deh, 06h, 020h, 06eh, 0deh, 06eh, 0dbh, 0eh, 0dbh
        DB      0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0ddh
        DB      0eh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 09h, 020h, 09h, 0dbh, 01h, 020h, 019h, 0dbh, 09h, 0dbh, 09h, 0dfh, 09h, 0b2h
        DB      019h, 0dbh, 09h, 0dch, 08h, 0dch, 08h, 0dfh, 0ch, 0dfh, 0ch, 0dbh, 0ch, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 08h, 0dfh, 08h, 0dbh, 08h, 0dbh, 08h, 0dbh, 08h, 0dch, 08h, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 0dbh, 06h, 0b0h, 06eh, 0b2h, 06eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh
        DB      0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      09h, 020h, 09h, 0dbh, 01h, 020h, 019h, 0b2h, 019h, 0dbh, 09h, 020h, 09h, 0dbh, 01h, 0b2h, 019h, 0ddh
        DB      09h, 0dfh, 08h, 0b2h, 08h, 0dfh, 08h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 08h, 020h, 01h, 0dfh, 08h, 0b2h, 08h, 0dbh, 08h, 0dfh, 08h, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch
        DB      01h, 0dfh, 06h, 0dfh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh
        DB      0eh, 0dbh, 0eh, 0dfh, 0eh, 0dfh, 0eh, 0dch, 09h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 09h, 0deh, 01h, 0dbh
        DB      01h, 020h, 019h, 0b0h, 019h, 0dbh, 09h, 020h, 09h, 0b0h, 019h, 0deh, 019h, 0dbh, 019h, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 01h
        DB      0dbh, 01h, 0dfh, 019h, 0dch, 09h, 0dch, 09h, 0dch, 09h, 0dch, 09h, 0dch, 09h, 0dch, 09h, 0dch, 09h
        DB      0dbh, 09h, 0b2h, 019h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 09h, 0dbh, 01h, 020h, 019h, 020h, 019h
        DB      020h, 019h, 0dfh, 019h, 0dbh, 09h, 020h, 09h, 020h, 019h, 0b0h, 019h, 0dbh, 09h, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 01h, 0dbh
        DB      01h, 0b0h, 019h, 0b2h, 019h, 0dbh, 09h, 020h, 09h, 020h, 019h, 0b2h, 019h, 0dbh, 09h, 0dbh, 09h
        DB      0dfh, 09h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 07h
        DB      020h, 07h, 020h, 07h, 020h, 07h, 020h, 07h, 020h, 07h, 020h, 07h, 020h, 07h, 020h, 07h, 020h, 07h
        DB      020h, 07h, 020h, 07h, 020h, 07h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 07h, 020h, 07h, 020h, 07h, 020h, 07h
	
frame2  DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 0dch, 06h, 0dch, 06h, 0dch, 06h, 0dch, 06h, 0dch, 06h, 0dch, 06h, 0dch
        DB      0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 06h, 020h
        DB      06ch, 020h, 06ch, 0b0h, 06ch, 0dch, 06ch, 0dch, 06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0b2h, 06ch, 0dch, 0ch, 0dch, 0ch, 020h, 0ch, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 06h, 020h, 06ch, 020h
        DB      06ch, 0dch, 06ch, 0b2h, 06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0b2h, 06ch, 0dch
        DB      0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 06h, 020h, 06ch, 0b0h
        DB      06ch, 0b2h, 06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dbh, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh, 06h, 020h, 06ch
        DB      0b2h, 06ch, 0dbh, 0ch, 0dbh, 0ch, 0dfh, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch
        DB      06h, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 0dch
        DB      0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh
        DB      06h, 020h, 06ch, 0b2h, 06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dch, 06h, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 0dch, 06h, 0dbh
        DB      0ch, 0dch, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 0dfh, 06h, 0dbh, 06h, 0dfh, 06ch, 0b2h, 06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dch, 06ch, 0dch, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 06ch, 0dfh, 0ch
        DB      0dfh, 0ch, 0dch, 06h, 0dbh, 0ch, 0dch, 0ch, 020h, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 06h, 0dfh, 06h, 0dfh, 06ch, 0dfh, 06ch
        DB      0b2h, 06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dfh
        DB      0ch, 0dfh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 06ch, 020h, 06ch, 0dfh, 06ch, 0b2h, 06ch, 0dfh, 0ch, 0dch, 0ch, 0dch, 0ch
        DB      0dch, 0ch, 0dfh, 0ch, 0dfh, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 02h, 0dch, 02h
        DB      0dbh, 02h, 0dch, 0ah, 0dch, 0ah, 0dch, 0ah, 0dch, 0ah, 0dbh, 0ah, 020h, 0ah, 020h, 0ah
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0eh, 020h, 0eh, 0dch, 06h, 0dch, 0ch
        DB      0dch, 06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch, 0ch, 0dch, 0ch, 020h
        DB      0eh, 020h, 0eh, 020h, 0eh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh, 02h, 020h, 02ah, 0b2h
        DB      02ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0b2h, 02ah, 0dch
        DB      0ah, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh, 06h, 0deh, 06ch, 0dbh
        DB      06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0b2h
        DB      06ch, 020h, 07h, 020h, 0eh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh, 02h, 020h, 02ah, 0b2h, 02ah, 0dbh
        DB      0ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0dfh, 0ah, 0dbh, 0ah, 0dbh
        DB      0ah, 0ddh, 0ah, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0deh, 06h, 020h, 06ch, 0dfh, 0ch, 020h
        DB      0ch, 020h, 07h, 0dfh, 0ch, 0dbh, 0ch, 0dfh, 0ch, 020h, 0ch, 020h, 0ch, 0dfh, 0ch, 0dbh
        DB      0ch, 0ddh, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh, 02h, 0b0h, 02ah, 0dbh, 0ah, 0dbh
        DB      0ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0dfh, 0ah, 0b0h, 02ah, 0b2h, 02ah, 0dch, 0ah, 0dfh
        DB      0ah, 0dbh, 0ah, 020h, 0ah, 020h, 0ah, 020h, 0ah, 020h, 07h, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0b0h, 06ch, 0deh, 06ch
        DB      0dch, 0ch, 0dch, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch, 0ch, 0dch, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0deh, 02h, 0dbh, 02h, 0b0h, 02ah
        DB      0b2h, 02ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0dch, 0ah, 0dfh, 02h, 0dfh, 02ah
        DB      0b2h, 02ah, 0dch, 0ah, 020h, 0ah, 020h, 0ah, 020h, 0ah, 020h, 07h, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 06ch
        DB      0b2h, 06ch, 0dch, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dch, 0ch, 0dbh, 0ch, 0b2h
        DB      06ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0ah, 0dfh, 02h, 0dbh
        DB      02h, 0b0h, 02ah, 0b2h, 02ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0dch
        DB      0ah, 0dfh, 02h, 0dfh, 02ah, 0b2h, 02ah, 0dbh, 0ah, 0dch, 0ah, 0dch, 0ah, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 08h, 0dch, 08h, 0b2h, 078h, 0dbh, 08h, 0dch, 08h, 0dch, 08h, 020h, 08h
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      0dfh, 06h, 0dfh, 0ch, 0dfh, 06ch, 0b2h, 06ch, 0dbh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 01h, 0dch
        DB      01h, 0dfh, 02h, 0dfh, 02h, 0dfh, 0ah, 0dfh, 0ah, 0dfh, 0ah, 0dfh, 0ah, 0dfh, 0ah, 020h, 0ah
        DB      020h, 0ah, 020h, 0ah, 020h, 0ah, 0dfh, 02h, 0dfh, 0ah, 0dfh, 0ah, 020h, 0ah, 0dbh, 0ch
        DB      0dbh, 0ch, 0dch, 0ch, 020h, 07h, 0dfh, 08h, 0b2h, 08h, 0dbh, 08h, 0dbh, 08h, 0dbh, 08h, 0dbh
        DB      08h, 0dch, 08h, 0dch, 08h, 020h, 08h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 06h, 0dbh, 06h, 0b2h, 06eh
        DB      0dch, 0eh, 0dch, 0eh, 0dch, 0eh, 0dch, 0eh, 0dch, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dch, 0eh
        DB      020h, 0eh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 01h, 020h, 019h
        DB      0deh, 019h, 0dbh, 019h, 0dbh, 09h, 0dbh, 09h, 0dbh, 09h, 020h, 0ah, 020h, 0ah, 020h, 0ah, 020h
        DB      0ah, 020h, 07h, 020h, 0ah, 020h, 0ah, 0dfh, 0ch, 0dfh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 020h, 07h, 020h, 07h, 020h, 08h, 0dfh, 08h, 0dfh, 08h, 0b2h, 078h, 0dbh, 08h
        DB      0dbh, 08h, 0dbh, 08h, 0b2h, 08h, 0dch, 08h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 0deh, 06h, 020h, 06eh, 0deh, 06eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh
        DB      0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0ddh, 0eh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 09h, 020h, 09h, 0dbh, 01h, 020h, 019h, 0dbh, 09h
        DB      0dbh, 09h, 0dfh, 09h, 0b2h, 019h, 0dbh, 09h, 020h, 0ah, 020h, 0ah, 020h, 0ah, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 0b2h, 08h, 0dch, 08h, 0dch, 08h, 020h, 07h, 0dfh, 0ch, 0dfh, 0ch, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 08h, 0dfh, 08h
        DB      0dfh, 08h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 0dbh, 06h, 0b0h, 06eh, 0b2h, 06eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh
        DB      0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 09h, 020h, 09h, 0dbh, 01h, 020h, 019h, 0b2h, 019h, 0dbh, 09h
        DB      020h, 09h, 0dbh, 01h, 0b2h, 019h, 0ddh, 09h, 020h, 0ah, 020h, 0ah, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 0dfh, 08h, 0dfh, 08h, 0dfh, 08h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      0dch, 01h, 0dfh, 06h, 0dfh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh
        DB      0dbh, 0eh, 0dbh, 0eh, 0dfh, 0eh, 0dfh, 0eh, 0dch, 09h, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 09h, 0deh, 01h, 0dbh, 01h, 020h, 019h, 0b0h, 019h, 0dbh, 09h, 020h, 09h, 0b0h
        DB      019h, 0deh, 019h, 0dbh, 019h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh
        DB      01h, 0dbh, 01h, 0dfh, 019h, 0dch, 09h, 0dch, 09h, 0dch, 09h, 0dch, 09h, 0dch, 09h, 0dch, 09h, 0dch
        DB      09h, 0dbh, 09h, 0b2h, 019h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      09h, 0dbh, 01h, 020h, 019h, 020h, 019h, 020h, 019h, 0dfh, 019h, 0dbh, 09h, 020h, 09h, 020h, 019h
        DB      0b0h, 019h, 0dbh, 09h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 01h
        DB      0dbh, 01h, 0b0h, 019h, 0b2h, 019h, 0dbh, 09h, 020h, 09h, 020h, 019h, 0b2h, 019h, 0dbh, 09h, 0dbh
        DB      09h, 0dfh, 09h
	
frame3  DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 0dch, 06h, 0dch, 06h, 0dch, 06h, 0dch, 06h, 0dch, 06h, 0dch, 06h, 0dch, 0ch, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 06h, 020h, 06ch, 020h
        DB      06ch, 0b0h, 06ch, 0dch, 06ch, 0dch, 06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0b2h, 06ch, 0dch, 0ch, 0dch, 0ch, 020h, 0ch, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 06h, 020h, 06ch, 020h, 06ch, 0dch
        DB      06ch, 0b2h, 06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0b2h, 06ch, 0dch, 0ch, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 06h, 020h, 06ch, 0b0h, 06ch, 0b2h
        DB      06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh, 06h, 020h, 06ch, 0b2h, 06ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dfh, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 06h, 020h, 0ch, 020h
        DB      0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 0dch, 0ch, 020h, 0ch, 020h
        DB      0ch, 020h, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh, 06h, 020h, 06ch, 0b2h
        DB      06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch, 06h, 020h
        DB      0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 0dch, 06h, 0dbh, 0ch, 0dch, 0ch, 020h
        DB      0ch, 020h, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0eh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 06h, 0dbh
        DB      06h, 0dfh, 06ch, 0b2h, 06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch
        DB      06ch, 0dch, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 06ch, 0dfh, 0ch, 0dfh, 0ch, 0dch, 06h, 0dbh
        DB      0ch, 0dch, 0ch, 020h, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0eh, 020h, 0eh, 020h, 0eh, 020h, 0eh, 020h, 0eh, 020h, 0eh, 020h, 0eh, 020h
        DB      0eh, 020h, 0eh, 020h, 0eh, 020h, 0eh, 020h, 0eh, 020h, 0eh, 020h, 0eh, 020h, 0eh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 0dfh, 06h, 0dfh, 06h, 0dfh, 06ch, 0dfh, 06ch, 0b2h, 06ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 020h, 0ch, 020h, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0eh, 020h, 0eh, 020h, 0eh, 0dch, 06h, 0dch, 0ch, 0dch, 06ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch, 0ch, 0dch, 0ch, 020h, 0eh, 020h, 0eh, 020h, 0eh, 020h
        DB      0eh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 06ch, 020h, 06ch
        DB      0dfh, 06ch, 0b2h, 06ch, 0dfh, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 0ch, 0dfh, 0ch, 0dfh
        DB      0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0eh, 020h, 07h, 0dbh, 06h, 0deh, 06ch, 0dbh, 06ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0b2h, 06ch, 020h, 07h, 020h
        DB      0eh, 020h, 0eh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 02h, 0dch, 02h, 0dbh, 02h, 0dch, 0ah, 0dch, 0ah
        DB      0dch, 0ah, 0dch, 0ah, 0dbh, 0ah, 020h, 0ah, 020h, 0ah, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 0deh, 06h, 020h, 06ch, 0dfh, 0ch, 020h, 0ch, 020h, 07h, 0dfh, 0ch
        DB      0dbh, 0ch, 0dfh, 0ch, 020h, 0ch, 020h, 0ch, 0dfh, 0ch, 0dbh, 0ch, 0ddh, 0ch, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 0dbh, 02h, 020h, 02ah, 0b2h, 02ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah
        DB      0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0b2h, 02ah, 0dch, 0ah, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 07h, 020h, 07h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch
        DB      08h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 0b0h, 06ch, 0deh, 06ch, 0dch, 0ch, 0dch, 0ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dch, 0ch, 0dch, 0ch, 0dbh, 0ch, 0dbh, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      0dbh, 02h, 020h, 02ah, 0b2h, 02ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 02ah, 0dch, 0ah, 0dfh, 0ah
        DB      0dfh, 0ah, 0dfh, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0ddh, 0ah, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 08h, 0dfh, 08h, 0dfh, 08h, 0dfh, 08h, 0b2h, 08h, 0dbh
        DB      08h, 0dbh, 08h, 0b2h, 078h, 0dbh, 08h, 0dbh, 08h, 0dbh, 08h, 0dbh, 08h, 0dbh, 08h, 0dfh, 08h, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 06ch, 0b2h, 06ch, 0dch, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dfh, 0ch
        DB      0dch, 0ch, 0dbh, 0ch, 0b2h, 06ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh
        DB      02h, 0b0h, 02ah, 0dbh, 0ah, 0dbh, 0ah, 0dfh, 02h, 0b0h, 02ah, 0dfh, 02ah, 0dfh, 02ah, 0dfh
        DB      02ah, 0dbh, 0ah, 0dch, 0ah, 0dch, 0ah, 0dch, 0ah, 0dch, 0ah, 0dch, 0ah, 0dch, 0ah, 020h
        DB      07h, 0dch, 06h, 020h, 06ch, 0dch, 06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch, 0ch, 020h
        DB      07h, 020h, 08h, 020h, 08h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 06h, 0dfh, 0ch, 0dfh, 06ch, 0b2h, 06ch, 0dbh
        DB      0ch, 0dfh, 0ch, 0dfh, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0deh
        DB      02h, 0dbh, 02h, 0b0h, 02ah, 0b2h, 02ah, 0dbh, 0ah, 0dch, 0ah, 0dch, 0ah, 0dch, 0ah, 0dch
        DB      0ah, 0dfh, 02h, 0dfh, 02h, 0dfh, 02h, 0dfh, 02h, 0dfh, 02h, 0dfh, 02h, 0dfh, 02h, 020h, 07h, 0dfh
        DB      06h, 0b0h, 06ch, 0b1h, 06ch, 0b2h, 06ch, 0dbh, 0ch, 0dbh, 0ch, 0dfh, 0ch, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 0dch, 06h, 0dbh, 06h, 0b2h, 06eh, 0dch, 0eh, 0dch, 0eh, 0dch, 0eh, 0dch, 0eh
        DB      0dch, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dch, 0eh, 020h, 0eh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0ah
        DB      0dfh, 02h, 0dbh, 02h, 0b0h, 02ah, 0b2h, 02ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah
        DB      0dbh, 0ah, 0b2h, 02ah, 0dfh, 0ah, 020h, 0ah, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 020h, 07h, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0deh
        DB      06h, 020h, 06eh, 0deh, 06eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh
        DB      0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0ddh, 0eh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh
        DB      01h, 0dch, 01h, 0dfh, 02h, 0dfh, 02h, 0dfh, 0ah, 0dfh, 0ah, 0dfh, 0ah, 0dfh, 0ah, 0dfh, 0ah
        DB      0dch, 09h, 0dfh, 09h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh, 06h
        DB      0b0h, 06eh, 0b2h, 06eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh
        DB      0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 0dfh, 01h, 020h, 019h, 0deh, 019h, 0dbh, 019h, 0dbh, 09h, 0dbh, 09h, 0dbh, 09h, 0dbh, 09h
        DB      0dfh, 09h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 01h
        DB      0dfh, 06h, 0dfh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh
        DB      0dbh, 0eh, 0dfh, 0eh, 0dfh, 0eh, 0dch, 09h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 09h
        DB      020h, 09h, 0dbh, 01h, 020h, 019h, 0dbh, 09h, 0dbh, 09h, 0dfh, 09h, 0b2h, 019h, 0dbh, 09h, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 01h, 0dbh
        DB      01h, 0dfh, 019h, 0dch, 09h, 0dch, 09h, 0dch, 09h, 0dch, 09h, 0dch, 09h, 0dch, 09h, 0dch, 09h, 0dbh
        DB      09h, 0b2h, 019h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 09h, 020h, 09h, 0dbh
        DB      01h, 020h, 019h, 0b2h, 019h, 0dbh, 09h, 020h, 09h, 0dbh, 01h, 0b2h, 019h, 0ddh, 09h, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 01h, 0dbh, 01h
        DB      0b0h, 019h, 0b2h, 019h, 0dbh, 09h, 020h, 09h, 020h, 019h, 0b2h, 019h, 0dbh, 09h, 0dbh, 09h, 0dfh
        DB      09h
	
frame4  DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 0dch, 06h, 0dch, 06h, 0dch, 06h, 0dch, 06h, 0dch, 06h, 0dch, 06h, 0dch, 0ch, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 06h, 020h, 06ch, 020h
        DB      06ch, 0b0h, 06ch, 0dch, 06ch, 0dch, 06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0b2h, 06ch, 0dch, 0ch, 0dch, 0ch, 020h, 0ch, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 06h, 020h, 06ch, 020h, 06ch, 0dch
        DB      06ch, 0b2h, 06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0b2h, 06ch, 0dch, 0ch, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 06h, 020h, 06ch, 0b0h, 06ch, 0b2h
        DB      06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh, 06h, 020h, 06ch, 0b2h, 06ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dfh, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 06h, 020h, 0ch, 020h
        DB      0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 0dch, 0ch, 020h, 0ch, 020h
        DB      0ch, 020h, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh, 06h, 020h, 06ch, 0b2h
        DB      06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch, 06h, 020h
        DB      0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 0dch, 06h, 0dbh, 0ch, 0dch, 0ch, 020h
        DB      0ch, 020h, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 07h, 0dch, 07h, 0dch, 07h, 0dch, 07h
        DB      0dch, 07h, 020h, 07h, 020h, 07h, 0dch, 07h, 0dch, 07h, 0dch, 07h, 0dch, 07h, 020h, 07h, 0dch, 07h
        DB      0dch, 07h, 0dch, 07h, 0dch, 07h, 020h, 07h, 0dch, 07h, 0dch, 07h, 0dch, 07h, 0dch, 07h, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0eh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 06h, 0dbh, 06h, 0dfh, 06ch, 0b2h, 06ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch, 06ch, 0dch, 0ch, 0dch
        DB      0ch, 0dch, 0ch, 0dch, 06ch, 0dfh, 0ch, 0dfh, 0ch, 0dch, 06h, 0dbh, 0ch, 0dch, 0ch, 020h
        DB      0ch, 020h, 0ch, 0dbh, 07h, 0b2h, 07fh, 020h, 07h, 020h, 07h, 0deh, 07h, 0dbh, 07h, 0ddh, 07h
        DB      0deh, 07h, 0b0h, 07fh, 020h, 07h, 020h, 07h, 0dbh, 07h, 0ddh, 07h, 0b0h, 07fh, 0ddh, 07h, 020h
        DB      07h, 0dbh, 07h, 0ddh, 07h, 0dbh, 07h, 0ddh, 07h, 020h, 07h, 0dbh, 07h, 0ddh, 07h, 020h, 0eh, 020h
        DB      0eh, 020h, 0eh, 020h, 0eh, 020h, 0eh, 020h, 0eh, 020h, 0eh, 020h, 0eh, 020h, 0eh, 020h
        DB      0eh, 020h, 0eh, 020h, 0eh, 020h, 0eh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 06h, 0dfh, 06h, 0dfh
        DB      06ch, 0dfh, 06ch, 0b2h, 06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dfh, 0ch, 0dfh, 0ch
        DB      0dfh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch
        DB      0deh, 07h, 0dbh, 07h, 0dch, 07h, 0dch, 07h, 0dbh, 07h, 0dfh, 07h, 020h, 07h, 0deh, 07h, 0dbh, 07h
        DB      020h, 07h, 020h, 07h, 0b2h, 07h, 0ddh, 07h, 0dbh, 07h, 0ddh, 07h, 020h, 07h, 0b2h, 07h, 0ddh, 07h
        DB      0dbh, 07h, 0dbh, 07h, 0dch, 07h, 0dbh, 07h, 0ddh, 07h, 020h, 0eh, 0dch, 06h, 0dch, 0ch, 0dch
        DB      06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch, 0ch, 0dch, 0ch, 020h, 0eh, 020h
        DB      0eh, 020h, 0eh, 020h, 0eh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      06ch, 020h, 06ch, 0dfh, 06ch, 0b2h, 06ch, 0dfh, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 0ch
        DB      0dfh, 0ch, 0dfh, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 0deh, 07h, 0b2h, 07h
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 07h, 0dbh, 07h, 0dfh, 07h, 0dfh
        DB      07h, 0b0h, 07fh, 0ddh, 07h, 0dbh, 07h, 0ddh, 07h, 020h, 07h, 0dbh, 07h, 0ddh, 07h, 020h, 07h, 0dch
        DB      07h, 0dch, 07h, 0b2h, 07h, 020h, 07h, 0dbh, 06h, 0deh, 06ch, 0dbh, 06ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0b2h, 06ch, 020h, 07h, 020h, 0eh
        DB      020h, 0eh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 02h, 0dch, 02h, 0dbh, 02h, 0dch, 0ah, 0dch, 0ah, 0dch
        DB      0ah, 0dch, 0ah, 0dbh, 0ah, 020h, 0ah, 020h, 0ah, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 0deh, 06h, 020h, 06ch, 0dfh, 0ch, 020h, 0ch, 020h, 07h, 0dfh, 0ch, 0dbh
        DB      0ch, 0dfh, 0ch, 020h, 0ch, 020h, 0ch, 0dfh, 0ch, 0dbh, 0ch, 0ddh, 0ch, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 0dbh, 02h, 020h, 02ah, 0b2h, 02ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh
        DB      0ah, 0dbh, 0ah, 0dbh, 0ah, 0b2h, 02ah, 0dch, 0ah, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 07h, 020h, 07h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch
        DB      08h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 0dch, 07h, 0dch, 07h, 0dch, 07h, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      0b0h, 06ch, 0deh, 06ch, 0dch, 0ch, 0dch, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch
        DB      0ch, 0dch, 0ch, 0dbh, 0ch, 0dbh, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh, 02h, 020h
        DB      02ah, 0b2h, 02ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 02ah, 0dch, 0ah, 0dfh, 0ah, 0dfh, 0ah, 0dfh
        DB      0ah, 0dbh, 0ah, 0dbh, 0ah, 0ddh, 0ah, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 0dfh, 08h, 0dfh, 08h, 0dfh, 08h, 0dfh, 08h, 0b2h, 08h, 0dbh, 08h, 0dbh, 08h, 0b2h
        DB      078h, 0dbh, 08h, 0dbh, 08h, 0dbh, 08h, 0dbh, 08h, 0dbh, 08h, 0dfh, 08h, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 0dfh, 07h, 0dfh, 07h, 0dfh, 07h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      06ch, 0b2h, 06ch, 0dch, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dch, 0ch, 0dbh, 0ch
        DB      0b2h, 06ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh, 02h, 0b0h, 02ah, 0dbh
        DB      0ah, 0dbh, 0ah, 0dfh, 02h, 0b0h, 02ah, 0dfh, 02ah, 0dfh, 02ah, 0dfh, 02ah, 0dbh, 0ah, 0dch
        DB      0ah, 0dch, 0ah, 0dch, 0ah, 0dch, 0ah, 0dch, 0ah, 0dch, 0ah, 020h, 07h, 0dch, 06h, 020h
        DB      06ch, 0dch, 06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch, 0ch, 020h, 07h, 020h, 08h, 020h
        DB      08h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 0dfh, 06h, 0dfh, 0ch, 0dfh, 06ch, 0b2h, 06ch, 0dbh, 0ch, 0dfh, 0ch, 0dfh
        DB      0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0deh, 02h, 0dbh, 02h, 0b0h
        DB      02ah, 0b2h, 02ah, 0dbh, 0ah, 0dch, 0ah, 0dch, 0ah, 0dch, 0ah, 0dch, 0ah, 0dfh, 02h, 0dfh
        DB      02h, 0dfh, 02h, 0dfh, 02h, 0dfh, 02h, 0dfh, 02h, 0dfh, 02h, 020h, 07h, 0dfh, 06h, 0b0h, 06ch, 0b1h
        DB      06ch, 0b2h, 06ch, 0dbh, 0ch, 0dbh, 0ch, 0dfh, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 06h
        DB      0dbh, 06h, 0b2h, 06eh, 0dch, 0eh, 0dch, 0eh, 0dch, 0eh, 0dch, 0eh, 0dch, 0eh, 0dbh, 0eh
        DB      0dbh, 0eh, 0dch, 0eh, 020h, 0eh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0ah, 0dfh, 02h, 0dbh, 02h
        DB      0b0h, 02ah, 0b2h, 02ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0b2h, 02ah
        DB      0dfh, 0ah, 020h, 0ah, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 08h
        DB      0dch, 08h, 0dch, 08h, 0dch, 08h, 020h, 07h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0deh, 06h, 020h, 06eh, 0deh
        DB      06eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh
        DB      0eh, 0dbh, 0eh, 0ddh, 0eh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 01h, 0dch, 01h, 0dfh
        DB      02h, 0dfh, 02h, 0dfh, 0ah, 0dfh, 0ah, 0dfh, 0ah, 0dfh, 0ah, 0dfh, 0ah, 0dch, 09h, 0dfh, 09h
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh, 06h, 0b0h, 06eh, 0b2h, 06eh
        DB      0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh
        DB      0dbh, 0eh, 0dbh, 0eh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 01h, 020h, 019h
        DB      0deh, 019h, 0dbh, 019h, 0dbh, 09h, 0dbh, 09h, 0dbh, 09h, 0dbh, 09h, 0dfh, 09h, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 01h, 0dfh, 06h, 0dfh, 0eh, 0dbh
        DB      0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dfh, 0eh, 0dfh
        DB      0eh, 0dch, 09h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 09h, 020h, 09h, 0dbh, 01h, 020h, 019h
        DB      0dbh, 09h, 0dbh, 09h, 0dfh, 09h, 0b2h, 019h, 0dbh, 09h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 01h, 0dbh, 01h, 0dfh, 019h, 0dch, 09h, 0dch, 09h
        DB      0dch, 09h, 0dch, 09h, 0dch, 09h, 0dch, 09h, 0dch, 09h, 0dbh, 09h, 0b2h, 019h, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 09h, 020h, 09h, 0dbh, 01h, 020h, 019h, 0b2h, 019h, 0dbh, 09h
        DB      020h, 09h, 0dbh, 01h, 0b2h, 019h, 0ddh, 09h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 0dfh, 01h, 0dbh, 01h, 0b0h, 019h, 0b2h, 019h, 0dbh, 09h, 020h, 09h
        DB      020h, 019h, 0b2h, 019h, 0dbh, 09h, 0dbh, 09h, 0dfh, 09h

frame5  DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 0dch, 06h, 0dch, 06h, 0dch, 06h, 0dch, 06h, 0dch, 06h, 0dch, 06h, 0dch, 0ch, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 06h, 020h, 06ch, 020h
        DB      06ch, 0b0h, 06ch, 0dch, 06ch, 0dch, 06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0b2h, 06ch, 0dch, 0ch, 0dch, 0ch, 020h, 0ch, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 06h, 020h, 06ch, 020h, 06ch, 0dch
        DB      06ch, 0b2h, 06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0b2h, 06ch, 0dch, 0ch, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 06h, 020h, 06ch, 0b0h, 06ch, 0b2h
        DB      06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh, 06h, 020h, 06ch, 0b2h, 06ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dfh, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 06h, 020h, 0ch, 020h
        DB      0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 0dch, 0ch, 020h, 0ch, 020h
        DB      0ch, 020h, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch
        DB      04h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh, 06h, 020h, 06ch, 0b2h
        DB      06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch, 06h, 020h
        DB      0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 0dch, 06h, 0dbh, 0ch, 0dch, 0ch, 020h
        DB      0ch, 020h, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0eh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 04h, 0dch, 04ch, 0dch, 04h, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 06h, 0dbh
        DB      06h, 0dfh, 06ch, 0b2h, 06ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch
        DB      06ch, 0dch, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 06ch, 0dfh, 0ch, 0dfh, 0ch, 0dch, 06h, 0dbh
        DB      0ch, 0dch, 0ch, 020h, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0eh, 020h, 0eh, 020h, 0eh, 020h, 0eh, 020h, 0eh, 020h
        DB      0eh, 020h, 0eh, 020h, 0eh, 020h, 0eh, 020h, 0eh, 020h, 0eh, 020h, 0eh, 020h, 0eh, 020h
        DB      07h, 020h, 07h, 0dch, 0ch, 020h, 07h, 020h, 07h, 0dfh, 04h, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 0dfh, 06h, 0dfh, 06h, 0dfh, 06ch, 0dfh, 06ch, 0b2h, 06ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 020h, 0ch, 020h, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0eh, 0dch, 06h, 0dch, 0ch, 0dch, 06ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch, 0ch, 0dch, 0ch, 020h, 0eh, 020h, 0eh, 0dch, 04h, 020h
        DB      0eh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 04h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch
        DB      04h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 06ch, 020h, 06ch
        DB      0dfh, 06ch, 0b2h, 06ch, 0dfh, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 0ch, 0dfh, 0ch, 0dfh
        DB      0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh, 06h, 0b0h, 06ch, 0b2h, 06ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch, 04ch, 0dch, 04ch, 0dbh, 0ch, 0dfh, 0ch, 020h, 07h, 020h
        DB      0eh, 020h, 0eh, 0b0h, 04ch, 0dch, 04h, 0dbh, 04h, 0b0h, 04ch, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 02h, 0dch, 02h, 0dbh, 02h, 0dch, 0ah, 0dch, 0ah
        DB      0dch, 0ah, 0dch, 0ah, 0dbh, 0ah, 020h, 0ah, 020h, 0ah, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 06h, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 0deh, 06h, 020h, 06ch, 0dfh, 0ch, 020h, 0ch, 020h, 07h, 0dfh, 0ch
        DB      0dfh, 04ch, 0dfh, 0ch, 020h, 04h, 0dch, 04h, 0dch, 04h, 020h, 04h, 020h, 04h, 0dfh, 04h, 0dfh
        DB      04h, 0dfh, 04h, 0dch, 04h, 020h, 04h, 020h, 04h, 020h, 07h, 020h, 07h, 0dfh, 04h, 020h, 07h, 020h
        DB      07h, 0dbh, 04h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 0dbh, 02h, 020h, 02ah, 0b2h, 02ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh
        DB      0ah, 0dbh, 0ah, 0b2h, 02ah, 0dch, 0ah, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 07h, 020h, 07h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch
        DB      08h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 06h, 0dfh, 06h, 020h, 06h, 0dfh, 06h, 020h, 06h
        DB      0deh, 06ch, 0dch, 0ch, 0dch, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch, 0ch, 0dch
        DB      04h, 020h, 0ch, 020h, 0ch, 0dfh, 04h, 0dbh, 04h, 0b0h, 04ch, 0dch, 04h, 020h, 04h, 0dfh, 04h, 0dbh
        DB      04h, 0dch, 04h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh, 02h, 020h, 02ah, 0b2h, 02ah, 0dbh
        DB      0ah, 0dbh, 0ah, 0dbh, 02ah, 0dch, 0ah, 0dfh, 0ah, 0dfh, 0ah, 0dfh, 0ah, 0dbh, 0ah, 0dbh
        DB      0ah, 0ddh, 0ah, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh
        DB      08h, 0dfh, 08h, 0dfh, 08h, 0dfh, 08h, 0b2h, 08h, 0dbh, 08h, 0dbh, 08h, 0b2h, 078h, 0dbh, 08h, 0dbh
        DB      08h, 0dbh, 08h, 0dbh, 08h, 0dbh, 08h, 0dfh, 08h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 06h, 020h, 07h, 020h, 07h, 020h, 06h, 020h, 06ch, 0b2h, 06ch
        DB      0dch, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dch, 0ch, 0dbh, 0ch, 0dch, 04ch, 0dch, 0ch
        DB      020h, 07h, 020h, 07h, 0dfh, 04h, 0dch, 04ch, 0dbh, 04h, 0dch, 04h, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 0dbh, 02h, 0b0h, 02ah, 0dbh, 0ah, 0dbh, 0ah, 0dfh, 02h, 0b0h
        DB      02ah, 0dfh, 02ah, 0dfh, 02ah, 0dfh, 02ah, 0dbh, 0ah, 0dch, 0ah, 0dch, 0ah, 0dch, 0ah, 0dch
        DB      0ah, 0dch, 0ah, 0dch, 0ah, 020h, 07h, 0dch, 06h, 020h, 06ch, 0dch, 06ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dch, 0ch, 020h, 07h, 020h, 08h, 020h, 08h, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 06h, 0dfh, 06h, 020h, 07h, 0dfh, 06h, 0dfh, 0ch, 0dfh
        DB      06ch, 0b2h, 06ch, 0dbh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 020h, 07h, 020h, 07h, 0dfh, 04h, 020h
        DB      07h, 0dch, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 04h, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 0deh, 02h, 0dbh, 02h, 0b0h, 02ah, 0b2h, 02ah, 0dbh, 0ah, 0dch, 0ah, 0dch
        DB      0ah, 0dch, 0ah, 0dch, 0ah, 0dfh, 02h, 0dfh, 02h, 0dfh, 02h, 0dfh, 02h, 0dfh, 02h, 0dfh, 02h, 0dfh
        DB      02h, 020h, 07h, 0dfh, 06h, 0b0h, 06ch, 0b1h, 06ch, 0b2h, 06ch, 0dbh, 0ch, 0dbh, 0ch, 0dfh
        DB      0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 0dch, 06h, 0dbh, 06h, 0b2h, 06eh, 0dch, 0eh, 0dch, 0eh, 0dch
        DB      0eh, 0dch, 0eh, 0dch, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dch, 0eh, 020h, 0eh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 0dch, 04h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0ah, 0dfh, 02h, 0dbh, 02h, 0b0h, 02ah, 0b2h, 02ah, 0dbh, 0ah, 0dbh, 0ah, 0dbh
        DB      0ah, 0dbh, 0ah, 0dbh, 0ah, 0b2h, 02ah, 0dfh, 0ah, 020h, 0ah, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 020h, 07h, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 0deh, 06h, 020h, 06eh, 0deh, 06eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh
        DB      0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0ddh, 0eh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 0dfh, 04h, 0dfh, 04ch, 0dfh, 04h, 020h, 07h, 020h, 07h, 0dfh, 04h, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 0dfh, 01h, 0dch, 01h, 0dfh, 02h, 0dfh, 02h, 0dfh, 0ah, 0dfh, 0ah, 0dfh, 0ah, 0dfh
        DB      0ah, 0dfh, 0ah, 0dch, 09h, 0dfh, 09h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 0dbh, 06h, 0b0h, 06eh, 0b2h, 06eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh
        DB      0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 04h, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 0dfh, 01h, 020h, 019h, 0deh, 019h, 0dbh, 019h, 0dbh, 09h, 0dbh, 09h, 0dbh, 09h
        DB      0dbh, 09h, 0dfh, 09h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      0dch, 01h, 0dfh, 06h, 0dfh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh, 0dbh, 0eh
        DB      0dbh, 0eh, 0dbh, 0eh, 0dfh, 0eh, 0dfh, 0eh, 0dch, 09h, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 09h, 020h, 09h, 0dbh, 01h, 020h, 019h, 0dbh, 09h, 0dbh, 09h, 0dfh, 09h, 0b2h, 019h, 0dbh
        DB      09h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh
        DB      01h, 0dbh, 01h, 0dfh, 019h, 0dch, 09h, 0dch, 09h, 0dch, 09h, 0dch, 09h, 0dch, 09h, 0dch, 09h, 0dch
        DB      09h, 0dbh, 09h, 0b2h, 019h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 09h, 020h
        DB      09h, 0dbh, 01h, 020h, 019h, 0b2h, 019h, 0dbh, 09h, 020h, 09h, 0dbh, 01h, 0b2h, 019h, 0ddh, 09h, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 01h, 0dbh
        DB      01h, 0b0h, 019h, 0b2h, 019h, 0dbh, 09h, 020h, 09h, 020h, 019h, 0b2h, 019h, 0dbh, 09h, 0dbh, 09h
        DB      0dfh, 09h
	
frame6  DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      0dch, 04h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 04h, 0dch, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 0ch
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 04h, 0b0h, 04ch
        DB      0deh, 04ch, 0dbh, 0ch, 0dch, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch
        DB      0dch, 04h, 0dch, 04ch, 0b2h, 04ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dch, 0ch, 0dch, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 04h, 0dch, 04h
        DB      0dch, 04h, 0dch, 04h, 0dch, 04h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh, 04h, 0b2h
        DB      04ch, 0dbh, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 04h, 0dch, 0ch, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 04ch, 0b2h
        DB      04ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 04h, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 0dch, 04h, 0b0h, 04ch, 0dbh, 04h, 0dbh, 04h, 0dbh, 04h, 020h, 04ch, 0dch, 04ch
        DB      0dch, 04ch, 0dch, 04ch, 0dbh, 0ch, 0b2h, 04ch, 0dch, 0ch, 020h, 0ch, 020h, 0ch, 0dfh, 04h
        DB      020h, 0ch, 020h, 0ch, 0dch, 04h, 0dch, 0ch, 0dch, 04ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch, 04ch, 0dch, 0ch, 0b2h, 04ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0ch, 0dch, 04h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      0dbh, 04h, 0dbh, 04h, 0dbh, 04h, 0dbh, 04h, 0dch, 04ch, 0dbh, 04ch, 0dbh, 04ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0b2h, 04ch, 020h, 0ch, 020h, 0ch, 020h
        DB      0ch, 0dbh, 04h, 0b2h, 04ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0ddh, 0ch, 020h, 0ch, 0dch, 04h, 0dch
        DB      04ch, 0dfh, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh, 04h, 0dbh
        DB      04h, 0dbh, 04h, 0dch, 04ch, 0b2h, 04ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch, 0ch, 0dch
        DB      04ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0ddh, 0ch, 020h, 0ch, 0dfh, 0ch, 020h
        DB      0ch, 020h, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 0ch, 020h, 0ch, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0deh, 04h, 0dbh, 04h, 020h
        DB      04ch, 0dch, 04ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dfh, 0ch, 0dfh, 0ch, 0dbh, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dch, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0deh, 04h, 0b0h, 04ch, 0dbh
        DB      04h, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 020h, 0ch, 020h
        DB      0ch, 0b2h, 040h, 020h, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dfh
        DB      0ch, 0dfh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dbh, 0ch, 0dch, 0ch, 020h, 0ch, 0dfh, 0ch, 0dfh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dch, 0ch, 020h, 0ch, 020h, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 020h, 0ch, 020h
        DB      0ch, 0dch, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0b0h, 04ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch, 0ch, 020h, 0ch, 020h, 0ch, 0dch, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 020h, 0ch, 0b2h, 040h, 0dbh
        DB      0ch, 0dbh, 0ch, 0dch, 0ch, 020h, 0ch, 020h, 0ch, 0dbh, 0ch, 020h, 0ch, 020h, 0ch, 0dfh
        DB      0ch, 0dfh, 0ch, 0dfh, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 0dbh
        DB      0ch, 0dfh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0b2h, 040h, 020h, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 020h, 0ch, 020h
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0b2h, 04ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 0dch, 04h, 0dbh, 04h, 0dch, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0b1h
        DB      04ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h
        DB      0ch, 020h, 0ch, 020h, 0ch, 0b2h, 040h, 0dfh, 0ch, 0dbh, 0ch, 020h, 0ch, 020h, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 020h, 0ch, 020h, 0ch, 0dbh, 0ch, 020h, 0ch, 020h, 0ch, 0dch
        DB      0ch, 0dch, 0ch, 0dch, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 020h, 0ch, 0b2h
        DB      040h, 020h, 0ch, 020h, 0ch, 0dch, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 020h, 0ch, 020h, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 0ch, 0b2h, 040h, 020h
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0b2h, 04ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0ch, 020h
        DB      0ch, 0b0h, 04ch, 0dbh, 04h, 0dbh, 0ch, 0dbh, 0ch, 0dch, 0ch, 020h, 0ch, 020h, 0ch, 020h
        DB      0ch, 0dfh, 0ch, 0dfh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dch, 0ch, 020h, 0ch, 020h, 0ch, 0dbh, 0ch, 020h, 0ch, 020h, 0ch, 0dfh
        DB      0ch, 0dfh, 0ch, 020h, 0ch, 0b2h, 040h, 0dch, 0ch, 0dbh, 0ch, 020h, 0ch, 020h, 0ch, 0dbh
        DB      0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h
        DB      0ch, 0dch, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 020h
        DB      0ch, 0dfh, 0ch, 020h, 0ch, 020h, 0ch, 0dbh, 0ch, 0dfh, 04ch, 0b2h, 04ch, 0dch, 0ch, 0dch
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0b2h
        DB      04ch, 020h, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 0dfh, 04h, 0dfh, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 04h, 0dch
        DB      04h, 0dbh, 04h, 0dch, 04ch, 0dbh, 0ch, 0dbh, 0ch, 020h, 0ch, 020h, 0ch, 0dfh, 0ch, 0dfh
        DB      0ch, 0dfh, 0ch, 0dfh, 0ch, 020h, 0ch, 020h, 0ch, 0dbh, 0ch, 020h, 0ch, 020h, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 020h, 0ch, 0b2h, 040h, 0dbh
        DB      0ch, 020h, 0ch, 0b2h, 040h, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch, 0ch, 020h, 0ch, 020h
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch, 0ch, 020h
        DB      0ch, 0b2h, 040h, 020h, 0ch, 020h, 0ch, 0dbh, 0ch, 0dch, 0ch, 0dfh, 04h, 0dfh, 0ch, 0dfh
        DB      0ch, 0dfh, 04ch, 0b2h, 04ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0b2h, 04ch, 020h
        DB      0ch, 020h, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 04h, 0dbh, 04h, 0dch
        DB      04ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch
        DB      0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 0ch, 0dbh, 0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch, 0ch, 020h, 0ch, 020h, 0ch, 0dbh
        DB      0ch, 020h, 0ch, 020h, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 020h, 0ch, 020h
        DB      0ch, 0dbh, 0ch, 020h, 0ch, 020h, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 0dfh, 0ch, 020h
        DB      0ch, 020h, 0ch, 020h, 0ch, 020h, 0ch, 0dfh, 0ch, 0dbh, 0ch, 0b2h, 04ch, 0dch, 0ch, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 0dfh, 04h, 0dfh, 0ch, 0dfh, 0ch, 020h, 0ch, 020h, 0ch, 020h
        DB      0ch, 020h, 0ch, 020h, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0ch, 020h
        DB      0ch, 020h, 04h, 020h, 04h, 020h, 04h, 020h, 0ch, 0dbh, 04h, 0dbh, 04h, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 0ch, 0dch, 0ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0b2h, 04ch
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 04h, 0dch, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 0b0h, 04ch, 0dbh, 04h, 0b2h, 04ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0b2h, 04ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 04h, 0dfh, 04ch, 0dch, 0ch, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 0deh, 04h, 0dbh, 04h, 0dbh, 04h, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dfh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dfh, 0ch, 0dfh
        DB      0ch, 0dfh, 04ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0ddh, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 0ch, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 0dbh, 04h, 0dbh, 04h, 020h, 04ch, 0b2h, 04ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dfh, 0ch, 020h
        DB      04ch, 0dbh, 04ch, 0dbh, 04ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dch, 0ch, 020h, 0ch, 0dfh, 04h, 0dfh, 04ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dfh
        DB      0ch, 0dfh, 04ch, 0dfh, 04ch, 0dfh, 04ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0b2h
        DB      04ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 0dch, 04h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0ch, 0dfh, 04h, 0dbh, 04h, 0dbh, 04h, 0dfh, 04ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0b2h, 04ch, 0dfh, 0ch
        DB      020h, 0ch, 0dbh, 04h, 0b2h, 04ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 020h, 0ch, 020h, 0ch
        DB      0b0h, 04ch, 0dfh, 04ch, 0dfh, 04ch, 0b2h, 04ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dch, 0ch, 020h, 0ch, 0b0h, 04ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dch, 0ch, 020h, 0ch, 0dfh, 04h, 0b0h, 04ch, 0dfh, 04ch, 0b2h, 04ch, 0dbh, 0ch, 0dbh, 0ch
        DB      0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0b2h, 04ch, 0dfh, 0ch, 020h, 0ch
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 04h, 0dfh, 04h, 0dbh, 04h, 0dbh
        DB      04h, 0dfh, 04ch, 0dfh, 04ch, 0b2h, 04ch, 0dfh, 0ch, 0dfh, 0ch, 020h, 0ch, 020h, 0ch, 0dbh
        DB      04h, 020h, 04ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      04h, 0dfh, 04h, 020h, 04ch, 020h, 04ch, 0dfh, 04ch, 0dfh, 04ch, 0b2h, 04ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 020h, 0ch, 020h, 0ch, 0dbh, 04h, 0dfh, 04ch, 0b2h, 04ch, 0dbh
        DB      0ch, 0dbh, 0ch, 020h, 0ch, 020h, 0ch, 0dfh, 04h, 0dfh, 04h, 020h, 04ch, 020h, 04ch, 0dfh
        DB      04ch, 0dfh, 04ch, 0dfh, 04ch, 0dfh, 0ch, 0dfh, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh, 04h, 020h
        DB      04ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0ddh, 0ch, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0ch, 0dfh, 04h, 0dfh, 04h, 020h, 04ch, 020h, 04ch, 0dfh, 04ch, 0dfh
        DB      04ch, 0dbh, 0ch, 0dfh, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 04h, 0dfh, 04h, 0dfh
        DB      0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh, 04h, 020h, 04ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch, 0ch, 020h, 0ch, 020h
        DB      0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh, 04h, 0dch
        DB      0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 0ch, 0dch, 04h, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh, 04h, 020h, 04ch, 0deh
        DB      04ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dch
        DB      0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh, 04h, 0b2h, 04ch, 0dbh
        DB      0ch, 0dbh, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 0ch, 0dbh, 0ch, 0dch
        DB      04h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0b0h, 04ch, 020h
        DB      04ch, 0dfh, 04ch, 0b2h, 04ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 0dbh, 0ch, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dbh, 04h, 0b0h, 04ch, 0dbh, 0ch, 0dbh
        DB      0ch, 0dbh, 0ch, 0dbh, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 0dfh, 04h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh
        DB      04h, 0dbh, 04h, 0dbh, 04h, 0dfh, 04ch, 0dfh, 04ch, 0dfh, 0ch, 0dfh, 0ch, 020h, 0ch, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 04h, 0dfh, 0ch, 0dfh, 0ch
        DB      0dfh, 0ch, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh

frame7  DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch
        DB      08h, 0dch, 08h, 020h, 08h, 0dch, 0bh, 0dch, 0bh, 020h, 0bh, 020h, 0bh, 0dch, 0bh, 0dch, 0bh
        DB      0dch, 0fh, 0dch, 0bh, 020h, 0bh, 020h, 0bh, 0dbh, 0bh, 0dbh, 0fh, 0dch, 0bh, 0dch, 0fh
        DB      0dch, 0bh, 0dch, 0bh, 020h, 0bh, 0dch, 0bh, 0dbh, 0fh, 0dfh, 0fh, 0dfh, 0bh, 0b2h, 03bh
        DB      0dch, 0bh, 020h, 0bh, 0dch, 0bh, 0dbh, 0fh, 0dfh, 0fh, 0dfh, 0bh, 0dbh, 0bh, 0dch, 0bh
        DB      020h, 0bh, 020h, 0bh, 0dch, 0fh, 0dch, 0bh, 0dch, 0fh, 0dch, 0bh, 020h, 0bh, 020h, 0bh
        DB      0dch, 0bh, 0b2h, 03bh, 0dfh, 0fh, 0dfh, 0fh, 0b2h, 03bh, 0dch, 0fh, 020h, 0fh, 0b2h, 03bh
        DB      0dbh, 0fh, 0dch, 0bh, 0dch, 0fh, 0dch, 0fh, 0dch, 0bh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0bh
        DB      020h, 0bh, 020h, 0bh, 0dbh, 08h, 0b2h, 078h, 0dfh, 08h, 0dfh, 08h, 0dfh, 08h, 0dbh, 08h, 0b2h
        DB      08h, 020h, 08h, 0b1h, 03bh, 0b1h, 03bh, 020h, 0fh, 0b2h, 03bh, 0b2h, 03bh, 020h, 0fh, 020h
        DB      0fh, 0b2h, 03bh, 0b2h, 03bh, 020h, 0fh, 0b2h, 03bh, 0b2h, 03bh, 020h, 0fh, 020h, 0fh, 0dch
        DB      03h, 0dch, 03h, 020h, 03h, 0b2h, 03bh, 0b2h, 03bh, 020h, 0fh, 020h, 0fh, 0b1h, 03bh, 0b1h, 03bh
        DB      020h, 0fh, 0b2h, 03bh, 0b2h, 03bh, 020h, 0fh, 020h, 0fh, 0b2h, 03bh, 0b2h, 03bh, 020h, 0fh
        DB      0b2h, 03bh, 0b2h, 03bh, 020h, 0fh, 020h, 0fh, 0b2h, 03bh, 0b2h, 03bh, 020h, 0fh, 0b1h, 03bh
        DB      0b1h, 03bh, 020h, 0fh, 020h, 0fh, 0b1h, 03bh, 0b1h, 03bh, 020h, 0fh, 0b1h, 03bh, 0b1h, 03bh
        DB      020h, 0fh, 020h, 0fh, 0dch, 03h, 0dch, 03h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 03h, 020h, 03h
        DB      020h, 03h, 0dbh, 08h, 020h, 08h, 0b0h, 08h, 0b0h, 08h, 020h, 08h, 020h, 08h, 0b2h, 08h, 020h, 08h
        DB      0dch, 03h, 0dch, 03h, 020h, 03h, 0b1h, 03bh, 0b1h, 03bh, 020h, 0fh, 020h, 0fh, 0b1h, 03bh, 0b1h
        DB      03bh, 020h, 0fh, 0b1h, 03bh, 0b1h, 03bh, 020h, 0fh, 020h, 0fh, 0b0h, 03bh, 0b1h, 03bh, 020h
        DB      0fh, 0b1h, 03bh, 0b1h, 03bh, 0dch, 03h, 0dch, 03h, 0b1h, 03bh, 0dfh, 03h, 020h, 03h, 0b1h, 03bh
        DB      0b1h, 03bh, 0dch, 03h, 0dch, 03h, 0b1h, 03bh, 0dfh, 03h, 020h, 03h, 0b1h, 03bh, 0b1h, 03bh, 020h
        DB      0fh, 020h, 0fh, 0b1h, 03bh, 0b1h, 03bh, 020h, 0fh, 0b0h, 03bh, 0b0h, 03bh, 0dch, 03h, 0dch
        DB      03h, 0b0h, 03bh, 0b0h, 03bh, 020h, 0fh, 0b0h, 03bh, 0b0h, 03bh, 020h, 0fh, 020h, 0fh, 0b0h
        DB      03bh, 0b0h, 03bh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0bh, 020h, 0bh, 020h, 0bh, 0dbh, 08h, 0dbh
        DB      08h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dbh, 08h, 0b2h, 08h, 020h, 08h, 0b0h, 03bh, 0b0h, 03bh, 020h
        DB      0fh, 0b0h, 03bh, 0b0h, 03bh, 020h, 0fh, 020h, 0fh, 0b0h, 03bh, 0b0h, 03bh, 020h, 0fh, 0dfh
        DB      03h, 0b0h, 03bh, 0dch, 03h, 0dch, 03h, 0b0h, 03bh, 0dfh, 03h, 020h, 03h, 0dfh, 03h, 0b0h, 03bh, 0dch
        DB      03h, 0dch, 03h, 0dch, 03h, 0dch, 03h, 020h, 03h, 0b0h, 03bh, 0b0h, 03bh, 020h, 0fh, 020h, 0fh
        DB      0b0h, 03bh, 0dbh, 03h, 020h, 03h, 0b0h, 03bh, 0b0h, 03bh, 020h, 0fh, 020h, 0fh, 0b0h, 03bh
        DB      0dbh, 03h, 020h, 03h, 0dfh, 03h, 0dbh, 03h, 0dch, 03h, 0dch, 03h, 0dch, 03h, 0dch, 03h, 020h, 03h
        DB      0dfh, 03h, 0dbh, 03h, 0dch, 03h, 0dch, 03h, 0dbh, 03h, 0dfh, 03h, 020h, 03h, 020h, 03h, 0dbh, 03h
        DB      0dbh, 03h, 020h, 03h, 020h, 03h, 0dbh, 03h, 0dbh, 03h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 0dfh, 03h, 0dfh, 03h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 03h, 020h
        DB      03h, 020h, 03h, 0dch, 0bh, 0dch, 0bh, 020h, 0bh, 072h, 08h, 06ch, 08h, 021h, 08h, 020h, 08h, 020h
        DB      08h, 0dch, 0fh, 0dch, 0bh, 020h, 0bh, 0dch, 0bh, 0dch, 0fh, 020h, 0fh, 0b2h, 03bh, 0b2h
        DB      03bh, 020h, 0fh, 0b2h, 03bh, 0b2h, 03bh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 0b2h, 03bh, 0b2h, 03bh, 0dch, 0bh, 0dch, 0fh, 0dch, 0fh, 020h, 0fh, 020h, 0fh, 0b2h
        DB      03bh, 0b2h, 03bh, 020h, 0fh, 020h, 0fh, 0dch, 0fh, 0dch, 0bh, 0dch, 0fh, 0dch, 0bh, 020h
        DB      0bh, 020h, 0bh, 0dch, 0fh, 0dch, 0bh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 0dch, 0bh, 0dch, 0bh, 020h, 0bh, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch, 08h
        DB      0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch, 08h, 0dch, 08h
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 08h, 020h, 08h, 020h, 08h, 0b2h, 03bh, 0b2h
        DB      03bh, 020h, 0fh, 020h, 0fh, 0dch, 03h, 0dch, 03h, 020h, 03h, 020h, 03h, 0b2h, 03bh, 0b2h, 03bh
        DB      020h, 0fh, 0b2h, 03bh, 0b2h, 03bh, 020h, 0fh, 0b1h, 03bh, 0b1h, 03bh, 020h, 0fh, 0b1h, 03bh
        DB      0b1h, 03bh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0b1h, 03bh, 0b1h, 03bh
        DB      020h, 0fh, 020h, 0fh, 0b1h, 03bh, 0b1h, 03bh, 020h, 0fh, 0b1h, 03bh, 0b1h, 03bh, 020h, 0fh
        DB      0b2h, 03bh, 0b2h, 03bh, 020h, 0fh, 020h, 0fh, 0b2h, 03bh, 0b2h, 03bh, 020h, 0fh, 0b2h, 03bh
        DB      0b2h, 03bh, 020h, 0fh, 020h, 0fh, 0dch, 03h, 0dch, 03h, 020h, 03h, 020h, 03h, 0b2h, 03bh, 0b2h
        DB      03bh, 020h, 0fh, 0b2h, 08h, 0dbh, 08h, 0dfh, 08h, 020h, 08h, 0dfh, 08h, 0dfh, 08h, 0dfh, 08h, 0dbh
        DB      08h, 0dfh, 08h, 0dbh, 08h, 0dfh, 08h, 0dbh, 08h, 0b2h, 08h, 0b1h, 08h, 0b0h, 08h, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 08h, 020h, 08h, 020h, 08h, 0b1h, 03bh, 0b1h, 03bh, 020h, 0fh, 020h, 0fh, 0b0h, 03bh
        DB      0b0h, 03bh, 020h, 0fh, 020h, 0fh, 0b1h, 03bh, 0b1h, 03bh, 020h, 0fh, 0dch, 03h, 0dch, 03h
        DB      020h, 03h, 0b0h, 03bh, 0b0h, 03bh, 020h, 0fh, 0b0h, 03bh, 0b0h, 03bh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 0b0h, 03bh, 0b0h, 03bh, 020h, 0fh, 020h, 0fh, 0b0h, 03bh
        DB      0b0h, 03bh, 020h, 0fh, 0b0h, 03bh, 0b0h, 03bh, 020h, 0fh, 0b1h, 03bh, 0b1h, 03bh, 020h, 0fh
        DB      020h, 0fh, 0b1h, 03bh, 0b1h, 03bh, 020h, 0fh, 0b1h, 03bh, 0b1h, 03bh, 020h, 0fh, 020h, 0fh
        DB      0b1h, 03bh, 0b1h, 03bh, 020h, 0fh, 020h, 0fh, 0b1h, 03bh, 0b1h, 03bh, 020h, 0fh, 0b2h, 08h
        DB      0dbh, 08h, 0dbh, 08h, 020h, 08h, 0b2h, 08h, 0b2h, 08h, 0b2h, 078h, 0b2h, 078h, 0b2h, 078h
        DB      0dbh, 08h, 0dbh, 08h, 0dbh, 08h, 0b2h, 08h, 0b1h, 08h, 0b0h, 08h, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      08h, 020h, 08h, 020h, 08h, 0dfh, 03h, 0b0h, 03bh, 0dch, 03h, 0dch, 03h, 0dbh, 03h, 0dbh, 03h, 0dch
        DB      03h, 0dch, 03h, 0b0h, 03bh, 0dfh, 03h, 020h, 03h, 0dbh, 03h, 0dbh, 03h, 020h, 03h, 0dbh, 03h, 0dbh
        DB      03h, 020h, 03h, 0dbh, 03h, 0dbh, 03h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      0dfh, 03h, 0dbh, 03h, 0dch, 03h, 0dch, 03h, 0dbh, 03h, 0dfh, 03h, 020h, 03h, 0dbh, 03h, 0dbh, 03h
        DB      020h, 03h, 0dfh, 03h, 0b0h, 03bh, 0dch, 03h, 0dch, 03h, 0b0h, 03bh, 0dfh, 03h, 020h, 03h, 0dfh
        DB      03h, 0b0h, 03bh, 0dch, 03h, 0dch, 03h, 0b0h, 03bh, 0b0h, 03bh, 0dch, 03h, 0dch, 03h, 0b0h, 03bh
        DB      0dfh, 03h, 020h, 03h, 0dbh, 08h, 0dbh, 08h, 0dbh, 08h, 0dfh, 08h, 0dbh, 08h, 0dbh, 08h, 0dbh, 08h
        DB      0dbh, 08h, 0dbh, 08h, 0dbh, 08h, 0dbh, 08h, 0dbh, 08h, 0dbh, 08h, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 08h, 020h, 08h, 020h, 08h, 0b2h, 03bh, 0b2h, 03bh, 020h, 0fh, 020h, 0fh
        DB      0b2h, 03bh, 0b2h, 03bh, 020h, 0fh, 0dch, 0fh, 0b2h, 03bh, 0dfh, 0bh, 0dfh, 0fh, 0b2h, 03bh
        DB      0dch, 0bh, 020h, 0bh, 0b2h, 03bh, 0b2h, 03bh, 020h, 0fh, 020h, 0fh, 0b2h, 03bh, 0b2h, 03bh
        DB      020h, 0fh, 0dch, 0fh, 0b2h, 03bh, 0dfh, 0fh, 0dfh, 0fh, 0b2h, 03bh, 0dch, 0bh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0b2h, 03bh, 0b2h, 03bh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dch, 0bh, 0b2h, 03bh, 0dfh, 0bh, 0dfh, 0bh
        DB      0b2h, 03bh, 0dch, 0bh, 020h, 0bh, 0dfh, 0bh, 0dfh, 0bh, 0dfh, 0bh, 0dfh, 0bh, 0b2h, 03bh
        DB      0dch, 0bh, 020h, 0bh, 0b2h, 03bh, 0b2h, 03bh, 020h, 0fh, 0dch, 0bh, 0dbh, 0bh, 0dfh, 0fh
        DB      0dfh, 0fh, 0dbh, 0bh, 0dch, 0fh, 020h, 0fh, 0dch, 0bh, 0b2h, 03bh, 0dfh, 0bh, 0dfh, 0fh
        DB      0dbh, 0fh, 0dbh, 0bh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0bh, 020h, 0bh, 020h, 0bh, 0b1h, 03bh, 0b1h, 03bh, 020h, 0fh, 020h, 0fh
        DB      0b1h, 03bh, 0b1h, 03bh, 020h, 0fh, 0b1h, 03bh, 0b1h, 03bh, 020h, 0fh, 020h, 0fh, 0b1h, 03bh
        DB      0b1h, 03bh, 020h, 0fh, 0b1h, 03bh, 0b1h, 03bh, 020h, 0fh, 020h, 0fh, 0b1h, 03bh, 0b1h, 03bh
        DB      020h, 0fh, 0b1h, 03bh, 0b1h, 03bh, 020h, 0fh, 020h, 0fh, 0b1h, 03bh, 0b1h, 03bh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0b1h, 03bh, 0b1h, 03bh, 0dfh, 03h
        DB      0dfh, 03h, 0b1h, 03bh, 0dch, 03h, 020h, 03h, 0b1h, 03bh, 0b1h, 03bh, 020h, 0fh, 020h, 0fh, 0b1h
        DB      03bh, 0b1h, 03bh, 020h, 0fh, 0b2h, 03bh, 0b2h, 03bh, 0dfh, 03h, 0dfh, 03h, 0b1h, 03bh, 0b1h
        DB      03bh, 020h, 0fh, 0b1h, 03bh, 0b1h, 03bh, 020h, 0fh, 0b2h, 03bh, 0b2h, 03bh, 020h, 0fh, 020h
        DB      0fh, 0b2h, 03bh, 0b2h, 03bh, 020h, 0fh, 0dfh, 03h, 0b1h, 03bh, 0dch, 03h, 0dch, 03h, 0dch, 03h
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 03h, 020h, 03h, 020h, 03h, 020h, 03h, 0dfh, 03h, 0dfh, 03h, 0dfh, 03h, 0b0h, 03bh, 0b0h, 03bh
        DB      020h, 0fh, 0b0h, 03bh, 0b0h, 03bh, 020h, 0fh, 020h, 0fh, 0b0h, 03bh, 0b0h, 03bh, 020h, 0fh
        DB      0b0h, 03bh, 0b0h, 03bh, 020h, 0fh, 020h, 0fh, 0b0h, 03bh, 0b0h, 03bh, 020h, 0fh, 0b0h, 03bh
        DB      0b0h, 03bh, 0dch, 03h, 0dch, 03h, 0b0h, 03bh, 0dfh, 03h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 0b0h, 03bh, 0b0h, 03bh, 020h, 0fh, 020h, 0fh, 0b0h, 03bh, 0b0h
        DB      03bh, 020h, 0fh, 0b0h, 03bh, 0b0h, 03bh, 0dch, 03h, 0dch, 03h, 0b0h, 03bh, 0dfh, 03h, 020h, 03h
        DB      0b1h, 03bh, 0b1h, 03bh, 020h, 0fh, 020h, 0fh, 0b0h, 03bh, 0b0h, 03bh, 020h, 0fh, 0dch, 03h
        DB      0dch, 03h, 020h, 03h, 0b1h, 03bh, 0b1h, 03bh, 020h, 0fh, 020h, 0fh, 0b1h, 03bh, 0b1h, 03bh
        DB      020h, 0fh, 0dch, 03h, 0dch, 03h, 020h, 03h, 020h, 03h, 0b0h, 03bh, 0b0h, 03bh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0bh, 020h, 0bh, 0dfh
        DB      03h, 0dbh, 03h, 0dch, 03h, 0dch, 03h, 0dch, 03h, 0dbh, 03h, 0dfh, 03h, 020h, 03h, 0dfh, 03h, 0dbh
        DB      03h, 0dch, 03h, 0dch, 03h, 0dbh, 03h, 0dfh, 03h, 020h, 03h, 0dfh, 03h, 0dbh, 03h, 0dch, 03h, 0dch
        DB      03h, 0dbh, 03h, 0dfh, 03h, 020h, 03h, 0dbh, 03h, 0dbh, 03h, 020h, 03h, 020h, 03h, 0dbh, 03h, 0dbh
        DB      03h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 03h, 0dbh
        DB      03h, 0dch, 03h, 0dch, 03h, 0dbh, 03h, 0dfh, 03h, 020h, 03h, 0dbh, 03h, 0dbh, 03h, 020h, 03h, 020h
        DB      03h, 0dbh, 03h, 0dbh, 03h, 020h, 03h, 0dfh, 03h, 0b0h, 03bh, 0dch, 03h, 0dch, 03h, 0dbh, 03h, 0dfh
        DB      03h, 020h, 03h, 0b0h, 03bh, 0b0h, 03bh, 020h, 0fh, 0b0h, 03bh, 0b0h, 03bh, 020h, 0fh, 020h
        DB      0fh, 0b0h, 03bh, 0b0h, 03bh, 020h, 0fh, 0dfh, 03h, 0dbh, 03h, 0dch, 03h, 0dch, 03h, 0dbh, 03h
        DB      0dfh, 03h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 03h, 0dfh, 03h, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 0dfh, 03h
        DB      0dfh, 03h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 03h, 020h, 03h, 020h, 03h, 0dch, 0bh, 0b2h, 03bh, 0dfh, 0fh, 0dfh, 0bh, 0b2h, 03bh, 0dch
        DB      0bh, 020h, 0bh, 0b2h, 03bh, 0b2h, 03bh, 020h, 0fh, 020h, 0fh, 0b2h, 03bh, 0b2h, 03bh, 020h
        DB      0fh, 0b2h, 03bh, 0b2h, 03bh, 0dch, 0bh, 0dch, 0fh, 0dch, 0fh, 0dch, 0bh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 06ch, 08h, 065h, 08h, 074h, 07h, 020h, 07h
        DB      074h, 07h, 068h, 07h, 065h, 07h, 020h, 07h, 062h, 07h, 062h, 07h, 073h, 07h, 020h, 07h, 073h, 07h
        DB      063h, 07h, 065h, 07h, 06eh, 0fh, 065h, 0fh, 020h, 0fh, 072h, 0fh, 069h, 0fh, 073h, 0fh
        DB      065h, 0fh, 020h, 0fh, 061h, 0fh, 067h, 07h, 061h, 07h, 069h, 07h, 06eh, 07h, 020h, 07h, 061h
        DB      07h, 06eh, 07h, 064h, 07h, 020h, 07h, 072h, 07h, 075h, 07h, 06ch, 08h, 065h, 08h, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 08h, 020h, 08h, 020h, 08h, 0b1h, 03bh
        DB      0b1h, 03bh, 020h, 0fh, 020h, 0fh, 0b1h, 03bh, 0b1h, 03bh, 020h, 0fh, 0b1h, 03bh, 0b1h, 03bh
        DB      020h, 0fh, 020h, 0fh, 0b1h, 03bh, 0b1h, 03bh, 020h, 0fh, 0b1h, 03bh, 0b1h, 03bh, 020h, 0fh
        DB      020h, 0fh, 0dch, 03h, 0dch, 03h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 06ch, 08h, 069h, 08h, 06bh, 07h, 065h, 07h, 020h, 07h, 069h, 07h, 074h, 07h, 020h, 07h
        DB      077h, 07h, 061h, 07h, 073h, 07h, 020h, 07h, 062h, 07h, 061h, 07h, 063h, 07h, 06bh, 0fh, 020h, 0fh
        DB      069h, 0fh, 06eh, 0fh, 020h, 0fh, 074h, 0fh, 068h, 0fh, 065h, 0fh, 020h, 0fh, 067h, 07h
        DB      06fh, 07h, 06fh, 07h, 064h, 07h, 020h, 07h, 06fh, 07h, 06ch, 07h, 064h, 07h, 020h, 07h, 064h, 07h
        DB      061h, 07h, 079h, 08h, 073h, 08h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 08h, 020h, 08h, 020h, 08h, 0b0h, 03bh, 0b0h, 03bh, 020h, 0fh, 020h, 0fh, 0b0h, 03bh
        DB      0b0h, 03bh, 020h, 0fh, 0b0h, 03bh, 0b0h, 03bh, 020h, 0fh, 020h, 0fh, 0b0h, 03bh, 0b0h, 03bh
        DB      020h, 0fh, 0b0h, 03bh, 0b0h, 03bh, 020h, 0fh, 020h, 0fh, 0b0h, 03bh, 0b0h, 03bh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0bh, 020h, 0bh, 020h, 0bh, 0dfh, 03h, 0dbh, 03h, 0dch, 03h, 0dch, 03h, 0dbh, 03h, 0dfh
        DB      03h, 020h, 03h, 0dfh, 03h, 0dbh, 03h, 0dch, 03h, 0dch, 03h, 0dbh, 03h, 0dfh, 03h, 020h, 03h, 0dfh
        DB      03h, 0dbh, 03h, 0dch, 03h, 0dch, 03h, 0dbh, 03h, 0dfh, 03h, 020h, 03h, 020h, 03h, 0b0h, 03bh, 0dbh
        DB      03h, 020h, 03h, 020h, 03h, 0dbh, 03h, 0dbh, 03h, 020h, 03h, 020h, 03h, 0dbh, 03h, 0dbh, 03h, 020h
        DB      03h, 020h, 03h, 066h, 08h, 075h, 08h, 063h, 08h, 06bh, 08h, 020h, 08h, 06fh, 08h, 066h, 08h, 066h
        DB      08h, 020h, 08h, 061h, 08h, 06ch, 08h, 06ch, 08h, 020h, 08h, 079h, 08h, 06fh, 08h, 075h, 08h, 020h
        DB      08h, 077h, 08h, 069h, 08h, 06dh, 08h, 070h, 08h, 079h, 08h, 020h, 08h, 077h, 08h, 06fh, 08h, 06dh
        DB      08h, 062h, 08h, 061h, 08h, 074h, 08h, 073h, 08h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh

frame8  DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 02eh, 08h, 020h, 07h, 02eh, 07h, 020h, 07h, 02eh, 0fh, 020h, 07h, 063h, 08h, 020h
        DB      08h, 072h, 08h, 020h, 08h, 065h, 08h, 020h, 08h, 064h, 08h, 020h, 08h, 069h, 08h, 020h, 08h, 074h
        DB      08h, 020h, 08h, 073h, 08h, 020h, 07h, 02eh, 0fh, 020h, 07h, 02eh, 07h, 020h, 07h, 02eh, 08h, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 02eh, 08h, 020h, 07h, 02eh, 07h, 020h, 07h, 02eh, 0fh
        DB      020h, 08h, 063h, 08h, 06fh, 08h, 064h, 08h, 065h, 08h, 020h, 0fh, 02eh, 0fh, 020h, 07h, 02eh
        DB      07h, 020h, 07h, 02eh, 08h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 076h, 07h, 069h, 07h
        DB      06fh, 07h, 06ch, 07h, 061h, 07h, 074h, 07h, 06fh, 07h, 072h, 07h, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 02eh
        DB      08h, 020h, 07h, 02eh, 07h, 020h, 07h, 02eh, 0fh, 020h, 07h, 067h, 08h, 072h, 08h, 061h, 08h, 070h
        DB      08h, 068h, 08h, 069h, 08h, 063h, 08h, 073h, 08h, 020h, 07h, 02eh, 0fh, 020h, 07h, 02eh, 07h, 020h
        DB      07h, 02eh, 08h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 08h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 08h, 020h, 08h, 020h, 08h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 07h, 072h, 07h, 061h, 07h, 077h, 07h, 06ch, 07h, 06fh, 07h, 063h
        DB      07h, 06bh, 07h, 021h, 07h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 02eh, 08h, 020h, 07h, 02eh, 07h, 020h, 07h, 02eh, 0fh, 020h, 07h, 063h
        DB      08h, 020h, 08h, 072h, 08h, 020h, 08h, 065h, 08h, 020h, 08h, 064h, 08h, 020h, 08h, 069h, 08h, 020h
        DB      08h, 074h, 08h, 020h, 08h, 073h, 08h, 020h, 07h, 02eh, 0fh, 020h, 07h, 02eh, 07h, 020h, 07h, 02eh
        DB      08h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 06eh, 07h, 06fh, 07h, 074h, 07h, 065h, 07h, 03ah, 07h, 020h, 07h, 074h, 08h, 068h
        DB      08h, 069h, 08h, 073h, 08h, 020h, 08h, 077h, 08h, 061h, 08h, 073h, 08h, 020h, 08h, 070h, 08h, 072h
        DB      08h, 06fh, 08h, 064h, 08h, 075h, 08h, 063h, 08h, 065h, 08h, 064h, 08h, 020h, 08h, 065h, 08h, 078h
        DB      08h, 074h, 08h, 072h, 08h, 065h, 08h, 06dh, 08h, 065h, 08h, 06ch, 08h, 079h, 08h, 020h, 08h, 066h
        DB      08h, 061h, 08h, 073h, 08h, 074h, 08h, 020h, 08h, 061h, 08h, 062h, 08h, 06fh, 08h, 075h, 08h, 074h
        DB      08h, 020h, 08h, 031h, 08h, 020h, 08h, 068h, 08h, 06fh, 08h, 075h, 08h, 072h, 08h, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 073h, 08h, 06fh, 08h, 020h, 08h, 064h, 08h, 06fh, 08h
        DB      06eh, 08h, 027h, 08h, 074h, 08h, 020h, 08h, 063h, 08h, 06fh, 08h, 06dh, 08h, 070h, 08h, 06ch, 08h, 061h
        DB      08h, 069h, 08h, 06eh, 08h, 020h, 08h, 061h, 08h, 062h, 08h, 06fh, 08h, 075h, 08h, 074h, 08h, 020h
        DB      08h, 074h, 08h, 068h, 08h, 065h, 08h, 020h, 08h, 071h, 08h, 075h, 08h, 061h, 08h, 06ch, 08h, 069h
        DB      08h, 074h, 08h, 079h, 08h, 02eh, 07h, 020h, 07h, 077h, 08h, 065h, 08h, 020h, 08h, 063h, 08h, 06fh
        DB      08h, 075h, 08h, 06ch, 08h, 064h, 08h, 020h, 08h, 068h, 08h, 061h, 08h, 076h, 08h, 065h, 08h, 020h
        DB      07h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 06dh, 08h, 061h, 08h, 064h
        DB      08h, 065h, 08h, 020h, 08h, 069h, 08h, 074h, 08h, 020h, 08h, 06dh, 08h, 075h, 08h, 063h, 08h, 068h
        DB      08h, 020h, 08h, 06dh, 08h, 06fh, 08h, 072h, 08h, 065h, 08h, 020h, 08h, 070h, 08h, 072h, 08h, 06fh
        DB      08h, 066h, 08h, 066h, 08h, 065h, 08h, 073h, 08h, 073h, 08h, 069h, 08h, 06fh, 08h, 06eh, 08h, 061h
        DB      08h, 06ch, 08h, 02eh, 07h, 02eh, 07h, 02eh, 07h, 020h, 07h, 077h, 08h, 068h, 08h, 079h, 08h, 020h
        DB      08h, 062h, 08h, 065h, 08h, 020h, 08h, 073h, 08h, 065h, 08h, 072h, 08h, 069h, 08h, 06fh, 08h, 075h
        DB      08h, 073h, 08h, 021h, 07h, 021h, 07h, 020h, 07h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh

frame9  DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 07h, 020h, 07h, 020h, 07h, 050h, 08h, 020h
        DB      08h, 041h, 08h, 020h, 08h, 052h, 08h, 020h, 08h, 045h, 08h, 020h, 08h, 04eh, 08h, 020h, 08h, 054h
        DB      08h, 020h, 08h, 041h, 08h, 020h, 08h, 04ch, 08h, 020h, 08h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h
        DB      0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 041h, 07h, 020h, 07h, 044h, 07h, 020h, 07h
        DB      056h, 07h, 020h, 07h, 049h, 07h, 020h, 07h, 053h, 07h, 020h, 07h, 04fh, 07h, 020h, 07h, 052h, 07h
        DB      020h, 07h, 059h, 07h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 07h, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 045h, 0fh, 020h, 0fh, 058h, 0fh, 020h, 0fh, 050h, 0fh
        DB      020h, 0fh, 04ch, 0fh, 020h, 0fh, 049h, 0fh, 020h, 0fh, 043h, 0fh, 020h, 0fh, 049h, 0fh
        DB      020h, 0fh, 054h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 043h, 0fh, 020h, 0fh, 04fh, 0fh, 020h, 0fh, 04eh, 0fh
        DB      020h, 0fh, 054h, 0fh, 020h, 0fh, 045h, 0fh, 020h, 0fh, 04eh, 0fh, 020h, 0fh, 054h, 0fh
        DB      020h, 0fh, 053h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
        DB      020h, 0fh, 020h, 0fh, 020h, 0fh, 020h, 0fh
end:
	MAIN    ENDS

        END     start  
