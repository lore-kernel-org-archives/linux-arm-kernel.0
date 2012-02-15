From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 16 Feb 2012 07:55:41 +0900
Subject: [PATCH 07/12] ARM: S3C2410: move mach-s3c2410/* into mach-s3c24xx/
In-Reply-To: <1329346545-16373-1-git-send-email-kgene.kim@samsung.com>
References: <1329346545-16373-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1329346545-16373-8-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves S3C2410 stuff into mach-s3c24xx/ directory
so that we can merge the s3c24 series' directories to the
just one mach-s3c24xx/ directory.

And this patch is including following.
- re-ordered alphabetically by option text at Kconfig and Makefile
- removed unused option, MACH_N35
- fixed duplcated option name, S3C2410_DMA to S3C24XX_DMA which is
  in plat-s3c24xx/

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/Kconfig                                   |    2 +-
 arch/arm/Makefile                                  |    2 +-
 arch/arm/mach-s3c2410/Kconfig                      |  154 ------------------
 arch/arm/mach-s3c2410/Makefile                     |   26 ---
 arch/arm/mach-s3c24xx/Kconfig                      |  165 ++++++++++++++++++++
 arch/arm/mach-s3c24xx/Makefile                     |   45 ++++++
 .../{mach-s3c2410 => mach-s3c24xx}/Makefile.boot   |    0
 arch/arm/{mach-s3c2410 => mach-s3c24xx}/bast-ide.c |    0
 arch/arm/{mach-s3c2410 => mach-s3c24xx}/bast-irq.c |    0
 arch/arm/{mach-s3c2410 => mach-s3c24xx}/common.h   |    0
 .../dma.c => mach-s3c24xx/dma-s3c2410.c}           |    0
 .../h1940-bluetooth.c                              |    0
 .../include/mach/anubis-cpld.h                     |    0
 .../include/mach/anubis-irq.h                      |    0
 .../include/mach/anubis-map.h                      |    0
 .../include/mach/bast-cpld.h                       |    0
 .../include/mach/bast-irq.h                        |    0
 .../include/mach/bast-map.h                        |    0
 .../include/mach/bast-pmu.h                        |    0
 .../include/mach/debug-macro.S                     |    0
 .../include/mach/dma.h                             |    0
 .../include/mach/entry-macro.S                     |    0
 .../include/mach/fb.h                              |    0
 .../include/mach/gpio-fns.h                        |    0
 .../include/mach/gpio-nrs.h                        |    0
 .../include/mach/gpio-track.h                      |    0
 .../include/mach/gpio.h                            |    0
 .../include/mach/h1940-latch.h                     |    0
 .../include/mach/h1940.h                           |    0
 .../include/mach/hardware.h                        |    0
 .../include/mach/idle.h                            |    0
 .../include/mach/io.h                              |    0
 .../include/mach/irqs.h                            |    0
 .../include/mach/leds-gpio.h                       |    0
 .../include/mach/map.h                             |    0
 .../include/mach/osiris-cpld.h                     |    0
 .../include/mach/osiris-map.h                      |    0
 .../include/mach/otom-map.h                        |    0
 .../include/mach/pm-core.h                         |    0
 .../include/mach/regs-clock.h                      |    0
 .../include/mach/regs-dsc.h                        |    0
 .../include/mach/regs-gpio.h                       |    0
 .../include/mach/regs-gpioj.h                      |    0
 .../include/mach/regs-irq.h                        |    0
 .../include/mach/regs-lcd.h                        |    0
 .../include/mach/regs-mem.h                        |    0
 .../include/mach/regs-power.h                      |    0
 .../include/mach/regs-s3c2412-mem.h                |    0
 .../include/mach/regs-s3c2412.h                    |    0
 .../include/mach/regs-s3c2416-mem.h                |    0
 .../include/mach/regs-s3c2416.h                    |    0
 .../include/mach/regs-s3c2443-clock.h              |    0
 .../include/mach/regs-sdi.h                        |    0
 .../include/mach/system.h                          |    0
 .../include/mach/tick.h                            |    0
 .../include/mach/timex.h                           |    0
 .../include/mach/uncompress.h                      |    0
 .../include/mach/vr1000-cpld.h                     |    0
 .../include/mach/vr1000-irq.h                      |    0
 .../include/mach/vr1000-map.h                      |    0
 .../{mach-s3c2410 => mach-s3c24xx}/mach-amlm5900.c |    0
 .../arm/{mach-s3c2410 => mach-s3c24xx}/mach-bast.c |    0
 .../{mach-s3c2410 => mach-s3c24xx}/mach-h1940.c    |    0
 arch/arm/{mach-s3c2410 => mach-s3c24xx}/mach-n30.c |    0
 .../arm/{mach-s3c2410 => mach-s3c24xx}/mach-otom.c |    0
 .../{mach-s3c2410 => mach-s3c24xx}/mach-qt2410.c   |    0
 .../{mach-s3c2410 => mach-s3c24xx}/mach-smdk2410.c |    0
 .../mach-tct_hammer.c                              |    0
 .../{mach-s3c2410 => mach-s3c24xx}/mach-vr1000.c   |    0
 .../{mach-s3c2410 => mach-s3c24xx}/nor-simtec.c    |    0
 .../{mach-s3c2410 => mach-s3c24xx}/nor-simtec.h    |    0
 arch/arm/{mach-s3c2410 => mach-s3c24xx}/pm-h1940.S |    0
 .../pm.c => mach-s3c24xx/pm-s3c2410.c}             |    0
 arch/arm/{mach-s3c2410 => mach-s3c24xx}/s3c2410.c  |    0
 .../sleep.S => mach-s3c24xx/sleep-s3c2410.S}       |    0
 .../{mach-s3c2410 => mach-s3c24xx}/usb-simtec.c    |    0
 .../{mach-s3c2410 => mach-s3c24xx}/usb-simtec.h    |    0
 arch/arm/plat-s3c24xx/Kconfig                      |    2 +-
 arch/arm/plat-s3c24xx/Makefile                     |    2 +-
 79 files changed, 214 insertions(+), 184 deletions(-)
 create mode 100644 arch/arm/mach-s3c24xx/Kconfig
 create mode 100644 arch/arm/mach-s3c24xx/Makefile
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/Makefile.boot (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/bast-ide.c (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/bast-irq.c (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/common.h (100%)
 rename arch/arm/{mach-s3c2410/dma.c => mach-s3c24xx/dma-s3c2410.c} (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/h1940-bluetooth.c (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/anubis-cpld.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/anubis-irq.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/anubis-map.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/bast-cpld.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/bast-irq.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/bast-map.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/bast-pmu.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/debug-macro.S (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/dma.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/entry-macro.S (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/fb.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/gpio-fns.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/gpio-nrs.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/gpio-track.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/gpio.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/h1940-latch.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/h1940.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/hardware.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/idle.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/io.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/irqs.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/leds-gpio.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/map.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/osiris-cpld.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/osiris-map.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/otom-map.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/pm-core.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/regs-clock.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/regs-dsc.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/regs-gpio.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/regs-gpioj.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/regs-irq.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/regs-lcd.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/regs-mem.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/regs-power.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/regs-s3c2412-mem.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/regs-s3c2412.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/regs-s3c2416-mem.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/regs-s3c2416.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/regs-s3c2443-clock.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/regs-sdi.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/system.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/tick.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/timex.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/uncompress.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/vr1000-cpld.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/vr1000-irq.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/vr1000-map.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/mach-amlm5900.c (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/mach-bast.c (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/mach-h1940.c (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/mach-n30.c (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/mach-otom.c (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/mach-qt2410.c (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/mach-smdk2410.c (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/mach-tct_hammer.c (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/mach-vr1000.c (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/nor-simtec.c (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/nor-simtec.h (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/pm-h1940.S (100%)
 rename arch/arm/{mach-s3c2410/pm.c => mach-s3c24xx/pm-s3c2410.c} (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/s3c2410.c (100%)
 rename arch/arm/{mach-s3c2410/sleep.S => mach-s3c24xx/sleep-s3c2410.S} (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/usb-simtec.c (100%)
 rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/usb-simtec.h (100%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5f1a3ad..f8044e9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1067,8 +1067,8 @@ source "arch/arm/plat-s5p/Kconfig"
 
 source "arch/arm/plat-spear/Kconfig"
 
+source "arch/arm/mach-s3c24xx/Kconfig"
 if ARCH_S3C24XX
-source "arch/arm/mach-s3c2410/Kconfig"
 source "arch/arm/mach-s3c2412/Kconfig"
 source "arch/arm/mach-s3c2416/Kconfig"
 source "arch/arm/mach-s3c2440/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 624f764..59d9df4 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -175,7 +175,7 @@ machine-$(CONFIG_ARCH_PRIMA2)		:= prima2
 machine-$(CONFIG_ARCH_PXA)		:= pxa
 machine-$(CONFIG_ARCH_REALVIEW)		:= realview
 machine-$(CONFIG_ARCH_RPC)		:= rpc
-machine-$(CONFIG_ARCH_S3C24XX)		:= s3c2410 s3c2412 s3c2416 s3c2440 s3c2443
+machine-$(CONFIG_ARCH_S3C24XX)		:= s3c24xx s3c2412 s3c2416 s3c2440 s3c2443
 machine-$(CONFIG_ARCH_S3C64XX)		:= s3c64xx
 machine-$(CONFIG_ARCH_S5P64X0)		:= s5p64x0
 machine-$(CONFIG_ARCH_S5PC100)		:= s5pc100
diff --git a/arch/arm/mach-s3c2410/Kconfig b/arch/arm/mach-s3c2410/Kconfig
index ce62099..68d89cb 100644
--- a/arch/arm/mach-s3c2410/Kconfig
+++ b/arch/arm/mach-s3c2410/Kconfig
@@ -2,42 +2,6 @@
 #
 # Licensed under GPLv2
 
-config CPU_S3C2410
-	bool
-	depends on ARCH_S3C24XX
-	select CPU_ARM920T
-	select S3C2410_CLOCK
-	select CPU_LLSERIAL_S3C2410
-	select S3C2410_PM if PM
-	select S3C2410_CPUFREQ if CPU_FREQ_S3C24XX
-	help
-	  Support for S3C2410 and S3C2410A family from the S3C24XX line
-	  of Samsung Mobile CPUs.
-
-config CPU_S3C2410_DMA
-	bool
-	depends on S3C2410_DMA && (CPU_S3C2410 || CPU_S3C2442)
-	default y if CPU_S3C2410 || CPU_S3C2442
-	help
-	  DMA device selection for S3C2410 and compatible CPUs
-
-config S3C2410_PM
-	bool
-	help
-	  Power Management code common to S3C2410 and better
-
-config SIMTEC_NOR
-	bool
-	help
-	  Internal node to specify machine has simtec NOR mapping
-
-config MACH_BAST_IDE
-	bool
-	select HAVE_PATA_PLATFORM
-	help
-	  Internal node for machines with an BAST style IDE
-	  interface
-
 # cpu frequency scaling support
 
 config S3C2410_CPUFREQ
@@ -54,121 +18,3 @@ config S3C2410_PLLTABLE
 	help
 	  Select the PLL table for the S3C2410
 
-menu "S3C2410 Machines"
-
-config ARCH_SMDK2410
-	bool "SMDK2410/A9M2410"
-	select CPU_S3C2410
-	select MACH_SMDK
-	help
-	   Say Y here if you are using the SMDK2410 or the derived module A9M2410
-           <http://www.fsforth.de>
-
-config ARCH_H1940
-	bool "IPAQ H1940"
-	select CPU_S3C2410
-	select PM_H1940 if PM
-	select S3C_DEV_USB_HOST
-	select S3C_DEV_NAND
-	select S3C2410_SETUP_TS
-	help
-	  Say Y here if you are using the HP IPAQ H1940
-
-config H1940BT
-        tristate "Control the state of H1940 bluetooth chip"
-        depends on ARCH_H1940
-        select RFKILL
-        help
-          This is a simple driver that is able to control
-          the state of built in bluetooth chip on h1940.
-
-config PM_H1940
-	bool
-	help
-	  Internal node for H1940 and related PM
-
-config MACH_N30
-	bool "Acer N30 family"
-	select CPU_S3C2410
-	select MACH_N35
-	select S3C_DEV_USB_HOST
-	select S3C_DEV_NAND
-	help
-	  Say Y here if you want suppt for the Acer N30, Acer N35,
-	  Navman PiN570, Yakumo AlphaX or Airis NC05 PDAs.
-
-config MACH_N35
-	bool
-	help
-	  Internal node in order to enable support for Acer N35 if Acer N30 is
-	  selected.
-
-config ARCH_BAST
-	bool "Simtec Electronics BAST (EB2410ITX)"
-	select CPU_S3C2410
-	select S3C2410_IOTIMING if S3C2410_CPUFREQ
-	select PM_SIMTEC if PM
-	select SIMTEC_NOR
-	select MACH_BAST_IDE
-	select S3C24XX_DCLK
-	select ISA
-	select S3C_DEV_HWMON
-	select S3C_DEV_USB_HOST
-	select S3C_DEV_NAND
-	help
-	  Say Y here if you are using the Simtec Electronics EB2410ITX
-	  development board (also known as BAST)
-
-config MACH_OTOM
- 	bool "NexVision OTOM Board"
- 	select CPU_S3C2410
-	select S3C_DEV_USB_HOST
-	select S3C_DEV_NAND
-	help
- 	  Say Y here if you are using the Nex Vision OTOM board
-
-config MACH_AML_M5900
-	bool "AML M5900 Series"
-	select CPU_S3C2410
-	select PM_SIMTEC if PM
-	select S3C_DEV_USB_HOST
-	help
-	   Say Y here if you are using the American Microsystems M5900 Series
-           <http://www.amltd.com>
-
-config BAST_PC104_IRQ
-	bool "BAST PC104 IRQ support"
-	depends on ARCH_BAST
-	default y
-	help
-	  Say Y	here to enable the PC104 IRQ routing on the
-	  Simtec BAST (EB2410ITX)
-
-config MACH_TCT_HAMMER
-	bool "TCT Hammer Board"
-	select CPU_S3C2410
-	select S3C_DEV_USB_HOST
-	help
-	   Say Y here if you are using the TinCanTools Hammer Board
-           <http://www.tincantools.com>
-
-config MACH_VR1000
-	bool "Thorcom VR1000"
-	select PM_SIMTEC if PM
-	select S3C24XX_DCLK
-	select SIMTEC_NOR
-	select MACH_BAST_IDE
-	select CPU_S3C2410
-	select S3C_DEV_USB_HOST
-	help
-	  Say Y here if you are using the Thorcom VR1000 board.
-
-config MACH_QT2410
-	bool "QT2410"
-	select CPU_S3C2410
-	select S3C_DEV_USB_HOST
-	select S3C_DEV_NAND
-	help
-	   Say Y here if you are using the Armzone QT2410
-
-endmenu
diff --git a/arch/arm/mach-s3c2410/Makefile b/arch/arm/mach-s3c2410/Makefile
index 782fd81..6b9a316 100644
--- a/arch/arm/mach-s3c2410/Makefile
+++ b/arch/arm/mach-s3c2410/Makefile
@@ -9,32 +9,6 @@ obj-m				:=
 obj-n				:=
 obj-				:=
 
-obj-$(CONFIG_CPU_S3C2410)	+= s3c2410.o
-obj-$(CONFIG_CPU_S3C2410_DMA)	+= dma.o
-obj-$(CONFIG_CPU_S3C2410_DMA)	+= dma.o
-obj-$(CONFIG_S3C2410_PM)	+= pm.o sleep.o
 obj-$(CONFIG_S3C2410_CPUFREQ)	+= cpu-freq.o
 obj-$(CONFIG_S3C2410_PLLTABLE)	+= pll.o
 
-# Machine support
-
-obj-$(CONFIG_ARCH_SMDK2410)	+= mach-smdk2410.o
-obj-$(CONFIG_ARCH_H1940)	+= mach-h1940.o
-obj-$(CONFIG_H1940BT)		+= h1940-bluetooth.o
-obj-$(CONFIG_PM_H1940)		+= pm-h1940.o
-obj-$(CONFIG_MACH_N30)		+= mach-n30.o
-obj-$(CONFIG_ARCH_BAST)		+= mach-bast.o usb-simtec.o
-obj-$(CONFIG_MACH_OTOM)		+= mach-otom.o
-obj-$(CONFIG_MACH_AML_M5900)	+= mach-amlm5900.o
-obj-$(CONFIG_BAST_PC104_IRQ)	+= bast-irq.o
-obj-$(CONFIG_MACH_TCT_HAMMER)	+= mach-tct_hammer.o
-obj-$(CONFIG_MACH_VR1000)	+= mach-vr1000.o usb-simtec.o
-obj-$(CONFIG_MACH_QT2410)	+= mach-qt2410.o
-
-# Common bits of machine support
-
-obj-$(CONFIG_SIMTEC_NOR)	+= nor-simtec.o
-
-# machine additions
-
-obj-$(CONFIG_MACH_BAST_IDE)	+= bast-ide.o
diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
new file mode 100644
index 0000000..7f916c8
--- /dev/null
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -0,0 +1,165 @@
+# arch/arm/mach-s3c24xx/Kconfig
+#
+# Copyright (c) 2012 Samsung Electronics Co., Ltd.
+#		http://www.samsung.com/
+#
+# Copyright 2007 Simtec Electronics
+#
+# Licensed under GPLv2
+
+if ARCH_S3C24XX
+
+menu "SAMSUNG S3C24XX SoCs Support"
+
+comment "S3C24XX SoCs"
+
+config CPU_S3C2410
+	bool "SAMSUNG S3C2410"
+	default y
+	select CPU_ARM920T
+	select S3C2410_CLOCK
+	select CPU_LLSERIAL_S3C2410
+	select S3C2410_PM if PM
+	select S3C2410_CPUFREQ if CPU_FREQ_S3C24XX
+	help
+	  Support for S3C2410 and S3C2410A family from the S3C24XX line
+	  of Samsung Mobile CPUs.
+
+if CPU_S3C2410
+
+config S3C2410_DMA
+	bool
+	depends on S3C2410_DMA && CPU_S3C2410
+	default y if CPU_S3C2410
+	help
+	  DMA device selection for S3C2410 and compatible CPUs
+
+config S3C2410_PM
+	bool
+	help
+	  Power Management code common to S3C2410 and better
+
+config SIMTEC_NOR
+	bool
+	help
+	  Internal node to specify machine has simtec NOR mapping
+
+config MACH_BAST_IDE
+	bool
+	select HAVE_PATA_PLATFORM
+	help
+	  Internal node for machines with an BAST style IDE
+	  interface
+
+comment "S3C2410 Boards"
+
+#
+# The "S3C2410 Boards" list is ordered alphabetically by option text.
+# (without ARCH_ or MACH_)
+#
+
+config MACH_AML_M5900
+	bool "AML M5900 Series"
+	select PM_SIMTEC if PM
+	select S3C_DEV_USB_HOST
+	help
+	  Say Y here if you are using the American Microsystems M5900 Series
+	  <http://www.amltd.com>
+
+config ARCH_BAST
+	bool "Simtec Electronics BAST (EB2410ITX)"
+	select S3C2410_IOTIMING if S3C2410_CPUFREQ
+	select PM_SIMTEC if PM
+	select SIMTEC_NOR
+	select MACH_BAST_IDE
+	select S3C24XX_DCLK
+	select ISA
+	select S3C_DEV_HWMON
+	select S3C_DEV_USB_HOST
+	select S3C_DEV_NAND
+	help
+	  Say Y here if you are using the Simtec Electronics EB2410ITX
+	  development board (also known as BAST)
+
+config BAST_PC104_IRQ
+	bool "BAST PC104 IRQ support"
+	depends on ARCH_BAST
+	default y
+	help
+	  Say Y	here to enable the PC104 IRQ routing on the
+	  Simtec BAST (EB2410ITX)
+
+config ARCH_H1940
+	bool "IPAQ H1940"
+	select PM_H1940 if PM
+	select S3C_DEV_USB_HOST
+	select S3C_DEV_NAND
+	select S3C2410_SETUP_TS
+	help
+	  Say Y here if you are using the HP IPAQ H1940
+
+config H1940BT
+	tristate "Control the state of H1940 bluetooth chip"
+	depends on ARCH_H1940
+	select RFKILL
+	help
+	  This is a simple driver that is able to control
+	  the state of built in bluetooth chip on h1940.
+
+config PM_H1940
+	bool
+	help
+	  Internal node for H1940 and related PM
+
+config MACH_N30
+	bool "Acer N30 family"
+	select MACH_N35
+	select S3C_DEV_USB_HOST
+	select S3C_DEV_NAND
+	help
+	  Say Y here if you want suppt for the Acer N30, Acer N35,
+	  Navman PiN570, Yakumo AlphaX or Airis NC05 PDAs.
+
+config MACH_OTOM
+	bool "NexVision OTOM Board"
+	select S3C_DEV_USB_HOST
+	select S3C_DEV_NAND
+	help
+	  Say Y here if you are using the Nex Vision OTOM board
+
+config MACH_QT2410
+	bool "QT2410"
+	select S3C_DEV_USB_HOST
+	select S3C_DEV_NAND
+	help
+	  Say Y here if you are using the Armzone QT2410
+
+config ARCH_SMDK2410
+	bool "SMDK2410/A9M2410"
+	select MACH_SMDK
+	help
+	  Say Y here if you are using the SMDK2410 or the derived module A9M2410
+	  <http://www.fsforth.de>
+
+config MACH_TCT_HAMMER
+	bool "TCT Hammer Board"
+	select S3C_DEV_USB_HOST
+	help
+	  Say Y here if you are using the TinCanTools Hammer Board
+	  <http://www.tincantools.com>
+
+config MACH_VR1000
+	bool "Thorcom VR1000"
+	select PM_SIMTEC if PM
+	select S3C24XX_DCLK
+	select SIMTEC_NOR
+	select MACH_BAST_IDE
+	select S3C_DEV_USB_HOST
+	help
+	  Say Y here if you are using the Thorcom VR1000 board.
+
+endif	# CPU_S3C2410
+
+endmenu	# SAMSUNG S3C24XX SoCs Support
+
+endif	# ARCH_S3C24XX
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
new file mode 100644
index 0000000..b6afbf84
--- /dev/null
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -0,0 +1,45 @@
+# arch/arm/mach-s3c24xx/Makefile
+#
+# Copyright (c) 2012 Samsung Electronics Co., Ltd.
+#		http://www.samsung.com/
+#
+# Copyright 2007 Simtec Electronics
+#
+# Licensed under GPLv2
+
+obj-y				:=
+obj-m				:=
+obj-n				:=
+obj-				:=
+
+# core
+
+obj-$(CONFIG_CPU_S3C2410)	+= s3c2410.o
+obj-$(CONFIG_S3C2410_DMA)	+= dma-s3c2410.o
+obj-$(CONFIG_S3C2410_PM)	+= pm-s3c2410.o sleep-s3c2410.o
+
+#
+# machine support
+# following is ordered alphabetically by option text.
+#
+
+obj-$(CONFIG_MACH_AML_M5900)		+= mach-amlm5900.o
+obj-$(CONFIG_ARCH_BAST)			+= mach-bast.o usb-simtec.o
+obj-$(CONFIG_BAST_PC104_IRQ)		+= bast-irq.o
+obj-$(CONFIG_ARCH_H1940)		+= mach-h1940.o
+obj-$(CONFIG_H1940BT)			+= h1940-bluetooth.o
+obj-$(CONFIG_PM_H1940)			+= pm-h1940.o
+obj-$(CONFIG_MACH_N30)			+= mach-n30.o
+obj-$(CONFIG_MACH_OTOM)			+= mach-otom.o
+obj-$(CONFIG_MACH_QT2410)		+= mach-qt2410.o
+obj-$(CONFIG_ARCH_SMDK2410)		+= mach-smdk2410.o
+obj-$(CONFIG_MACH_TCT_HAMMER)		+= mach-tct_hammer.o
+obj-$(CONFIG_MACH_VR1000)		+= mach-vr1000.o usb-simtec.o
+
+# common bits of machine support
+
+obj-$(CONFIG_SIMTEC_NOR)		+= nor-simtec.o
+
+# machine additions
+
+obj-$(CONFIG_MACH_BAST_IDE)		+= bast-ide.o
diff --git a/arch/arm/mach-s3c2410/Makefile.boot b/arch/arm/mach-s3c24xx/Makefile.boot
similarity index 100%
rename from arch/arm/mach-s3c2410/Makefile.boot
rename to arch/arm/mach-s3c24xx/Makefile.boot
diff --git a/arch/arm/mach-s3c2410/bast-ide.c b/arch/arm/mach-s3c24xx/bast-ide.c
similarity index 100%
rename from arch/arm/mach-s3c2410/bast-ide.c
rename to arch/arm/mach-s3c24xx/bast-ide.c
diff --git a/arch/arm/mach-s3c2410/bast-irq.c b/arch/arm/mach-s3c24xx/bast-irq.c
similarity index 100%
rename from arch/arm/mach-s3c2410/bast-irq.c
rename to arch/arm/mach-s3c24xx/bast-irq.c
diff --git a/arch/arm/mach-s3c2410/common.h b/arch/arm/mach-s3c24xx/common.h
similarity index 100%
rename from arch/arm/mach-s3c2410/common.h
rename to arch/arm/mach-s3c24xx/common.h
diff --git a/arch/arm/mach-s3c2410/dma.c b/arch/arm/mach-s3c24xx/dma-s3c2410.c
similarity index 100%
rename from arch/arm/mach-s3c2410/dma.c
rename to arch/arm/mach-s3c24xx/dma-s3c2410.c
diff --git a/arch/arm/mach-s3c2410/h1940-bluetooth.c b/arch/arm/mach-s3c24xx/h1940-bluetooth.c
similarity index 100%
rename from arch/arm/mach-s3c2410/h1940-bluetooth.c
rename to arch/arm/mach-s3c24xx/h1940-bluetooth.c
diff --git a/arch/arm/mach-s3c2410/include/mach/anubis-cpld.h b/arch/arm/mach-s3c24xx/include/mach/anubis-cpld.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/anubis-cpld.h
rename to arch/arm/mach-s3c24xx/include/mach/anubis-cpld.h
diff --git a/arch/arm/mach-s3c2410/include/mach/anubis-irq.h b/arch/arm/mach-s3c24xx/include/mach/anubis-irq.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/anubis-irq.h
rename to arch/arm/mach-s3c24xx/include/mach/anubis-irq.h
diff --git a/arch/arm/mach-s3c2410/include/mach/anubis-map.h b/arch/arm/mach-s3c24xx/include/mach/anubis-map.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/anubis-map.h
rename to arch/arm/mach-s3c24xx/include/mach/anubis-map.h
diff --git a/arch/arm/mach-s3c2410/include/mach/bast-cpld.h b/arch/arm/mach-s3c24xx/include/mach/bast-cpld.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/bast-cpld.h
rename to arch/arm/mach-s3c24xx/include/mach/bast-cpld.h
diff --git a/arch/arm/mach-s3c2410/include/mach/bast-irq.h b/arch/arm/mach-s3c24xx/include/mach/bast-irq.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/bast-irq.h
rename to arch/arm/mach-s3c24xx/include/mach/bast-irq.h
diff --git a/arch/arm/mach-s3c2410/include/mach/bast-map.h b/arch/arm/mach-s3c24xx/include/mach/bast-map.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/bast-map.h
rename to arch/arm/mach-s3c24xx/include/mach/bast-map.h
diff --git a/arch/arm/mach-s3c2410/include/mach/bast-pmu.h b/arch/arm/mach-s3c24xx/include/mach/bast-pmu.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/bast-pmu.h
rename to arch/arm/mach-s3c24xx/include/mach/bast-pmu.h
diff --git a/arch/arm/mach-s3c2410/include/mach/debug-macro.S b/arch/arm/mach-s3c24xx/include/mach/debug-macro.S
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/debug-macro.S
rename to arch/arm/mach-s3c24xx/include/mach/debug-macro.S
diff --git a/arch/arm/mach-s3c2410/include/mach/dma.h b/arch/arm/mach-s3c24xx/include/mach/dma.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/dma.h
rename to arch/arm/mach-s3c24xx/include/mach/dma.h
diff --git a/arch/arm/mach-s3c2410/include/mach/entry-macro.S b/arch/arm/mach-s3c24xx/include/mach/entry-macro.S
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/entry-macro.S
rename to arch/arm/mach-s3c24xx/include/mach/entry-macro.S
diff --git a/arch/arm/mach-s3c2410/include/mach/fb.h b/arch/arm/mach-s3c24xx/include/mach/fb.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/fb.h
rename to arch/arm/mach-s3c24xx/include/mach/fb.h
diff --git a/arch/arm/mach-s3c2410/include/mach/gpio-fns.h b/arch/arm/mach-s3c24xx/include/mach/gpio-fns.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/gpio-fns.h
rename to arch/arm/mach-s3c24xx/include/mach/gpio-fns.h
diff --git a/arch/arm/mach-s3c2410/include/mach/gpio-nrs.h b/arch/arm/mach-s3c24xx/include/mach/gpio-nrs.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/gpio-nrs.h
rename to arch/arm/mach-s3c24xx/include/mach/gpio-nrs.h
diff --git a/arch/arm/mach-s3c2410/include/mach/gpio-track.h b/arch/arm/mach-s3c24xx/include/mach/gpio-track.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/gpio-track.h
rename to arch/arm/mach-s3c24xx/include/mach/gpio-track.h
diff --git a/arch/arm/mach-s3c2410/include/mach/gpio.h b/arch/arm/mach-s3c24xx/include/mach/gpio.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/gpio.h
rename to arch/arm/mach-s3c24xx/include/mach/gpio.h
diff --git a/arch/arm/mach-s3c2410/include/mach/h1940-latch.h b/arch/arm/mach-s3c24xx/include/mach/h1940-latch.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/h1940-latch.h
rename to arch/arm/mach-s3c24xx/include/mach/h1940-latch.h
diff --git a/arch/arm/mach-s3c2410/include/mach/h1940.h b/arch/arm/mach-s3c24xx/include/mach/h1940.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/h1940.h
rename to arch/arm/mach-s3c24xx/include/mach/h1940.h
diff --git a/arch/arm/mach-s3c2410/include/mach/hardware.h b/arch/arm/mach-s3c24xx/include/mach/hardware.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/hardware.h
rename to arch/arm/mach-s3c24xx/include/mach/hardware.h
diff --git a/arch/arm/mach-s3c2410/include/mach/idle.h b/arch/arm/mach-s3c24xx/include/mach/idle.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/idle.h
rename to arch/arm/mach-s3c24xx/include/mach/idle.h
diff --git a/arch/arm/mach-s3c2410/include/mach/io.h b/arch/arm/mach-s3c24xx/include/mach/io.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/io.h
rename to arch/arm/mach-s3c24xx/include/mach/io.h
diff --git a/arch/arm/mach-s3c2410/include/mach/irqs.h b/arch/arm/mach-s3c24xx/include/mach/irqs.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/irqs.h
rename to arch/arm/mach-s3c24xx/include/mach/irqs.h
diff --git a/arch/arm/mach-s3c2410/include/mach/leds-gpio.h b/arch/arm/mach-s3c24xx/include/mach/leds-gpio.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/leds-gpio.h
rename to arch/arm/mach-s3c24xx/include/mach/leds-gpio.h
diff --git a/arch/arm/mach-s3c2410/include/mach/map.h b/arch/arm/mach-s3c24xx/include/mach/map.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/map.h
rename to arch/arm/mach-s3c24xx/include/mach/map.h
diff --git a/arch/arm/mach-s3c2410/include/mach/osiris-cpld.h b/arch/arm/mach-s3c24xx/include/mach/osiris-cpld.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/osiris-cpld.h
rename to arch/arm/mach-s3c24xx/include/mach/osiris-cpld.h
diff --git a/arch/arm/mach-s3c2410/include/mach/osiris-map.h b/arch/arm/mach-s3c24xx/include/mach/osiris-map.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/osiris-map.h
rename to arch/arm/mach-s3c24xx/include/mach/osiris-map.h
diff --git a/arch/arm/mach-s3c2410/include/mach/otom-map.h b/arch/arm/mach-s3c24xx/include/mach/otom-map.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/otom-map.h
rename to arch/arm/mach-s3c24xx/include/mach/otom-map.h
diff --git a/arch/arm/mach-s3c2410/include/mach/pm-core.h b/arch/arm/mach-s3c24xx/include/mach/pm-core.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/pm-core.h
rename to arch/arm/mach-s3c24xx/include/mach/pm-core.h
diff --git a/arch/arm/mach-s3c2410/include/mach/regs-clock.h b/arch/arm/mach-s3c24xx/include/mach/regs-clock.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/regs-clock.h
rename to arch/arm/mach-s3c24xx/include/mach/regs-clock.h
diff --git a/arch/arm/mach-s3c2410/include/mach/regs-dsc.h b/arch/arm/mach-s3c24xx/include/mach/regs-dsc.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/regs-dsc.h
rename to arch/arm/mach-s3c24xx/include/mach/regs-dsc.h
diff --git a/arch/arm/mach-s3c2410/include/mach/regs-gpio.h b/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/regs-gpio.h
rename to arch/arm/mach-s3c24xx/include/mach/regs-gpio.h
diff --git a/arch/arm/mach-s3c2410/include/mach/regs-gpioj.h b/arch/arm/mach-s3c24xx/include/mach/regs-gpioj.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/regs-gpioj.h
rename to arch/arm/mach-s3c24xx/include/mach/regs-gpioj.h
diff --git a/arch/arm/mach-s3c2410/include/mach/regs-irq.h b/arch/arm/mach-s3c24xx/include/mach/regs-irq.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/regs-irq.h
rename to arch/arm/mach-s3c24xx/include/mach/regs-irq.h
diff --git a/arch/arm/mach-s3c2410/include/mach/regs-lcd.h b/arch/arm/mach-s3c24xx/include/mach/regs-lcd.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/regs-lcd.h
rename to arch/arm/mach-s3c24xx/include/mach/regs-lcd.h
diff --git a/arch/arm/mach-s3c2410/include/mach/regs-mem.h b/arch/arm/mach-s3c24xx/include/mach/regs-mem.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/regs-mem.h
rename to arch/arm/mach-s3c24xx/include/mach/regs-mem.h
diff --git a/arch/arm/mach-s3c2410/include/mach/regs-power.h b/arch/arm/mach-s3c24xx/include/mach/regs-power.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/regs-power.h
rename to arch/arm/mach-s3c24xx/include/mach/regs-power.h
diff --git a/arch/arm/mach-s3c2410/include/mach/regs-s3c2412-mem.h b/arch/arm/mach-s3c24xx/include/mach/regs-s3c2412-mem.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/regs-s3c2412-mem.h
rename to arch/arm/mach-s3c24xx/include/mach/regs-s3c2412-mem.h
diff --git a/arch/arm/mach-s3c2410/include/mach/regs-s3c2412.h b/arch/arm/mach-s3c24xx/include/mach/regs-s3c2412.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/regs-s3c2412.h
rename to arch/arm/mach-s3c24xx/include/mach/regs-s3c2412.h
diff --git a/arch/arm/mach-s3c2410/include/mach/regs-s3c2416-mem.h b/arch/arm/mach-s3c24xx/include/mach/regs-s3c2416-mem.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/regs-s3c2416-mem.h
rename to arch/arm/mach-s3c24xx/include/mach/regs-s3c2416-mem.h
diff --git a/arch/arm/mach-s3c2410/include/mach/regs-s3c2416.h b/arch/arm/mach-s3c24xx/include/mach/regs-s3c2416.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/regs-s3c2416.h
rename to arch/arm/mach-s3c24xx/include/mach/regs-s3c2416.h
diff --git a/arch/arm/mach-s3c2410/include/mach/regs-s3c2443-clock.h b/arch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/regs-s3c2443-clock.h
rename to arch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h
diff --git a/arch/arm/mach-s3c2410/include/mach/regs-sdi.h b/arch/arm/mach-s3c24xx/include/mach/regs-sdi.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/regs-sdi.h
rename to arch/arm/mach-s3c24xx/include/mach/regs-sdi.h
diff --git a/arch/arm/mach-s3c2410/include/mach/system.h b/arch/arm/mach-s3c24xx/include/mach/system.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/system.h
rename to arch/arm/mach-s3c24xx/include/mach/system.h
diff --git a/arch/arm/mach-s3c2410/include/mach/tick.h b/arch/arm/mach-s3c24xx/include/mach/tick.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/tick.h
rename to arch/arm/mach-s3c24xx/include/mach/tick.h
diff --git a/arch/arm/mach-s3c2410/include/mach/timex.h b/arch/arm/mach-s3c24xx/include/mach/timex.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/timex.h
rename to arch/arm/mach-s3c24xx/include/mach/timex.h
diff --git a/arch/arm/mach-s3c2410/include/mach/uncompress.h b/arch/arm/mach-s3c24xx/include/mach/uncompress.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/uncompress.h
rename to arch/arm/mach-s3c24xx/include/mach/uncompress.h
diff --git a/arch/arm/mach-s3c2410/include/mach/vr1000-cpld.h b/arch/arm/mach-s3c24xx/include/mach/vr1000-cpld.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/vr1000-cpld.h
rename to arch/arm/mach-s3c24xx/include/mach/vr1000-cpld.h
diff --git a/arch/arm/mach-s3c2410/include/mach/vr1000-irq.h b/arch/arm/mach-s3c24xx/include/mach/vr1000-irq.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/vr1000-irq.h
rename to arch/arm/mach-s3c24xx/include/mach/vr1000-irq.h
diff --git a/arch/arm/mach-s3c2410/include/mach/vr1000-map.h b/arch/arm/mach-s3c24xx/include/mach/vr1000-map.h
similarity index 100%
rename from arch/arm/mach-s3c2410/include/mach/vr1000-map.h
rename to arch/arm/mach-s3c24xx/include/mach/vr1000-map.h
diff --git a/arch/arm/mach-s3c2410/mach-amlm5900.c b/arch/arm/mach-s3c24xx/mach-amlm5900.c
similarity index 100%
rename from arch/arm/mach-s3c2410/mach-amlm5900.c
rename to arch/arm/mach-s3c24xx/mach-amlm5900.c
diff --git a/arch/arm/mach-s3c2410/mach-bast.c b/arch/arm/mach-s3c24xx/mach-bast.c
similarity index 100%
rename from arch/arm/mach-s3c2410/mach-bast.c
rename to arch/arm/mach-s3c24xx/mach-bast.c
diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c24xx/mach-h1940.c
similarity index 100%
rename from arch/arm/mach-s3c2410/mach-h1940.c
rename to arch/arm/mach-s3c24xx/mach-h1940.c
diff --git a/arch/arm/mach-s3c2410/mach-n30.c b/arch/arm/mach-s3c24xx/mach-n30.c
similarity index 100%
rename from arch/arm/mach-s3c2410/mach-n30.c
rename to arch/arm/mach-s3c24xx/mach-n30.c
diff --git a/arch/arm/mach-s3c2410/mach-otom.c b/arch/arm/mach-s3c24xx/mach-otom.c
similarity index 100%
rename from arch/arm/mach-s3c2410/mach-otom.c
rename to arch/arm/mach-s3c24xx/mach-otom.c
diff --git a/arch/arm/mach-s3c2410/mach-qt2410.c b/arch/arm/mach-s3c24xx/mach-qt2410.c
similarity index 100%
rename from arch/arm/mach-s3c2410/mach-qt2410.c
rename to arch/arm/mach-s3c24xx/mach-qt2410.c
diff --git a/arch/arm/mach-s3c2410/mach-smdk2410.c b/arch/arm/mach-s3c24xx/mach-smdk2410.c
similarity index 100%
rename from arch/arm/mach-s3c2410/mach-smdk2410.c
rename to arch/arm/mach-s3c24xx/mach-smdk2410.c
diff --git a/arch/arm/mach-s3c2410/mach-tct_hammer.c b/arch/arm/mach-s3c24xx/mach-tct_hammer.c
similarity index 100%
rename from arch/arm/mach-s3c2410/mach-tct_hammer.c
rename to arch/arm/mach-s3c24xx/mach-tct_hammer.c
diff --git a/arch/arm/mach-s3c2410/mach-vr1000.c b/arch/arm/mach-s3c24xx/mach-vr1000.c
similarity index 100%
rename from arch/arm/mach-s3c2410/mach-vr1000.c
rename to arch/arm/mach-s3c24xx/mach-vr1000.c
diff --git a/arch/arm/mach-s3c2410/nor-simtec.c b/arch/arm/mach-s3c24xx/nor-simtec.c
similarity index 100%
rename from arch/arm/mach-s3c2410/nor-simtec.c
rename to arch/arm/mach-s3c24xx/nor-simtec.c
diff --git a/arch/arm/mach-s3c2410/nor-simtec.h b/arch/arm/mach-s3c24xx/nor-simtec.h
similarity index 100%
rename from arch/arm/mach-s3c2410/nor-simtec.h
rename to arch/arm/mach-s3c24xx/nor-simtec.h
diff --git a/arch/arm/mach-s3c2410/pm-h1940.S b/arch/arm/mach-s3c24xx/pm-h1940.S
similarity index 100%
rename from arch/arm/mach-s3c2410/pm-h1940.S
rename to arch/arm/mach-s3c24xx/pm-h1940.S
diff --git a/arch/arm/mach-s3c2410/pm.c b/arch/arm/mach-s3c24xx/pm-s3c2410.c
similarity index 100%
rename from arch/arm/mach-s3c2410/pm.c
rename to arch/arm/mach-s3c24xx/pm-s3c2410.c
diff --git a/arch/arm/mach-s3c2410/s3c2410.c b/arch/arm/mach-s3c24xx/s3c2410.c
similarity index 100%
rename from arch/arm/mach-s3c2410/s3c2410.c
rename to arch/arm/mach-s3c24xx/s3c2410.c
diff --git a/arch/arm/mach-s3c2410/sleep.S b/arch/arm/mach-s3c24xx/sleep-s3c2410.S
similarity index 100%
rename from arch/arm/mach-s3c2410/sleep.S
rename to arch/arm/mach-s3c24xx/sleep-s3c2410.S
diff --git a/arch/arm/mach-s3c2410/usb-simtec.c b/arch/arm/mach-s3c24xx/usb-simtec.c
similarity index 100%
rename from arch/arm/mach-s3c2410/usb-simtec.c
rename to arch/arm/mach-s3c24xx/usb-simtec.c
diff --git a/arch/arm/mach-s3c2410/usb-simtec.h b/arch/arm/mach-s3c24xx/usb-simtec.h
similarity index 100%
rename from arch/arm/mach-s3c2410/usb-simtec.h
rename to arch/arm/mach-s3c24xx/usb-simtec.h
diff --git a/arch/arm/plat-s3c24xx/Kconfig b/arch/arm/plat-s3c24xx/Kconfig
index 5a67eda..0c183fd 100644
--- a/arch/arm/plat-s3c24xx/Kconfig
+++ b/arch/arm/plat-s3c24xx/Kconfig
@@ -82,7 +82,7 @@ config PM_SIMTEC
 	  Common power management code for systems that are
 	  compatible with the Simtec style of power management
 
-config S3C2410_DMA
+config S3C24XX_DMA
 	bool "S3C2410 DMA support"
 	depends on ARCH_S3C24XX
 	select S3C_DMA
diff --git a/arch/arm/plat-s3c24xx/Makefile b/arch/arm/plat-s3c24xx/Makefile
index 32bd295..bce27ca 100644
--- a/arch/arm/plat-s3c24xx/Makefile
+++ b/arch/arm/plat-s3c24xx/Makefile
@@ -29,7 +29,7 @@ obj-$(CONFIG_PM)		+= irq-pm.o
 obj-$(CONFIG_PM)		+= sleep.o
 obj-$(CONFIG_S3C2410_CLOCK)	+= s3c2410-clock.o
 obj-$(CONFIG_S3C2443_CLOCK)	+= s3c2443-clock.o
-obj-$(CONFIG_S3C2410_DMA)	+= dma.o
+obj-$(CONFIG_S3C24XX_DMA)	+= dma.o
 obj-$(CONFIG_S3C2410_IOTIMING)	+= s3c2410-iotiming.o
 obj-$(CONFIG_S3C2412_IOTIMING)	+= s3c2412-iotiming.o
 obj-$(CONFIG_S3C2410_CPUFREQ_UTILS) += s3c2410-cpufreq-utils.o
-- 
1.7.4.4
