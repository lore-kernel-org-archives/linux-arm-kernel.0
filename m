From: xvzhaobin@gmail.com (zhaobin xv)
Date: Mon, 22 Jul 2013 21:28:50 +0800
Subject: linux setup
Message-ID: <CANEcUBXMPhTjgVYbRN7NY+EUjh7DDGpKnZ8_LXY-ZLcfbH65Ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
I recently read lernel source .
I have a question:In
folder:linux/arch/arm/boot/compressed/head.S(linux2.6.22.6):


start:
        .type    start,#function
        .rept    8
        mov    r0, r0
        .endr

        b    1f
        .word    0x016f2818        @ Magic numbers to help the loader
        .word    start            @ absolute load/run zImage address
        .word    _edata            @ zImage end address
1:        mov    r7, r1            @ save architecture ID
        mov    r8, r2            @ save atags pointer


I don't kown why the ?mov r0 r0 ? repeated  emergence 8 times.
