.MODEL SMALL
.STACK 100H
.DATA
    PASSWORD DB 'MPSPOTPISI$'    ; Лозинка
    STRING1 DB 'MIKROPOTPISI$'   ; Пример 1
    STRING2 DB 'MPSPOTPISI$'     ; Пример 2
    STRING3 DB 'MPSPOTPIS$'      ; Пример 3
    MSG_EQUAL DB 'D$'
    MSG_NOT_EQUAL DB 'N$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX

    ; Пример 1
    LEA SI, PASSWORD
    LEA DI, STRING1
    CALL COMPARE_STRINGS

    ; Пример 2
    LEA SI, PASSWORD
    LEA DI, STRING2
    CALL COMPARE_STRINGS

    ; Пример 3
    LEA SI, PASSWORD
    LEA DI, STRING3
    CALL COMPARE_STRINGS

    ; Завршување на програмата
    MOV AH, 4CH
    INT 21H

COMPARE_STRINGS PROC
    ; Функција за споредба на два стринга
    CLD                 ; Clear direction flag
COMPARE_LOOP:
    LODSB               ; Load byte from [SI] into AL and increment SI
    SCASB               ; Compare byte in AL with byte in [DI] and increment DI
    JNE STRINGS_NOT_EQUAL ; Jump if not equal
    CMP AL, '$'         ; Check if end of string
    JE STRINGS_EQUAL    ; If end of string, strings are equal
    JMP COMPARE_LOOP    ; Repeat loop

STRINGS_NOT_EQUAL:
    LEA DX, MSG_NOT_EQUAL
    JMP PRINT_RESULT

STRINGS_EQUAL:
    LEA DX, MSG_EQUAL

PRINT_RESULT:
    MOV AH, 09H
    INT 21H
    RET
COMPARE_STRINGS ENDP

MAIN ENDP
END MAIN
