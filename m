From: ddegraff@licor.com (Darryl)
Date: Fri, 17 Jan 2014 07:41:21 -0600
Subject: debugging head.S
Message-ID: <52D93301.2080609@licor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am trying to build 3.12.6 for an OMAP3-based board (debug console on 
UART 3)

Enabling DEBUG in

     arch/arm/boot/compressed/head.S

and with

     CONFIG_DEBUG_LL_INCLUDE="debug/omap2plus.S"

compiling (well, actually, assembling) gives the following (slightly 
reformatted):

     arch/arm/boot/compressed/head.S: Assembler messages:
     arch/arm/boot/compressed/head.S:1237: Error: ARM register expected 
-- `sub ,r3,r1'
     arch/arm/boot/compressed/head.S:1237: Error: ARM register expected 
-- `ldr r3,[,#0]'
     arch/arm/boot/compressed/head.S:1237: Error: ARM register expected 
-- `ldr r1,[,#4]'
     arch/arm/include/debug/omap2plus.S:138: Error: ARM register 
expected -- `str r3,[,#0]'
     arch/arm/include/debug/omap2plus.S:138: Error: ARM register 
expected -- `str r3,[,#4]'
     arch/arm/include/debug/omap2plus.S:138: Error: ARM register 
expected -- `str r3,[,#8]'
     arch/arm/include/debug/omap2plus.S:138: Error: ARM register 
expected -- `str r3,[,#0]'
     arch/arm/include/debug/omap2plus.S:138: Error: ARM register 
expected -- `str r3,[,#4]'
     arch/arm/include/debug/omap2plus.S:138: Error: ARM register 
expected -- `str r3,[,#8]'
     arch/arm/include/debug/omap2plus.S:138: Error: ARM register 
expected -- `ldr ,[,#8]'
     arch/arm/include/debug/omap2plus.S:138: Error: shift expression 
expected -- `add r3,r3,'
     arch/arm/include/debug/omap2plus.S:138: Error: shift expression 
expected -- `add r1,r1,'
     arch/arm/boot/compressed/head.S:1255: Error: ARM register expected 
-- `sub ,r3,r1'
     arch/arm/boot/compressed/head.S:1255: Error: ARM register expected 
-- `ldr r3,[,#0]'
     arch/arm/boot/compressed/head.S:1255: Error: ARM register expected 
-- `ldr r1,[,#4]'
     arch/arm/include/debug/omap2plus.S:138: Error: ARM register 
expected -- `str r3,[,#0]'
     arch/arm/include/debug/omap2plus.S:138: Error: ARM register 
expected -- `str r3,[,#4]'
     arch/arm/include/debug/omap2plus.S:138: Error: ARM register 
expected -- `str r3,[,#8]'
     arch/arm/include/debug/omap2plus.S:138: Error: ARM register 
expected -- `str r3,[,#0]'
     arch/arm/include/debug/omap2plus.S:138: Error: ARM register 
expected -- `str r3,[,#4]'
     arch/arm/include/debug/omap2plus.S:138: Error: ARM register 
expected -- `str r3,[,#8]'
     arch/arm/include/debug/omap2plus.S:138: Error: ARM register 
expected -- `ldr ,[,#8]'
     arch/arm/include/debug/omap2plus.S:138: Error: shift expression 
expected -- `add r3,r3,'
     arch/arm/include/debug/omap2plus.S:138: Error: shift expression 
expected -- `add r1,r1,'

It looks like the 'addruart' macro in in omap2plus.S is shorted a 
parameter from the macro 'loadsp' macro in head.S, called in 'puts' and 
'putc'.

Am I misusing this in some way?  Any suggestions?

Darryl
