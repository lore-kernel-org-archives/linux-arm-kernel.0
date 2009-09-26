From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Sat, 26 Sep 2009 13:39:12 +0530
Subject: OMAP4430 build broken on latest mainline/linux-omap head
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BADABC8A@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,
OMAP4430 board build is breaking on the latest mainline head because of couple of issues.
1. The serial.c merge conflict issue below wasn't fixed correctly :(
Related link:
http://article.gmane.org/gmane.linux.ports.arm.omap/23341

2. Pauls below series breaks build as well. 
[PATCH 00/13] OMAP PM, clock,	and SDRC updates for the 2.6.32 merge window


Paul,
Can you fix the same please? I don't have the correct " cm-regbits-4xxx.h" file to generate the patch. 

***************************************************
CC      arch/arm/mach-omap2/control.o
  CC      arch/arm/mach-omap2/mux.o
  CC      arch/arm/mach-omap2/devices.o
  CC      arch/arm/mach-omap2/serial.o
  CC      arch/arm/mach-omap2/gpmc.o
  CC      arch/arm/mach-omap2/timer-gp.o
  CC      arch/arm/mach-omap2/omap-smp.o
  AS      arch/arm/mach-omap2/omap-headsmp.o
  CC      arch/arm/mach-omap2/timer-mpu.o
  CC      arch/arm/mach-omap2/cm4xxx.o
arch/arm/mach-omap2/cm4xxx.c:25:29: error: cm-regbits-4xxx.h: No such file or directory
arch/arm/mach-omap2/cm4xxx.c: In function 'omap4_cm_wait_idlest_ready':
arch/arm/mach-omap2/cm4xxx.c:61: error: implicit declaration of function 'omap4_cm_read_mod_reg'
arch/arm/mach-omap2/cm4xxx.c:62: error: 'OMAP4_CM_CLKCTRL_DREG' undeclared (first use in this function)
arch/arm/mach-omap2/cm4xxx.c:62: error: (Each undeclared identifier is reported only once
arch/arm/mach-omap2/cm4xxx.c:62: error: for each function it appears in.)
make[1]: *** [arch/arm/mach-omap2/cm4xxx.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

*****************************************************


Tony,
Patch regarding one 1. is below.
