From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Sun, 22 Nov 2015 20:39:54 +0000
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <3964884.0P2KA5fUaZ@wuerfel> (Arnd Bergmann's message of "Sun, 22
 Nov 2015 21:37 +0100")
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <4527012.vmieWOaE32@wuerfel>
 <20151122200326.GK8644@n2100.arm.linux.org.uk>
 <3964884.0P2KA5fUaZ@wuerfel>
Message-ID: <yw1xa8q5bwf9.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> arnd at wuerfel:/tmp$ arm-linux-gnueabihf-gcc -Wall -O2 -mcpu=cortex-a15 idiv.c -c -o idiv-arm.o
> arnd at wuerfel:/tmp$ objdump -dr idiv-arm.o   
>
> idiv-arm.o:     file format elf32-littlearm
>
> Disassembly of section .text:
>
> 00000000 <udiv>:
>    0:   fbb0 f0f1       udiv    r0, r0, r1
>    4:   4770            bx      lr
>    6:   bf00            nop
>
> 00000008 <sdiv>:
>    8:   fb90 f0f1       sdiv    r0, r0, r1
>    c:   4770            bx      lr
>    e:   bf00            nop

Your compiler seems to default to thumb so you should add -marm.

-- 
M?ns Rullg?rd
mans at mansr.com
