From: gadiyar@ti.com (Anand Gadiyar)
Date: Tue, 19 Oct 2010 15:48:39 +0530
Subject: linux-next: omap2plus_defconfig not building
Message-ID: <4CBD707F.6050204@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ba1b9be5cd in linux-next (ARM: Add SWP/SWPB emulation for ARMv7 
processors (v5)) introduced arch/arm/kernel/swp_emulate.c. This file 
gets compiled when the omap2plus_defconfig is built - the 
omap2plus_defconfig builds OMAP2420, OMAP2430, OMAP3 and OMAP4 in one 
image, and has CPU_V6 and CPU_V7 both enabled.

When I attempt to build this configuration, I get the following build error:

   CC      arch/arm/kernel/swp_emulate.o
/tmp/ccRIcFIf.s: Assembler messages:
/tmp/ccRIcFIf.s:342: Error: selected processor does not support ARM mode 
`ldrexb r6,[r5]'
/tmp/ccRIcFIf.s:343: Error: selected processor does not support ARM mode 
`strexb r1,r3,[r5]'
make[1]: *** [arch/arm/kernel/swp_emulate.o] Error 1
make: *** [arch/arm/kernel] Error 2

I'm able to build when I disable ARCH_OMAP2 (and therefore CPU_V6),
as also (as expected) when I disable CONFIG_SWP_EMULATE.

I'm using Codesourcery's 2010q1-202, based on gcc 4.4.1.
I'm no ARM expert and I'm not even sure if this is an issue with the 
toolchain I am using. Just reporting the problem.

- Anand
