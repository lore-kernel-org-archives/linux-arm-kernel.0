From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 12 May 2011 10:08:07 +0900
Subject: [PATCH 1/3] ARM: S5P6442: Removing ARCH_S5P6442
In-Reply-To: <1305162489-25499-1-git-send-email-kgene.kim@samsung.com>
References: <1305162489-25499-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1305162489-25499-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 Documentation/arm/Samsung/Overview.txt           |    2 -
 arch/arm/Kconfig                                 |   16 +-
 arch/arm/Makefile                                |    1 -
 arch/arm/common/Kconfig                          |    2 +-
 arch/arm/configs/s5p6442_defconfig               |   65 ----
 arch/arm/mach-s5p6442/Kconfig                    |   25 --
 arch/arm/mach-s5p6442/Makefile                   |   24 --
 arch/arm/mach-s5p6442/Makefile.boot              |    2 -
 arch/arm/mach-s5p6442/clock.c                    |  420 ----------------------
 arch/arm/mach-s5p6442/cpu.c                      |  143 --------
 arch/arm/mach-s5p6442/dev-audio.c                |  217 -----------
 arch/arm/mach-s5p6442/dev-spi.c                  |  121 -------
 arch/arm/mach-s5p6442/dma.c                      |  105 ------
 arch/arm/mach-s5p6442/include/mach/debug-macro.S |   35 --
 arch/arm/mach-s5p6442/include/mach/dma.h         |   26 --
 arch/arm/mach-s5p6442/include/mach/entry-macro.S |   48 ---
 arch/arm/mach-s5p6442/include/mach/gpio.h        |  123 -------
 arch/arm/mach-s5p6442/include/mach/hardware.h    |   18 -
 arch/arm/mach-s5p6442/include/mach/io.h          |   17 -
 arch/arm/mach-s5p6442/include/mach/irqs.h        |   87 -----
 arch/arm/mach-s5p6442/include/mach/map.h         |   76 ----
 arch/arm/mach-s5p6442/include/mach/memory.h      |   19 -
 arch/arm/mach-s5p6442/include/mach/pwm-clock.h   |   70 ----
 arch/arm/mach-s5p6442/include/mach/regs-clock.h  |  104 ------
 arch/arm/mach-s5p6442/include/mach/regs-irq.h    |   19 -
 arch/arm/mach-s5p6442/include/mach/spi-clocks.h  |   17 -
 arch/arm/mach-s5p6442/include/mach/system.h      |   23 --
 arch/arm/mach-s5p6442/include/mach/tick.h        |   26 --
 arch/arm/mach-s5p6442/include/mach/timex.h       |   24 --
 arch/arm/mach-s5p6442/include/mach/uncompress.h  |   24 --
 arch/arm/mach-s5p6442/include/mach/vmalloc.h     |   17 -
 arch/arm/mach-s5p6442/init.c                     |   44 ---
 arch/arm/mach-s5p6442/mach-smdk6442.c            |  102 ------
 arch/arm/mach-s5p6442/setup-i2c0.c               |   28 --
 arch/arm/plat-s5p/Kconfig                        |    2 +-
 arch/arm/plat-s5p/cpu.c                          |   10 -
 arch/arm/plat-s5p/include/plat/s5p6442.h         |   33 --
 arch/arm/plat-samsung/include/plat/cpu.h         |    1 -
 arch/arm/plat-samsung/include/plat/debug-macro.S |    2 +-
 arch/arm/plat-samsung/include/plat/devs.h        |    6 -
 arch/arm/plat-samsung/include/plat/regs-serial.h |    2 +-
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |    1 -
 42 files changed, 6 insertions(+), 2141 deletions(-)
 delete mode 100644 arch/arm/configs/s5p6442_defconfig
 delete mode 100644 arch/arm/mach-s5p6442/Kconfig
 delete mode 100644 arch/arm/mach-s5p6442/Makefile
 delete mode 100644 arch/arm/mach-s5p6442/Makefile.boot
 delete mode 100644 arch/arm/mach-s5p6442/clock.c
 delete mode 100644 arch/arm/mach-s5p6442/cpu.c
 delete mode 100644 arch/arm/mach-s5p6442/dev-audio.c
 delete mode 100644 arch/arm/mach-s5p6442/dev-spi.c
 delete mode 100644 arch/arm/mach-s5p6442/dma.c
 delete mode 100644 arch/arm/mach-s5p6442/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-s5p6442/include/mach/dma.h
 delete mode 100644 arch/arm/mach-s5p6442/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-s5p6442/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-s5p6442/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-s5p6442/include/mach/io.h
 delete mode 100644 arch/arm/mach-s5p6442/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-s5p6442/include/mach/map.h
 delete mode 100644 arch/arm/mach-s5p6442/include/mach/memory.h
 delete mode 100644 arch/arm/mach-s5p6442/include/mach/pwm-clock.h
 delete mode 100644 arch/arm/mach-s5p6442/include/mach/regs-clock.h
 delete mode 100644 arch/arm/mach-s5p6442/include/mach/regs-irq.h
 delete mode 100644 arch/arm/mach-s5p6442/include/mach/spi-clocks.h
 delete mode 100644 arch/arm/mach-s5p6442/include/mach/system.h
 delete mode 100644 arch/arm/mach-s5p6442/include/mach/tick.h
 delete mode 100644 arch/arm/mach-s5p6442/include/mach/timex.h
 delete mode 100644 arch/arm/mach-s5p6442/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-s5p6442/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-s5p6442/init.c
 delete mode 100644 arch/arm/mach-s5p6442/mach-smdk6442.c
 delete mode 100644 arch/arm/mach-s5p6442/setup-i2c0.c
 delete mode 100644 arch/arm/plat-s5p/include/plat/s5p6442.h

diff --git a/Documentation/arm/Samsung/Overview.txt b/Documentation/arm/Samsung/Overview.txt
index c3094ea..658abb2 100644
--- a/Documentation/arm/Samsung/Overview.txt
+++ b/Documentation/arm/Samsung/Overview.txt
@@ -14,7 +14,6 @@ Introduction
   - S3C24XX: See Documentation/arm/Samsung-S3C24XX/Overview.txt for full list
   - S3C64XX: S3C6400 and S3C6410
   - S5P6440
-  - S5P6442
   - S5PC100
   - S5PC110 / S5PV210
 
@@ -36,7 +35,6 @@ Configuration
   unifying all the SoCs into one kernel.
 
   s5p6440_defconfig - S5P6440 specific default configuration
-  s5p6442_defconfig - S5P6442 specific default configuration
   s5pc100_defconfig - S5PC100 specific default configuration
   s5pc110_defconfig - S5PC110 specific default configuration
   s5pv210_defconfig - S5PV210 specific default configuration
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 377a7a5..e81c72c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -736,16 +736,6 @@ config ARCH_S5P64X0
 	  Samsung S5P64X0 CPU based systems, such as the Samsung SMDK6440,
 	  SMDK6450.
 
-config ARCH_S5P6442
-	bool "Samsung S5P6442"
-	select CPU_V6
-	select GENERIC_GPIO
-	select HAVE_CLK
-	select ARCH_USES_GETTIMEOFFSET
-	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-	help
-	  Samsung S5P6442 CPU based systems
-
 config ARCH_S5PC100
 	bool "Samsung S5PC100"
 	select GENERIC_GPIO
@@ -995,8 +985,6 @@ endif
 
 source "arch/arm/mach-s5p64x0/Kconfig"
 
-source "arch/arm/mach-s5p6442/Kconfig"
-
 source "arch/arm/mach-s5pc100/Kconfig"
 
 source "arch/arm/mach-s5pv210/Kconfig"
@@ -1424,7 +1412,7 @@ source kernel/Kconfig.preempt
 config HZ
 	int
 	default 200 if ARCH_EBSA110 || ARCH_S3C2410 || ARCH_S5P64X0 || \
-		ARCH_S5P6442 || ARCH_S5PV210 || ARCH_EXYNOS4
+		ARCH_S5PV210 || ARCH_EXYNOS4
 	default OMAP_32K_TIMER_HZ if ARCH_OMAP && OMAP_32K_TIMER
 	default AT91_TIMER_HZ if ARCH_AT91
 	default SHMOBILE_TIMER_HZ if ARCH_SHMOBILE
@@ -2010,7 +1998,7 @@ menu "Power management options"
 source "kernel/power/Kconfig"
 
 config ARCH_SUSPEND_POSSIBLE
-	depends on !ARCH_S5P64X0 && !ARCH_S5P6442
+	depends on !ARCH_S5P64X0
 	depends on CPU_ARM920T || CPU_ARM926T || CPU_SA1100 || \
 		CPU_V6 || CPU_V6K || CPU_V7 || CPU_XSC3 || CPU_XSCALE
 	def_bool y
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index c7d321a..c17304b 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -178,7 +178,6 @@ machine-$(CONFIG_ARCH_S3C2410)		:= s3c2410 s3c2400 s3c2412 s3c2416 s3c2440 s3c24
 machine-$(CONFIG_ARCH_S3C24A0)		:= s3c24a0
 machine-$(CONFIG_ARCH_S3C64XX)		:= s3c64xx
 machine-$(CONFIG_ARCH_S5P64X0)		:= s5p64x0
-machine-$(CONFIG_ARCH_S5P6442)		:= s5p6442
 machine-$(CONFIG_ARCH_S5PC100)		:= s5pc100
 machine-$(CONFIG_ARCH_S5PV210)		:= s5pv210
 machine-$(CONFIG_ARCH_EXYNOS4)		:= exynos4
diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index ea5ee4d..4b71766 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -7,7 +7,7 @@ config ARM_VIC
 config ARM_VIC_NR
 	int
 	default 4 if ARCH_S5PV210
-	default 3 if ARCH_S5P6442 || ARCH_S5PC100
+	default 3 if ARCH_S5PC100
 	default 2
 	depends on ARM_VIC
 	help
diff --git a/arch/arm/configs/s5p6442_defconfig b/arch/arm/configs/s5p6442_defconfig
deleted file mode 100644
index 0e92a78..0000000
--- a/arch/arm/configs/s5p6442_defconfig
+++ /dev/null
@@ -1,65 +0,0 @@
-CONFIG_EXPERIMENTAL=y
-CONFIG_SYSFS_DEPRECATED_V2=y
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_KALLSYMS_ALL=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_S5P6442=y
-CONFIG_S3C_LOWLEVEL_UART_PORT=1
-CONFIG_MACH_SMDK6442=y
-CONFIG_CPU_32v6K=y
-CONFIG_AEABI=y
-CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x20800000,8M console=ttySAC1,115200 init=/linuxrc"
-CONFIG_FPE_NWFPE=y
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-# CONFIG_PREVENT_FIRMWARE_BUILD is not set
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=8192
-# CONFIG_MISC_DEVICES is not set
-CONFIG_SCSI=y
-CONFIG_BLK_DEV_SD=y
-CONFIG_CHR_DEV_SG=y
-CONFIG_INPUT_EVDEV=y
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-CONFIG_INPUT_TOUCHSCREEN=y
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_NR_UARTS=3
-CONFIG_SERIAL_SAMSUNG=y
-CONFIG_SERIAL_SAMSUNG_CONSOLE=y
-CONFIG_HW_RANDOM=y
-# CONFIG_HWMON is not set
-# CONFIG_VGA_CONSOLE is not set
-# CONFIG_HID_SUPPORT is not set
-# CONFIG_USB_SUPPORT is not set
-CONFIG_EXT2_FS=y
-CONFIG_INOTIFY=y
-CONFIG_MSDOS_FS=y
-CONFIG_VFAT_FS=y
-CONFIG_TMPFS=y
-CONFIG_TMPFS_POSIX_ACL=y
-CONFIG_CRAMFS=y
-CONFIG_ROMFS_FS=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_BSD_DISKLABEL=y
-CONFIG_SOLARIS_X86_PARTITION=y
-CONFIG_NLS_CODEPAGE_437=y
-CONFIG_NLS_ASCII=y
-CONFIG_NLS_ISO8859_1=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_RT_MUTEXES=y
-CONFIG_DEBUG_SPINLOCK=y
-CONFIG_DEBUG_MUTEXES=y
-CONFIG_DEBUG_SPINLOCK_SLEEP=y
-CONFIG_DEBUG_INFO=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
-CONFIG_SYSCTL_SYSCALL_CHECK=y
-# CONFIG_ARM_UNWIND is not set
-CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_ERRORS=y
-CONFIG_DEBUG_LL=y
-CONFIG_DEBUG_S3C_UART=1
-CONFIG_CRC_CCITT=y
diff --git a/arch/arm/mach-s5p6442/Kconfig b/arch/arm/mach-s5p6442/Kconfig
deleted file mode 100644
index 33569e4..0000000
--- a/arch/arm/mach-s5p6442/Kconfig
+++ /dev/null
@@ -1,25 +0,0 @@
-# arch/arm/mach-s5p6442/Kconfig
-#
-# Copyright (c) 2010 Samsung Electronics Co., Ltd.
-#		http://www.samsung.com/
-#
-# Licensed under GPLv2
-
-# Configuration options for the S5P6442
-
-if ARCH_S5P6442
-
-config CPU_S5P6442
-	bool
-	select S3C_PL330_DMA
-	help
-	  Enable S5P6442 CPU support
-
-config MACH_SMDK6442
-	bool "SMDK6442"
-	select CPU_S5P6442
-	select S3C_DEV_WDT
-	help
-	  Machine support for Samsung SMDK6442
-
-endif
diff --git a/arch/arm/mach-s5p6442/Makefile b/arch/arm/mach-s5p6442/Makefile
deleted file mode 100644
index 90a3d83..0000000
--- a/arch/arm/mach-s5p6442/Makefile
+++ /dev/null
@@ -1,24 +0,0 @@
-# arch/arm/mach-s5p6442/Makefile
-#
-# Copyright (c) 2010 Samsung Electronics Co., Ltd.
-# 		http://www.samsung.com/
-#
-# Licensed under GPLv2
-
-obj-y				:=
-obj-m				:=
-obj-n				:=
-obj-				:=
-
-# Core support for S5P6442 system
-
-obj-$(CONFIG_CPU_S5P6442)	+= cpu.o init.o clock.o dma.o
-obj-$(CONFIG_CPU_S5P6442)	+= setup-i2c0.o
-
-# machine support
-
-obj-$(CONFIG_MACH_SMDK6442)	+= mach-smdk6442.o
-
-# device support
-obj-y				+= dev-audio.o
-obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
diff --git a/arch/arm/mach-s5p6442/Makefile.boot b/arch/arm/mach-s5p6442/Makefile.boot
deleted file mode 100644
index ff90aa1..0000000
--- a/arch/arm/mach-s5p6442/Makefile.boot
+++ /dev/null
@@ -1,2 +0,0 @@
-   zreladdr-y	:= 0x20008000
-params_phys-y	:= 0x20000100
diff --git a/arch/arm/mach-s5p6442/clock.c b/arch/arm/mach-s5p6442/clock.c
deleted file mode 100644
index fbbc7be..0000000
--- a/arch/arm/mach-s5p6442/clock.c
+++ /dev/null
@@ -1,420 +0,0 @@
-/* linux/arch/arm/mach-s5p6442/clock.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5P6442 - Clock support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-
-#include <mach/map.h>
-
-#include <plat/cpu-freq.h>
-#include <mach/regs-clock.h>
-#include <plat/clock.h>
-#include <plat/cpu.h>
-#include <plat/pll.h>
-#include <plat/s5p-clock.h>
-#include <plat/clock-clksrc.h>
-#include <plat/s5p6442.h>
-
-static struct clksrc_clk clk_mout_apll = {
-	.clk	= {
-		.name		= "mout_apll",
-		.id		= -1,
-	},
-	.sources	= &clk_src_apll,
-	.reg_src	= { .reg = S5P_CLK_SRC0, .shift = 0, .size = 1 },
-};
-
-static struct clksrc_clk clk_mout_mpll = {
-	.clk = {
-		.name		= "mout_mpll",
-		.id		= -1,
-	},
-	.sources	= &clk_src_mpll,
-	.reg_src	= { .reg = S5P_CLK_SRC0, .shift = 4, .size = 1 },
-};
-
-static struct clksrc_clk clk_mout_epll = {
-	.clk	= {
-		.name		= "mout_epll",
-		.id		= -1,
-	},
-	.sources	= &clk_src_epll,
-	.reg_src	= { .reg = S5P_CLK_SRC0, .shift = 8, .size = 1 },
-};
-
-/* Possible clock sources for ARM Mux */
-static struct clk *clk_src_arm_list[] = {
-	[1] = &clk_mout_apll.clk,
-	[2] = &clk_mout_mpll.clk,
-};
-
-static struct clksrc_sources clk_src_arm = {
-	.sources	= clk_src_arm_list,
-	.nr_sources	= ARRAY_SIZE(clk_src_arm_list),
-};
-
-static struct clksrc_clk clk_mout_arm = {
-	.clk	= {
-		.name		= "mout_arm",
-		.id		= -1,
-	},
-	.sources	= &clk_src_arm,
-	.reg_src	= { .reg = S5P_CLK_MUX_STAT0, .shift = 16, .size = 3 },
-};
-
-static struct clk clk_dout_a2m = {
-	.name		= "dout_a2m",
-	.id		= -1,
-	.parent		= &clk_mout_apll.clk,
-};
-
-/* Possible clock sources for D0 Mux */
-static struct clk *clk_src_d0_list[] = {
-	[1] = &clk_mout_mpll.clk,
-	[2] = &clk_dout_a2m,
-};
-
-static struct clksrc_sources clk_src_d0 = {
-	.sources	= clk_src_d0_list,
-	.nr_sources	= ARRAY_SIZE(clk_src_d0_list),
-};
-
-static struct clksrc_clk clk_mout_d0 = {
-	.clk = {
-		.name		= "mout_d0",
-		.id		= -1,
-	},
-	.sources	= &clk_src_d0,
-	.reg_src	= { .reg = S5P_CLK_MUX_STAT0, .shift = 20, .size = 3 },
-};
-
-static struct clk clk_dout_apll = {
-	.name		= "dout_apll",
-	.id		= -1,
-	.parent		= &clk_mout_arm.clk,
-};
-
-/* Possible clock sources for D0SYNC Mux */
-static struct clk *clk_src_d0sync_list[] = {
-	[1] = &clk_mout_d0.clk,
-	[2] = &clk_dout_apll,
-};
-
-static struct clksrc_sources clk_src_d0sync = {
-	.sources	= clk_src_d0sync_list,
-	.nr_sources	= ARRAY_SIZE(clk_src_d0sync_list),
-};
-
-static struct clksrc_clk clk_mout_d0sync = {
-	.clk	= {
-		.name		= "mout_d0sync",
-		.id		= -1,
-	},
-	.sources	= &clk_src_d0sync,
-	.reg_src	= { .reg = S5P_CLK_MUX_STAT1, .shift = 28, .size = 3 },
-};
-
-/* Possible clock sources for D1 Mux */
-static struct clk *clk_src_d1_list[] = {
-	[1] = &clk_mout_mpll.clk,
-	[2] = &clk_dout_a2m,
-};
-
-static struct clksrc_sources clk_src_d1 = {
-	.sources	= clk_src_d1_list,
-	.nr_sources	= ARRAY_SIZE(clk_src_d1_list),
-};
-
-static struct clksrc_clk clk_mout_d1 = {
-	.clk	= {
-		.name		= "mout_d1",
-		.id		= -1,
-	},
-	.sources	= &clk_src_d1,
-	.reg_src	= { .reg = S5P_CLK_MUX_STAT0, .shift = 24, .size = 3 },
-};
-
-/* Possible clock sources for D1SYNC Mux */
-static struct clk *clk_src_d1sync_list[] = {
-	[1] = &clk_mout_d1.clk,
-	[2] = &clk_dout_apll,
-};
-
-static struct clksrc_sources clk_src_d1sync = {
-	.sources	= clk_src_d1sync_list,
-	.nr_sources	= ARRAY_SIZE(clk_src_d1sync_list),
-};
-
-static struct clksrc_clk clk_mout_d1sync = {
-	.clk	= {
-		.name		= "mout_d1sync",
-		.id		= -1,
-	},
-	.sources	= &clk_src_d1sync,
-	.reg_src	= { .reg = S5P_CLK_MUX_STAT1, .shift = 24, .size = 3 },
-};
-
-static struct clk clk_hclkd0 = {
-	.name		= "hclkd0",
-	.id		= -1,
-	.parent		= &clk_mout_d0sync.clk,
-};
-
-static struct clk clk_hclkd1 = {
-	.name		= "hclkd1",
-	.id		= -1,
-	.parent		= &clk_mout_d1sync.clk,
-};
-
-static struct clk clk_pclkd0 = {
-	.name		= "pclkd0",
-	.id		= -1,
-	.parent		= &clk_hclkd0,
-};
-
-static struct clk clk_pclkd1 = {
-	.name		= "pclkd1",
-	.id		= -1,
-	.parent		= &clk_hclkd1,
-};
-
-int s5p6442_clk_ip0_ctrl(struct clk *clk, int enable)
-{
-	return s5p_gatectrl(S5P_CLKGATE_IP0, clk, enable);
-}
-
-int s5p6442_clk_ip3_ctrl(struct clk *clk, int enable)
-{
-	return s5p_gatectrl(S5P_CLKGATE_IP3, clk, enable);
-}
-
-static struct clksrc_clk clksrcs[] = {
-	{
-		.clk	= {
-			.name		= "dout_a2m",
-			.id		= -1,
-			.parent		= &clk_mout_apll.clk,
-		},
-		.sources = &clk_src_apll,
-		.reg_src = { .reg = S5P_CLK_SRC0, .shift = 0, .size = 1 },
-		.reg_div = { .reg = S5P_CLK_DIV0, .shift = 4, .size = 3 },
-	}, {
-		.clk	= {
-			.name		= "dout_apll",
-			.id		= -1,
-			.parent		= &clk_mout_arm.clk,
-		},
-		.sources = &clk_src_arm,
-		.reg_src = { .reg = S5P_CLK_MUX_STAT0, .shift = 16, .size = 3 },
-		.reg_div = { .reg = S5P_CLK_DIV0, .shift = 0, .size = 3 },
-	}, {
-		.clk	= {
-			.name		= "hclkd1",
-			.id		= -1,
-			.parent		= &clk_mout_d1sync.clk,
-		},
-		.sources = &clk_src_d1sync,
-		.reg_src = { .reg = S5P_CLK_MUX_STAT1, .shift = 24, .size = 3 },
-		.reg_div = { .reg = S5P_CLK_DIV0, .shift = 24, .size = 4 },
-	}, {
-		.clk	= {
-			.name		= "hclkd0",
-			.id		= -1,
-			.parent		= &clk_mout_d0sync.clk,
-		},
-		.sources = &clk_src_d0sync,
-		.reg_src = { .reg = S5P_CLK_MUX_STAT1, .shift = 28, .size = 3 },
-		.reg_div = { .reg = S5P_CLK_DIV0, .shift = 16, .size = 4 },
-	}, {
-		.clk	= {
-			.name		= "pclkd0",
-			.id		= -1,
-			.parent		= &clk_hclkd0,
-		},
-		.sources = &clk_src_d0sync,
-		.reg_src = { .reg = S5P_CLK_MUX_STAT1, .shift = 28, .size = 3 },
-		.reg_div = { .reg = S5P_CLK_DIV0, .shift = 20, .size = 3 },
-	}, {
-		.clk	= {
-			.name		= "pclkd1",
-			.id		= -1,
-			.parent		= &clk_hclkd1,
-		},
-		.sources = &clk_src_d1sync,
-		.reg_src = { .reg = S5P_CLK_MUX_STAT1, .shift = 24, .size = 3 },
-		.reg_div = { .reg = S5P_CLK_DIV0, .shift = 28, .size = 3 },
-	}
-};
-
-/* Clock initialisation code */
-static struct clksrc_clk *init_parents[] = {
-	&clk_mout_apll,
-	&clk_mout_mpll,
-	&clk_mout_epll,
-	&clk_mout_arm,
-	&clk_mout_d0,
-	&clk_mout_d0sync,
-	&clk_mout_d1,
-	&clk_mout_d1sync,
-};
-
-void __init_or_cpufreq s5p6442_setup_clocks(void)
-{
-	struct clk *pclkd0_clk;
-	struct clk *pclkd1_clk;
-
-	unsigned long xtal;
-	unsigned long arm;
-	unsigned long hclkd0 = 0;
-	unsigned long hclkd1 = 0;
-	unsigned long pclkd0 = 0;
-	unsigned long pclkd1 = 0;
-
-	unsigned long apll;
-	unsigned long mpll;
-	unsigned long epll;
-	unsigned int ptr;
-
-	printk(KERN_DEBUG "%s: registering clocks\n", __func__);
-
-	xtal = clk_get_rate(&clk_xtal);
-
-	printk(KERN_DEBUG "%s: xtal is %ld\n", __func__, xtal);
-
-	apll = s5p_get_pll45xx(xtal, __raw_readl(S5P_APLL_CON), pll_4508);
-	mpll = s5p_get_pll45xx(xtal, __raw_readl(S5P_MPLL_CON), pll_4502);
-	epll = s5p_get_pll45xx(xtal, __raw_readl(S5P_EPLL_CON), pll_4500);
-
-	printk(KERN_INFO "S5P6442: PLL settings, A=%ld, M=%ld, E=%ld",
-			apll, mpll, epll);
-
-	clk_fout_apll.rate = apll;
-	clk_fout_mpll.rate = mpll;
-	clk_fout_epll.rate = epll;
-
-	for (ptr = 0; ptr < ARRAY_SIZE(init_parents); ptr++)
-		s3c_set_clksrc(init_parents[ptr], true);
-
-	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
-		s3c_set_clksrc(&clksrcs[ptr], true);
-
-	arm = clk_get_rate(&clk_dout_apll);
-	hclkd0 = clk_get_rate(&clk_hclkd0);
-	hclkd1 = clk_get_rate(&clk_hclkd1);
-
-	pclkd0_clk = clk_get(NULL, "pclkd0");
-	BUG_ON(IS_ERR(pclkd0_clk));
-
-	pclkd0 = clk_get_rate(pclkd0_clk);
-	clk_put(pclkd0_clk);
-
-	pclkd1_clk = clk_get(NULL, "pclkd1");
-	BUG_ON(IS_ERR(pclkd1_clk));
-
-	pclkd1 = clk_get_rate(pclkd1_clk);
-	clk_put(pclkd1_clk);
-
-	printk(KERN_INFO "S5P6442: HCLKD0=%ld, HCLKD1=%ld, PCLKD0=%ld, PCLKD1=%ld\n",
-			hclkd0, hclkd1, pclkd0, pclkd1);
-
-	/* For backward compatibility */
-	clk_f.rate = arm;
-	clk_h.rate = hclkd1;
-	clk_p.rate = pclkd1;
-
-	clk_pclkd0.rate = pclkd0;
-	clk_pclkd1.rate = pclkd1;
-}
-
-static struct clk init_clocks_off[] = {
-	{
-		.name		= "pdma",
-		.id		= -1,
-		.parent		= &clk_pclkd1,
-		.enable		= s5p6442_clk_ip0_ctrl,
-		.ctrlbit	= (1 << 3),
-	},
-};
-
-static struct clk init_clocks[] = {
-	{
-		.name		= "systimer",
-		.id		= -1,
-		.parent		= &clk_pclkd1,
-		.enable		= s5p6442_clk_ip3_ctrl,
-		.ctrlbit	= (1<<16),
-	}, {
-		.name		= "uart",
-		.id		= 0,
-		.parent		= &clk_pclkd1,
-		.enable		= s5p6442_clk_ip3_ctrl,
-		.ctrlbit	= (1<<17),
-	}, {
-		.name		= "uart",
-		.id		= 1,
-		.parent		= &clk_pclkd1,
-		.enable		= s5p6442_clk_ip3_ctrl,
-		.ctrlbit	= (1<<18),
-	}, {
-		.name		= "uart",
-		.id		= 2,
-		.parent		= &clk_pclkd1,
-		.enable		= s5p6442_clk_ip3_ctrl,
-		.ctrlbit	= (1<<19),
-	}, {
-		.name		= "watchdog",
-		.id		= -1,
-		.parent		= &clk_pclkd1,
-		.enable		= s5p6442_clk_ip3_ctrl,
-		.ctrlbit	= (1 << 22),
-	}, {
-		.name		= "timers",
-		.id		= -1,
-		.parent		= &clk_pclkd1,
-		.enable		= s5p6442_clk_ip3_ctrl,
-		.ctrlbit	= (1<<23),
-	},
-};
-
-static struct clk *clks[] __initdata = {
-	&clk_ext,
-	&clk_epll,
-	&clk_mout_apll.clk,
-	&clk_mout_mpll.clk,
-	&clk_mout_epll.clk,
-	&clk_mout_d0.clk,
-	&clk_mout_d0sync.clk,
-	&clk_mout_d1.clk,
-	&clk_mout_d1sync.clk,
-	&clk_hclkd0,
-	&clk_pclkd0,
-	&clk_hclkd1,
-	&clk_pclkd1,
-};
-
-void __init s5p6442_register_clocks(void)
-{
-	s3c24xx_register_clocks(clks, ARRAY_SIZE(clks));
-
-	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
-	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
-
-	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
-	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
-
-	s3c_pwmclk_init();
-}
diff --git a/arch/arm/mach-s5p6442/cpu.c b/arch/arm/mach-s5p6442/cpu.c
deleted file mode 100644
index 842af86..0000000
--- a/arch/arm/mach-s5p6442/cpu.c
+++ /dev/null
@@ -1,143 +0,0 @@
-/* linux/arch/arm/mach-s5p6442/cpu.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/list.h>
-#include <linux/timer.h>
-#include <linux/init.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/sysdev.h>
-#include <linux/serial_core.h>
-#include <linux/platform_device.h>
-#include <linux/sched.h>
-
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <asm/mach/irq.h>
-
-#include <asm/proc-fns.h>
-
-#include <mach/hardware.h>
-#include <mach/map.h>
-#include <asm/irq.h>
-
-#include <plat/regs-serial.h>
-#include <mach/regs-clock.h>
-
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/clock.h>
-#include <plat/s5p6442.h>
-
-/* Initial IO mappings */
-
-static struct map_desc s5p6442_iodesc[] __initdata = {
-	{
-		.virtual	= (unsigned long)S5P_VA_SYSTIMER,
-		.pfn		= __phys_to_pfn(S5P6442_PA_SYSTIMER),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S5P_VA_GPIO,
-		.pfn		= __phys_to_pfn(S5P6442_PA_GPIO),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)VA_VIC0,
-		.pfn		= __phys_to_pfn(S5P6442_PA_VIC0),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)VA_VIC1,
-		.pfn		= __phys_to_pfn(S5P6442_PA_VIC1),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)VA_VIC2,
-		.pfn		= __phys_to_pfn(S5P6442_PA_VIC2),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S3C_VA_UART,
-		.pfn		= __phys_to_pfn(S3C_PA_UART),
-		.length		= SZ_512K,
-		.type		= MT_DEVICE,
-	}
-};
-
-static void s5p6442_idle(void)
-{
-	if (!need_resched())
-		cpu_do_idle();
-
-	local_irq_enable();
-}
-
-/*
- * s5p6442_map_io
- *
- * register the standard cpu IO areas
- */
-
-void __init s5p6442_map_io(void)
-{
-	iotable_init(s5p6442_iodesc, ARRAY_SIZE(s5p6442_iodesc));
-}
-
-void __init s5p6442_init_clocks(int xtal)
-{
-	printk(KERN_DEBUG "%s: initializing clocks\n", __func__);
-
-	s3c24xx_register_baseclocks(xtal);
-	s5p_register_clocks(xtal);
-	s5p6442_register_clocks();
-	s5p6442_setup_clocks();
-}
-
-void __init s5p6442_init_irq(void)
-{
-	/* S5P6442 supports 3 VIC */
-	u32 vic[3];
-
-	/* VIC0, VIC1, and VIC2: some interrupt reserved */
-	vic[0] = 0x7fefffff;
-	vic[1] = 0X7f389c81;
-	vic[2] = 0X1bbbcfff;
-
-	s5p_init_irq(vic, ARRAY_SIZE(vic));
-}
-
-struct sysdev_class s5p6442_sysclass = {
-	.name	= "s5p6442-core",
-};
-
-static struct sys_device s5p6442_sysdev = {
-	.cls	= &s5p6442_sysclass,
-};
-
-static int __init s5p6442_core_init(void)
-{
-	return sysdev_class_register(&s5p6442_sysclass);
-}
-
-core_initcall(s5p6442_core_init);
-
-int __init s5p6442_init(void)
-{
-	printk(KERN_INFO "S5P6442: Initializing architecture\n");
-
-	/* set idle function */
-	pm_idle = s5p6442_idle;
-
-	return sysdev_register(&s5p6442_sysdev);
-}
diff --git a/arch/arm/mach-s5p6442/dev-audio.c b/arch/arm/mach-s5p6442/dev-audio.c
deleted file mode 100644
index 8719dc4..0000000
--- a/arch/arm/mach-s5p6442/dev-audio.c
+++ /dev/null
@@ -1,217 +0,0 @@
-/* linux/arch/arm/mach-s5p6442/dev-audio.c
- *
- * Copyright (c) 2010 Samsung Electronics Co. Ltd
- *	Jaswinder Singh <jassi.brar@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/platform_device.h>
-#include <linux/dma-mapping.h>
-#include <linux/gpio.h>
-
-#include <plat/gpio-cfg.h>
-#include <plat/audio.h>
-
-#include <mach/map.h>
-#include <mach/dma.h>
-#include <mach/irqs.h>
-
-static int s5p6442_cfg_i2s(struct platform_device *pdev)
-{
-	unsigned int base;
-
-	/* configure GPIO for i2s port */
-	switch (pdev->id) {
-	case 1:
-		base = S5P6442_GPC1(0);
-		break;
-
-	case 0:
-		base = S5P6442_GPC0(0);
-		break;
-
-	default:
-		printk(KERN_ERR "Invalid Device %d\n", pdev->id);
-		return -EINVAL;
-	}
-
-	s3c_gpio_cfgpin_range(base, 5, S3C_GPIO_SFN(2));
-	return 0;
-}
-
-static const char *rclksrc_v35[] = {
-	[0] = "busclk",
-	[1] = "i2sclk",
-};
-
-static struct s3c_audio_pdata i2sv35_pdata = {
-	.cfg_gpio = s5p6442_cfg_i2s,
-	.type = {
-		.i2s = {
-			.quirks = QUIRK_SEC_DAI | QUIRK_NEED_RSTCLR,
-			.src_clk = rclksrc_v35,
-		},
-	},
-};
-
-static struct resource s5p6442_iis0_resource[] = {
-	[0] = {
-		.start = S5P6442_PA_I2S0,
-		.end   = S5P6442_PA_I2S0 + 0x100 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = DMACH_I2S0_TX,
-		.end   = DMACH_I2S0_TX,
-		.flags = IORESOURCE_DMA,
-	},
-	[2] = {
-		.start = DMACH_I2S0_RX,
-		.end   = DMACH_I2S0_RX,
-		.flags = IORESOURCE_DMA,
-	},
-	[3] = {
-		.start = DMACH_I2S0S_TX,
-		.end = DMACH_I2S0S_TX,
-		.flags = IORESOURCE_DMA,
-	},
-};
-
-struct platform_device s5p6442_device_iis0 = {
-	.name = "samsung-i2s",
-	.id = 0,
-	.num_resources	  = ARRAY_SIZE(s5p6442_iis0_resource),
-	.resource	  = s5p6442_iis0_resource,
-	.dev = {
-		.platform_data = &i2sv35_pdata,
-	},
-};
-
-static const char *rclksrc_v3[] = {
-	[0] = "iis",
-	[1] = "sclk_audio",
-};
-
-static struct s3c_audio_pdata i2sv3_pdata = {
-	.cfg_gpio = s5p6442_cfg_i2s,
-	.type = {
-		.i2s = {
-			.src_clk = rclksrc_v3,
-		},
-	},
-};
-
-static struct resource s5p6442_iis1_resource[] = {
-	[0] = {
-		.start = S5P6442_PA_I2S1,
-		.end   = S5P6442_PA_I2S1 + 0x100 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = DMACH_I2S1_TX,
-		.end   = DMACH_I2S1_TX,
-		.flags = IORESOURCE_DMA,
-	},
-	[2] = {
-		.start = DMACH_I2S1_RX,
-		.end   = DMACH_I2S1_RX,
-		.flags = IORESOURCE_DMA,
-	},
-};
-
-struct platform_device s5p6442_device_iis1 = {
-	.name		  = "samsung-i2s",
-	.id		  = 1,
-	.num_resources	  = ARRAY_SIZE(s5p6442_iis1_resource),
-	.resource	  = s5p6442_iis1_resource,
-	.dev = {
-		.platform_data = &i2sv3_pdata,
-	},
-};
-
-/* PCM Controller platform_devices */
-
-static int s5p6442_pcm_cfg_gpio(struct platform_device *pdev)
-{
-	unsigned int base;
-
-	switch (pdev->id) {
-	case 0:
-		base = S5P6442_GPC0(0);
-		break;
-
-	case 1:
-		base = S5P6442_GPC1(0);
-		break;
-
-	default:
-		printk(KERN_DEBUG "Invalid PCM Controller number!");
-		return -EINVAL;
-	}
-
-	s3c_gpio_cfgpin_range(base, 5, S3C_GPIO_SFN(3));
-	return 0;
-}
-
-static struct s3c_audio_pdata s3c_pcm_pdata = {
-	.cfg_gpio = s5p6442_pcm_cfg_gpio,
-};
-
-static struct resource s5p6442_pcm0_resource[] = {
-	[0] = {
-		.start = S5P6442_PA_PCM0,
-		.end   = S5P6442_PA_PCM0 + 0x100 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = DMACH_PCM0_TX,
-		.end   = DMACH_PCM0_TX,
-		.flags = IORESOURCE_DMA,
-	},
-	[2] = {
-		.start = DMACH_PCM0_RX,
-		.end   = DMACH_PCM0_RX,
-		.flags = IORESOURCE_DMA,
-	},
-};
-
-struct platform_device s5p6442_device_pcm0 = {
-	.name		  = "samsung-pcm",
-	.id		  = 0,
-	.num_resources	  = ARRAY_SIZE(s5p6442_pcm0_resource),
-	.resource	  = s5p6442_pcm0_resource,
-	.dev = {
-		.platform_data = &s3c_pcm_pdata,
-	},
-};
-
-static struct resource s5p6442_pcm1_resource[] = {
-	[0] = {
-		.start = S5P6442_PA_PCM1,
-		.end   = S5P6442_PA_PCM1 + 0x100 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = DMACH_PCM1_TX,
-		.end   = DMACH_PCM1_TX,
-		.flags = IORESOURCE_DMA,
-	},
-	[2] = {
-		.start = DMACH_PCM1_RX,
-		.end   = DMACH_PCM1_RX,
-		.flags = IORESOURCE_DMA,
-	},
-};
-
-struct platform_device s5p6442_device_pcm1 = {
-	.name		  = "samsung-pcm",
-	.id		  = 1,
-	.num_resources	  = ARRAY_SIZE(s5p6442_pcm1_resource),
-	.resource	  = s5p6442_pcm1_resource,
-	.dev = {
-		.platform_data = &s3c_pcm_pdata,
-	},
-};
diff --git a/arch/arm/mach-s5p6442/dev-spi.c b/arch/arm/mach-s5p6442/dev-spi.c
deleted file mode 100644
index cce8c24..0000000
--- a/arch/arm/mach-s5p6442/dev-spi.c
+++ /dev/null
@@ -1,121 +0,0 @@
-/* linux/arch/arm/mach-s5p6442/dev-spi.c
- *
- * Copyright (C) 2010 Samsung Electronics Co. Ltd.
- *	Jaswinder Singh <jassi.brar@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/platform_device.h>
-#include <linux/dma-mapping.h>
-#include <linux/gpio.h>
-
-#include <mach/dma.h>
-#include <mach/map.h>
-#include <mach/irqs.h>
-#include <mach/spi-clocks.h>
-
-#include <plat/s3c64xx-spi.h>
-#include <plat/gpio-cfg.h>
-
-static char *spi_src_clks[] = {
-	[S5P6442_SPI_SRCCLK_PCLK] = "pclk",
-	[S5P6442_SPI_SRCCLK_SCLK] = "spi_epll",
-};
-
-/* SPI Controller platform_devices */
-
-/* Since we emulate multi-cs capability, we do not touch the CS.
- * The emulated CS is toggled by board specific mechanism, as it can
- * be either some immediate GPIO or some signal out of some other
- * chip in between ... or some yet another way.
- * We simply do not assume anything about CS.
- */
-static int s5p6442_spi_cfg_gpio(struct platform_device *pdev)
-{
-	switch (pdev->id) {
-	case 0:
-		s3c_gpio_cfgpin(S5P6442_GPB(0), S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(S5P6442_GPB(0), S3C_GPIO_PULL_UP);
-		s3c_gpio_cfgall_range(S5P6442_GPB(2), 2,
-				      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
-		break;
-
-	default:
-		dev_err(&pdev->dev, "Invalid SPI Controller number!");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static struct resource s5p6442_spi0_resource[] = {
-	[0] = {
-		.start = S5P6442_PA_SPI,
-		.end   = S5P6442_PA_SPI + 0x100 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = DMACH_SPI0_TX,
-		.end   = DMACH_SPI0_TX,
-		.flags = IORESOURCE_DMA,
-	},
-	[2] = {
-		.start = DMACH_SPI0_RX,
-		.end   = DMACH_SPI0_RX,
-		.flags = IORESOURCE_DMA,
-	},
-	[3] = {
-		.start = IRQ_SPI0,
-		.end   = IRQ_SPI0,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-static struct s3c64xx_spi_info s5p6442_spi0_pdata = {
-	.cfg_gpio = s5p6442_spi_cfg_gpio,
-	.fifo_lvl_mask = 0x1ff,
-	.rx_lvl_offset = 15,
-};
-
-static u64 spi_dmamask = DMA_BIT_MASK(32);
-
-struct platform_device s5p6442_device_spi = {
-	.name		  = "s3c64xx-spi",
-	.id		  = 0,
-	.num_resources	  = ARRAY_SIZE(s5p6442_spi0_resource),
-	.resource	  = s5p6442_spi0_resource,
-	.dev = {
-		.dma_mask		= &spi_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data = &s5p6442_spi0_pdata,
-	},
-};
-
-void __init s5p6442_spi_set_info(int cntrlr, int src_clk_nr, int num_cs)
-{
-	struct s3c64xx_spi_info *pd;
-
-	/* Reject invalid configuration */
-	if (!num_cs || src_clk_nr < 0
-			|| src_clk_nr > S5P6442_SPI_SRCCLK_SCLK) {
-		printk(KERN_ERR "%s: Invalid SPI configuration\n", __func__);
-		return;
-	}
-
-	switch (cntrlr) {
-	case 0:
-		pd = &s5p6442_spi0_pdata;
-		break;
-	default:
-		printk(KERN_ERR "%s: Invalid SPI controller(%d)\n",
-							__func__, cntrlr);
-		return;
-	}
-
-	pd->num_cs = num_cs;
-	pd->src_clk_nr = src_clk_nr;
-	pd->src_clk_name = spi_src_clks[src_clk_nr];
-}
diff --git a/arch/arm/mach-s5p6442/dma.c b/arch/arm/mach-s5p6442/dma.c
deleted file mode 100644
index 7dfb136..0000000
--- a/arch/arm/mach-s5p6442/dma.c
+++ /dev/null
@@ -1,105 +0,0 @@
-/*
- * Copyright (C) 2010 Samsung Electronics Co. Ltd.
- *	Jaswinder Singh <jassi.brar@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/platform_device.h>
-#include <linux/dma-mapping.h>
-
-#include <plat/devs.h>
-#include <plat/irqs.h>
-
-#include <mach/map.h>
-#include <mach/irqs.h>
-
-#include <plat/s3c-pl330-pdata.h>
-
-static u64 dma_dmamask = DMA_BIT_MASK(32);
-
-static struct resource s5p6442_pdma_resource[] = {
-	[0] = {
-		.start  = S5P6442_PA_PDMA,
-		.end    = S5P6442_PA_PDMA + SZ_4K,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_PDMA,
-		.end	= IRQ_PDMA,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct s3c_pl330_platdata s5p6442_pdma_pdata = {
-	.peri = {
-		[0] = DMACH_UART0_RX,
-		[1] = DMACH_UART0_TX,
-		[2] = DMACH_UART1_RX,
-		[3] = DMACH_UART1_TX,
-		[4] = DMACH_UART2_RX,
-		[5] = DMACH_UART2_TX,
-		[6] = DMACH_MAX,
-		[7] = DMACH_MAX,
-		[8] = DMACH_MAX,
-		[9] = DMACH_I2S0_RX,
-		[10] = DMACH_I2S0_TX,
-		[11] = DMACH_I2S0S_TX,
-		[12] = DMACH_I2S1_RX,
-		[13] = DMACH_I2S1_TX,
-		[14] = DMACH_MAX,
-		[15] = DMACH_MAX,
-		[16] = DMACH_SPI0_RX,
-		[17] = DMACH_SPI0_TX,
-		[18] = DMACH_MAX,
-		[19] = DMACH_MAX,
-		[20] = DMACH_PCM0_RX,
-		[21] = DMACH_PCM0_TX,
-		[22] = DMACH_PCM1_RX,
-		[23] = DMACH_PCM1_TX,
-		[24] = DMACH_MAX,
-		[25] = DMACH_MAX,
-		[26] = DMACH_MAX,
-		[27] = DMACH_MSM_REQ0,
-		[28] = DMACH_MSM_REQ1,
-		[29] = DMACH_MSM_REQ2,
-		[30] = DMACH_MSM_REQ3,
-		[31] = DMACH_MAX,
-	},
-};
-
-static struct platform_device s5p6442_device_pdma = {
-	.name		= "s3c-pl330",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s5p6442_pdma_resource),
-	.resource	= s5p6442_pdma_resource,
-	.dev		= {
-		.dma_mask = &dma_dmamask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-		.platform_data = &s5p6442_pdma_pdata,
-	},
-};
-
-static struct platform_device *s5p6442_dmacs[] __initdata = {
-	&s5p6442_device_pdma,
-};
-
-static int __init s5p6442_dma_init(void)
-{
-	platform_add_devices(s5p6442_dmacs, ARRAY_SIZE(s5p6442_dmacs));
-
-	return 0;
-}
-arch_initcall(s5p6442_dma_init);
diff --git a/arch/arm/mach-s5p6442/include/mach/debug-macro.S b/arch/arm/mach-s5p6442/include/mach/debug-macro.S
deleted file mode 100644
index e221320..0000000
--- a/arch/arm/mach-s5p6442/include/mach/debug-macro.S
+++ /dev/null
@@ -1,35 +0,0 @@
-/* linux/arch/arm/mach-s5p6442/include/mach/debug-macro.S
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * Based on arch/arm/mach-s3c6400/include/mach/debug-macro.S
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-/* pull in the relevant register and map files. */
-
-#include <mach/map.h>
-#include <plat/regs-serial.h>
-
-	.macro addruart, rp, rv
-		ldr	\rp, = S3C_PA_UART
-		ldr	\rv, = S3C_VA_UART
-#if CONFIG_DEBUG_S3C_UART != 0
-		add	\rp, \rp, #(0x400 * CONFIG_DEBUG_S3C_UART)
-		add	\rv, \rv, #(0x400 * CONFIG_DEBUG_S3C_UART)
-#endif
-	.endm
-
-#define fifo_full fifo_full_s5pv210
-#define fifo_level fifo_level_s5pv210
-
-/* include the reset of the code which will do the work, we're only
- * compiling for a single cpu processor type so the default of s3c2440
- * will be fine with us.
- */
-
-#include <plat/debug-macro.S>
diff --git a/arch/arm/mach-s5p6442/include/mach/dma.h b/arch/arm/mach-s5p6442/include/mach/dma.h
deleted file mode 100644
index 81209eb..0000000
--- a/arch/arm/mach-s5p6442/include/mach/dma.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * Copyright (C) 2010 Samsung Electronics Co. Ltd.
- *	Jaswinder Singh <jassi.brar@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#ifndef __MACH_DMA_H
-#define __MACH_DMA_H
-
-/* This platform uses the common S3C DMA API driver for PL330 */
-#include <plat/s3c-dma-pl330.h>
-
-#endif /* __MACH_DMA_H */
diff --git a/arch/arm/mach-s5p6442/include/mach/entry-macro.S b/arch/arm/mach-s5p6442/include/mach/entry-macro.S
deleted file mode 100644
index 6d574ed..0000000
--- a/arch/arm/mach-s5p6442/include/mach/entry-macro.S
+++ /dev/null
@@ -1,48 +0,0 @@
-/* linux/arch/arm/mach-s5p6442/include/mach/entry-macro.S
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * Low-level IRQ helper macros for the Samsung S5P6442
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <asm/hardware/vic.h>
-#include <mach/map.h>
-#include <plat/irqs.h>
-
-	.macro	disable_fiq
-	.endm
-
-	.macro	get_irqnr_preamble, base, tmp
-	ldr	\base, =VA_VIC0
-	.endm
-
-	.macro	arch_ret_to_user, tmp1, tmp2
-	.endm
-
-	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-
-	@ check the vic0
-	mov	\irqnr, # S5P_IRQ_OFFSET + 31
-	ldr	\irqstat, [ \base, # VIC_IRQ_STATUS ]
-	teq	\irqstat, #0
-
-	@ otherwise try vic1
-	addeq	\tmp, \base, #(VA_VIC1 - VA_VIC0)
-	addeq	\irqnr, \irqnr, #32
-	ldreq	\irqstat, [ \tmp, # VIC_IRQ_STATUS ]
-	teqeq	\irqstat, #0
-
-	@ otherwise try vic2
-	addeq	\tmp, \base, #(VA_VIC2 - VA_VIC0)
-	addeq	\irqnr, \irqnr, #32
-	ldreq	\irqstat, [ \tmp, # VIC_IRQ_STATUS ]
-	teqeq	\irqstat, #0
-
-	clzne	\irqstat, \irqstat
-	subne	\irqnr, \irqnr, \irqstat
-	.endm
diff --git a/arch/arm/mach-s5p6442/include/mach/gpio.h b/arch/arm/mach-s5p6442/include/mach/gpio.h
deleted file mode 100644
index b8715df..0000000
--- a/arch/arm/mach-s5p6442/include/mach/gpio.h
+++ /dev/null
@@ -1,123 +0,0 @@
-/* linux/arch/arm/mach-s5p6442/include/mach/gpio.h
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5P6442 - GPIO lib support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_GPIO_H
-#define __ASM_ARCH_GPIO_H __FILE__
-
-#define gpio_get_value	__gpio_get_value
-#define gpio_set_value	__gpio_set_value
-#define gpio_cansleep	__gpio_cansleep
-#define gpio_to_irq	__gpio_to_irq
-
-/* GPIO bank sizes */
-#define S5P6442_GPIO_A0_NR	(8)
-#define S5P6442_GPIO_A1_NR	(2)
-#define S5P6442_GPIO_B_NR	(4)
-#define S5P6442_GPIO_C0_NR	(5)
-#define S5P6442_GPIO_C1_NR	(5)
-#define S5P6442_GPIO_D0_NR	(2)
-#define S5P6442_GPIO_D1_NR	(6)
-#define S5P6442_GPIO_E0_NR	(8)
-#define S5P6442_GPIO_E1_NR	(5)
-#define S5P6442_GPIO_F0_NR	(8)
-#define S5P6442_GPIO_F1_NR	(8)
-#define S5P6442_GPIO_F2_NR	(8)
-#define S5P6442_GPIO_F3_NR	(6)
-#define S5P6442_GPIO_G0_NR	(7)
-#define S5P6442_GPIO_G1_NR	(7)
-#define S5P6442_GPIO_G2_NR	(7)
-#define S5P6442_GPIO_H0_NR	(8)
-#define S5P6442_GPIO_H1_NR	(8)
-#define S5P6442_GPIO_H2_NR	(8)
-#define S5P6442_GPIO_H3_NR	(8)
-#define S5P6442_GPIO_J0_NR	(8)
-#define S5P6442_GPIO_J1_NR	(6)
-#define S5P6442_GPIO_J2_NR	(8)
-#define S5P6442_GPIO_J3_NR	(8)
-#define S5P6442_GPIO_J4_NR	(5)
-
-/* GPIO bank numbers */
-
-/* CONFIG_S3C_GPIO_SPACE allows the user to select extra
- * space for debugging purposes so that any accidental
- * change from one gpio bank to another can be caught.
-*/
-
-#define S5P6442_GPIO_NEXT(__gpio) \
-	((__gpio##_START) + (__gpio##_NR) + CONFIG_S3C_GPIO_SPACE + 1)
-
-enum s5p_gpio_number {
-	S5P6442_GPIO_A0_START	= 0,
-	S5P6442_GPIO_A1_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_A0),
-	S5P6442_GPIO_B_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_A1),
-	S5P6442_GPIO_C0_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_B),
-	S5P6442_GPIO_C1_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_C0),
-	S5P6442_GPIO_D0_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_C1),
-	S5P6442_GPIO_D1_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_D0),
-	S5P6442_GPIO_E0_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_D1),
-	S5P6442_GPIO_E1_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_E0),
-	S5P6442_GPIO_F0_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_E1),
-	S5P6442_GPIO_F1_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_F0),
-	S5P6442_GPIO_F2_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_F1),
-	S5P6442_GPIO_F3_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_F2),
-	S5P6442_GPIO_G0_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_F3),
-	S5P6442_GPIO_G1_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_G0),
-	S5P6442_GPIO_G2_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_G1),
-	S5P6442_GPIO_H0_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_G2),
-	S5P6442_GPIO_H1_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_H0),
-	S5P6442_GPIO_H2_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_H1),
-	S5P6442_GPIO_H3_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_H2),
-	S5P6442_GPIO_J0_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_H3),
-	S5P6442_GPIO_J1_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_J0),
-	S5P6442_GPIO_J2_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_J1),
-	S5P6442_GPIO_J3_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_J2),
-	S5P6442_GPIO_J4_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_J3),
-};
-
-/* S5P6442 GPIO number definitions. */
-#define S5P6442_GPA0(_nr)	(S5P6442_GPIO_A0_START + (_nr))
-#define S5P6442_GPA1(_nr)	(S5P6442_GPIO_A1_START + (_nr))
-#define S5P6442_GPB(_nr)	(S5P6442_GPIO_B_START + (_nr))
-#define S5P6442_GPC0(_nr)	(S5P6442_GPIO_C0_START + (_nr))
-#define S5P6442_GPC1(_nr)	(S5P6442_GPIO_C1_START + (_nr))
-#define S5P6442_GPD0(_nr)	(S5P6442_GPIO_D0_START + (_nr))
-#define S5P6442_GPD1(_nr)	(S5P6442_GPIO_D1_START + (_nr))
-#define S5P6442_GPE0(_nr)	(S5P6442_GPIO_E0_START + (_nr))
-#define S5P6442_GPE1(_nr)	(S5P6442_GPIO_E1_START + (_nr))
-#define S5P6442_GPF0(_nr)	(S5P6442_GPIO_F0_START + (_nr))
-#define S5P6442_GPF1(_nr)	(S5P6442_GPIO_F1_START + (_nr))
-#define S5P6442_GPF2(_nr)	(S5P6442_GPIO_F2_START + (_nr))
-#define S5P6442_GPF3(_nr)	(S5P6442_GPIO_F3_START + (_nr))
-#define S5P6442_GPG0(_nr)	(S5P6442_GPIO_G0_START + (_nr))
-#define S5P6442_GPG1(_nr)	(S5P6442_GPIO_G1_START + (_nr))
-#define S5P6442_GPG2(_nr)	(S5P6442_GPIO_G2_START + (_nr))
-#define S5P6442_GPH0(_nr)	(S5P6442_GPIO_H0_START + (_nr))
-#define S5P6442_GPH1(_nr)	(S5P6442_GPIO_H1_START + (_nr))
-#define S5P6442_GPH2(_nr)	(S5P6442_GPIO_H2_START + (_nr))
-#define S5P6442_GPH3(_nr)	(S5P6442_GPIO_H3_START + (_nr))
-#define S5P6442_GPJ0(_nr)	(S5P6442_GPIO_J0_START + (_nr))
-#define S5P6442_GPJ1(_nr)	(S5P6442_GPIO_J1_START + (_nr))
-#define S5P6442_GPJ2(_nr)	(S5P6442_GPIO_J2_START + (_nr))
-#define S5P6442_GPJ3(_nr)	(S5P6442_GPIO_J3_START + (_nr))
-#define S5P6442_GPJ4(_nr)	(S5P6442_GPIO_J4_START + (_nr))
-
-/* the end of the S5P6442 specific gpios */
-#define S5P6442_GPIO_END	(S5P6442_GPJ4(S5P6442_GPIO_J4_NR) + 1)
-#define S3C_GPIO_END		S5P6442_GPIO_END
-
-/* define the number of gpios we need to the one after the GPJ4() range */
-#define ARCH_NR_GPIOS		(S5P6442_GPJ4(S5P6442_GPIO_J4_NR) +	\
-				 CONFIG_SAMSUNG_GPIO_EXTRA + 1)
-
-#include <asm-generic/gpio.h>
-
-#endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-s5p6442/include/mach/hardware.h b/arch/arm/mach-s5p6442/include/mach/hardware.h
deleted file mode 100644
index 8cd7b67..0000000
--- a/arch/arm/mach-s5p6442/include/mach/hardware.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* linux/arch/arm/mach-s5p6442/include/mach/hardware.h
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5P6442 - Hardware support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_HARDWARE_H
-#define __ASM_ARCH_HARDWARE_H __FILE__
-
-/* currently nothing here, placeholder */
-
-#endif /* __ASM_ARCH_HARDWARE_H */
diff --git a/arch/arm/mach-s5p6442/include/mach/io.h b/arch/arm/mach-s5p6442/include/mach/io.h
deleted file mode 100644
index 5d2195a..0000000
--- a/arch/arm/mach-s5p6442/include/mach/io.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* arch/arm/mach-s5p6442/include/mach/io.h
- *
- * Copyright 2008-2010 Ben Dooks <ben-linux@fluff.org>
- *
- * Default IO routines for S5P6442
- */
-
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-/* No current ISA/PCI bus support. */
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-#define IO_SPACE_LIMIT (0xFFFFFFFF)
-
-#endif
diff --git a/arch/arm/mach-s5p6442/include/mach/irqs.h b/arch/arm/mach-s5p6442/include/mach/irqs.h
deleted file mode 100644
index 3fbc6c3..0000000
--- a/arch/arm/mach-s5p6442/include/mach/irqs.h
+++ /dev/null
@@ -1,87 +0,0 @@
-/* linux/arch/arm/mach-s5p6442/include/mach/irqs.h
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5P6442 - IRQ definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_IRQS_H
-#define __ASM_ARCH_IRQS_H __FILE__
-
-#include <plat/irqs.h>
-
-/* VIC0 */
-#define IRQ_EINT16_31 		S5P_IRQ_VIC0(16)
-#define IRQ_BATF 		S5P_IRQ_VIC0(17)
-#define IRQ_MDMA 		S5P_IRQ_VIC0(18)
-#define IRQ_PDMA 		S5P_IRQ_VIC0(19)
-#define IRQ_TIMER0_VIC		S5P_IRQ_VIC0(21)
-#define IRQ_TIMER1_VIC		S5P_IRQ_VIC0(22)
-#define IRQ_TIMER2_VIC		S5P_IRQ_VIC0(23)
-#define IRQ_TIMER3_VIC		S5P_IRQ_VIC0(24)
-#define IRQ_TIMER4_VIC		S5P_IRQ_VIC0(25)
-#define IRQ_SYSTIMER		S5P_IRQ_VIC0(26)
-#define IRQ_WDT			S5P_IRQ_VIC0(27)
-#define IRQ_RTC_ALARM		S5P_IRQ_VIC0(28)
-#define IRQ_RTC_TIC		S5P_IRQ_VIC0(29)
-#define IRQ_GPIOINT		S5P_IRQ_VIC0(30)
-
-/* VIC1 */
-#define IRQ_PMU			S5P_IRQ_VIC1(0)
-#define IRQ_ONENAND 		S5P_IRQ_VIC1(7)
-#define IRQ_UART0 		S5P_IRQ_VIC1(10)
-#define IRQ_UART1 		S5P_IRQ_VIC1(11)
-#define IRQ_UART2 		S5P_IRQ_VIC1(12)
-#define IRQ_SPI0 		S5P_IRQ_VIC1(15)
-#define IRQ_IIC 		S5P_IRQ_VIC1(19)
-#define IRQ_IIC1 		S5P_IRQ_VIC1(20)
-#define IRQ_IIC2 		S5P_IRQ_VIC1(21)
-#define IRQ_OTG 		S5P_IRQ_VIC1(24)
-#define IRQ_MSM 		S5P_IRQ_VIC1(25)
-#define IRQ_HSMMC0 		S5P_IRQ_VIC1(26)
-#define IRQ_HSMMC1 		S5P_IRQ_VIC1(27)
-#define IRQ_HSMMC2 		S5P_IRQ_VIC1(28)
-#define IRQ_COMMRX 		S5P_IRQ_VIC1(29)
-#define IRQ_COMMTX 		S5P_IRQ_VIC1(30)
-
-/* VIC2 */
-#define IRQ_LCD0 		S5P_IRQ_VIC2(0)
-#define IRQ_LCD1 		S5P_IRQ_VIC2(1)
-#define IRQ_LCD2 		S5P_IRQ_VIC2(2)
-#define IRQ_LCD3 		S5P_IRQ_VIC2(3)
-#define IRQ_ROTATOR 		S5P_IRQ_VIC2(4)
-#define IRQ_FIMC0 		S5P_IRQ_VIC2(5)
-#define IRQ_FIMC1 		S5P_IRQ_VIC2(6)
-#define IRQ_FIMC2 		S5P_IRQ_VIC2(7)
-#define IRQ_JPEG 		S5P_IRQ_VIC2(8)
-#define IRQ_3D 			S5P_IRQ_VIC2(10)
-#define IRQ_Mixer 		S5P_IRQ_VIC2(11)
-#define IRQ_MFC 		S5P_IRQ_VIC2(14)
-#define IRQ_TVENC 		S5P_IRQ_VIC2(15)
-#define IRQ_I2S0 		S5P_IRQ_VIC2(16)
-#define IRQ_I2S1 		S5P_IRQ_VIC2(17)
-#define IRQ_RP 			S5P_IRQ_VIC2(19)
-#define IRQ_PCM0 		S5P_IRQ_VIC2(20)
-#define IRQ_PCM1 		S5P_IRQ_VIC2(21)
-#define IRQ_ADC 		S5P_IRQ_VIC2(23)
-#define IRQ_PENDN 		S5P_IRQ_VIC2(24)
-#define IRQ_KEYPAD 		S5P_IRQ_VIC2(25)
-#define IRQ_SSS_INT 		S5P_IRQ_VIC2(27)
-#define IRQ_SSS_HASH 		S5P_IRQ_VIC2(28)
-#define IRQ_VIC_END 		S5P_IRQ_VIC2(31)
-
-#define S5P_IRQ_EINT_BASE	(IRQ_VIC_END + 1)
-
-#define S5P_EINT_BASE1		(S5P_IRQ_VIC0(0))
-#define S5P_EINT_BASE2		(S5P_IRQ_EINT_BASE)
-
-/* Set the default NR_IRQS */
-
-#define NR_IRQS 		(IRQ_EINT(31) + 1)
-
-#endif /* __ASM_ARCH_IRQS_H */
diff --git a/arch/arm/mach-s5p6442/include/mach/map.h b/arch/arm/mach-s5p6442/include/mach/map.h
deleted file mode 100644
index 058dab4..0000000
--- a/arch/arm/mach-s5p6442/include/mach/map.h
+++ /dev/null
@@ -1,76 +0,0 @@
-/* linux/arch/arm/mach-s5p6442/include/mach/map.h
- *
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5P6442 - Memory map definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_MAP_H
-#define __ASM_ARCH_MAP_H __FILE__
-
-#include <plat/map-base.h>
-#include <plat/map-s5p.h>
-
-#define S5P6442_PA_SDRAM	0x20000000
-
-#define S5P6442_PA_I2S0		0xC0B00000
-#define S5P6442_PA_I2S1		0xF2200000
-
-#define S5P6442_PA_CHIPID	0xE0000000
-
-#define S5P6442_PA_SYSCON	0xE0100000
-
-#define S5P6442_PA_GPIO		0xE0200000
-
-#define S5P6442_PA_VIC0		0xE4000000
-#define S5P6442_PA_VIC1		0xE4100000
-#define S5P6442_PA_VIC2		0xE4200000
-
-#define S5P6442_PA_SROMC	0xE7000000
-
-#define S5P6442_PA_MDMA		0xE8000000
-#define S5P6442_PA_PDMA		0xE9000000
-
-#define S5P6442_PA_TIMER	0xEA000000
-
-#define S5P6442_PA_SYSTIMER	0xEA100000
-
-#define S5P6442_PA_WATCHDOG	0xEA200000
-
-#define S5P6442_PA_UART		0xEC000000
-
-#define S5P6442_PA_IIC0		0xEC100000
-
-#define S5P6442_PA_SPI		0xEC300000
-
-#define S5P6442_PA_PCM0		0xF2400000
-#define S5P6442_PA_PCM1		0xF2500000
-
-/* Compatibiltiy Defines */
-
-#define S3C_PA_IIC		S5P6442_PA_IIC0
-#define S3C_PA_WDT		S5P6442_PA_WATCHDOG
-
-#define S5P_PA_CHIPID		S5P6442_PA_CHIPID
-#define S5P_PA_SDRAM		S5P6442_PA_SDRAM
-#define S5P_PA_SROMC		S5P6442_PA_SROMC
-#define S5P_PA_SYSCON		S5P6442_PA_SYSCON
-#define S5P_PA_TIMER		S5P6442_PA_TIMER
-
-/* UART */
-
-#define S3C_PA_UART		S5P6442_PA_UART
-
-#define S5P_PA_UART(x)		(S3C_PA_UART + ((x) * S3C_UART_OFFSET))
-#define S5P_PA_UART0		S5P_PA_UART(0)
-#define S5P_PA_UART1		S5P_PA_UART(1)
-#define S5P_PA_UART2		S5P_PA_UART(2)
-
-#define S5P_SZ_UART		SZ_256
-
-#endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-s5p6442/include/mach/memory.h b/arch/arm/mach-s5p6442/include/mach/memory.h
deleted file mode 100644
index cfe259d..0000000
--- a/arch/arm/mach-s5p6442/include/mach/memory.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* linux/arch/arm/mach-s5p6442/include/mach/memory.h
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5P6442 - Memory definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-#define PLAT_PHYS_OFFSET		UL(0x20000000)
-#define CONSISTENT_DMA_SIZE	SZ_8M
-
-#endif /* __ASM_ARCH_MEMORY_H */
diff --git a/arch/arm/mach-s5p6442/include/mach/pwm-clock.h b/arch/arm/mach-s5p6442/include/mach/pwm-clock.h
deleted file mode 100644
index 2724b37..0000000
--- a/arch/arm/mach-s5p6442/include/mach/pwm-clock.h
+++ /dev/null
@@ -1,70 +0,0 @@
-/* linux/arch/arm/mach-s5p6442/include/mach/pwm-clock.h
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *      Ben Dooks <ben@simtec.co.uk>
- *      http://armlinux.simtec.co.uk/
- *
- * Based on arch/arm/mach-s3c64xx/include/mach/pwm-clock.h
- *
- * S5P6442 - pwm clock and timer support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_PWMCLK_H
-#define __ASM_ARCH_PWMCLK_H __FILE__
-
-/**
- * pwm_cfg_src_is_tclk() - return whether the given mux config is a tclk
- * @tcfg: The timer TCFG1 register bits shifted down to 0.
- *
- * Return true if the given configuration from TCFG1 is a TCLK instead
- * any of the TDIV clocks.
- */
-static inline int pwm_cfg_src_is_tclk(unsigned long tcfg)
-{
-	return tcfg == S3C64XX_TCFG1_MUX_TCLK;
-}
-
-/**
- * tcfg_to_divisor() - convert tcfg1 setting to a divisor
- * @tcfg1: The tcfg1 setting, shifted down.
- *
- * Get the divisor value for the given tcfg1 setting. We assume the
- * caller has already checked to see if this is not a TCLK source.
- */
-static inline unsigned long tcfg_to_divisor(unsigned long tcfg1)
-{
-	return 1 << tcfg1;
-}
-
-/**
- * pwm_tdiv_has_div1() - does the tdiv setting have a /1
- *
- * Return true if we have a /1 in the tdiv setting.
- */
-static inline unsigned int pwm_tdiv_has_div1(void)
-{
-	return 1;
-}
-
-/**
- * pwm_tdiv_div_bits() - calculate TCFG1 divisor value.
- * @div: The divisor to calculate the bit information for.
- *
- * Turn a divisor into the necessary bit field for TCFG1.
- */
-static inline unsigned long pwm_tdiv_div_bits(unsigned int div)
-{
-	return ilog2(div);
-}
-
-#define S3C_TCFG1_MUX_TCLK S3C64XX_TCFG1_MUX_TCLK
-
-#endif /* __ASM_ARCH_PWMCLK_H */
diff --git a/arch/arm/mach-s5p6442/include/mach/regs-clock.h b/arch/arm/mach-s5p6442/include/mach/regs-clock.h
deleted file mode 100644
index 00828a3..0000000
--- a/arch/arm/mach-s5p6442/include/mach/regs-clock.h
+++ /dev/null
@@ -1,104 +0,0 @@
-/* linux/arch/arm/mach-s5p6442/include/mach/regs-clock.h
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5P6442 - Clock register definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_REGS_CLOCK_H
-#define __ASM_ARCH_REGS_CLOCK_H __FILE__
-
-#include <mach/map.h>
-
-#define S5P_CLKREG(x)		(S3C_VA_SYS + (x))
-
-#define S5P_APLL_LOCK		S5P_CLKREG(0x00)
-#define S5P_MPLL_LOCK		S5P_CLKREG(0x08)
-#define S5P_EPLL_LOCK		S5P_CLKREG(0x10)
-#define S5P_VPLL_LOCK		S5P_CLKREG(0x20)
-
-#define S5P_APLL_CON		S5P_CLKREG(0x100)
-#define S5P_MPLL_CON		S5P_CLKREG(0x108)
-#define S5P_EPLL_CON		S5P_CLKREG(0x110)
-#define S5P_VPLL_CON		S5P_CLKREG(0x120)
-
-#define S5P_CLK_SRC0		S5P_CLKREG(0x200)
-#define S5P_CLK_SRC1		S5P_CLKREG(0x204)
-#define S5P_CLK_SRC2		S5P_CLKREG(0x208)
-#define S5P_CLK_SRC3		S5P_CLKREG(0x20C)
-#define S5P_CLK_SRC4		S5P_CLKREG(0x210)
-#define S5P_CLK_SRC5		S5P_CLKREG(0x214)
-#define S5P_CLK_SRC6		S5P_CLKREG(0x218)
-
-#define S5P_CLK_SRC_MASK0	S5P_CLKREG(0x280)
-#define S5P_CLK_SRC_MASK1	S5P_CLKREG(0x284)
-
-#define S5P_CLK_DIV0		S5P_CLKREG(0x300)
-#define S5P_CLK_DIV1		S5P_CLKREG(0x304)
-#define S5P_CLK_DIV2		S5P_CLKREG(0x308)
-#define S5P_CLK_DIV3		S5P_CLKREG(0x30C)
-#define S5P_CLK_DIV4		S5P_CLKREG(0x310)
-#define S5P_CLK_DIV5		S5P_CLKREG(0x314)
-#define S5P_CLK_DIV6		S5P_CLKREG(0x318)
-
-#define S5P_CLKGATE_IP0		S5P_CLKREG(0x460)
-#define S5P_CLKGATE_IP3		S5P_CLKREG(0x46C)
-
-/* CLK_OUT */
-#define S5P_CLK_OUT_SHIFT	(12)
-#define S5P_CLK_OUT_MASK	(0x1F << S5P_CLK_OUT_SHIFT)
-#define S5P_CLK_OUT		S5P_CLKREG(0x500)
-
-#define S5P_CLK_DIV_STAT0	S5P_CLKREG(0x1000)
-#define S5P_CLK_DIV_STAT1	S5P_CLKREG(0x1004)
-
-#define S5P_CLK_MUX_STAT0	S5P_CLKREG(0x1100)
-#define S5P_CLK_MUX_STAT1	S5P_CLKREG(0x1104)
-
-#define S5P_MDNIE_SEL		S5P_CLKREG(0x7008)
-
-/* Register Bit definition */
-#define S5P_EPLL_EN     		(1<<31)
-#define S5P_EPLL_MASK   		0xffffffff
-#define S5P_EPLLVAL(_m, _p, _s)   	((_m) << 16 | ((_p) << 8) | ((_s)))
-
-/* CLKDIV0 */
-#define S5P_CLKDIV0_APLL_SHIFT		(0)
-#define S5P_CLKDIV0_APLL_MASK		(0x7 << S5P_CLKDIV0_APLL_SHIFT)
-#define S5P_CLKDIV0_A2M_SHIFT		(4)
-#define S5P_CLKDIV0_A2M_MASK		(0x7 << S5P_CLKDIV0_A2M_SHIFT)
-#define S5P_CLKDIV0_D0CLK_SHIFT		(16)
-#define S5P_CLKDIV0_D0CLK_MASK		(0xF << S5P_CLKDIV0_D0CLK_SHIFT)
-#define S5P_CLKDIV0_P0CLK_SHIFT		(20)
-#define S5P_CLKDIV0_P0CLK_MASK		(0x7 << S5P_CLKDIV0_P0CLK_SHIFT)
-#define S5P_CLKDIV0_D1CLK_SHIFT		(24)
-#define S5P_CLKDIV0_D1CLK_MASK		(0xF << S5P_CLKDIV0_D1CLK_SHIFT)
-#define S5P_CLKDIV0_P1CLK_SHIFT		(28)
-#define S5P_CLKDIV0_P1CLK_MASK		(0x7 << S5P_CLKDIV0_P1CLK_SHIFT)
-
-/* Clock MUX status Registers */
-#define S5P_CLK_MUX_STAT0_APLL_SHIFT	(0)
-#define S5P_CLK_MUX_STAT0_APLL_MASK	(0x7 << S5P_CLK_MUX_STAT0_APLL_SHIFT)
-#define S5P_CLK_MUX_STAT0_MPLL_SHIFT	(4)
-#define S5P_CLK_MUX_STAT0_MPLL_MASK	(0x7 << S5P_CLK_MUX_STAT0_MPLL_SHIFT)
-#define S5P_CLK_MUX_STAT0_EPLL_SHIFT	(8)
-#define S5P_CLK_MUX_STAT0_EPLL_MASK	(0x7 << S5P_CLK_MUX_STAT0_EPLL_SHIFT)
-#define S5P_CLK_MUX_STAT0_VPLL_SHIFT	(12)
-#define S5P_CLK_MUX_STAT0_VPLL_MASK	(0x7 << S5P_CLK_MUX_STAT0_VPLL_SHIFT)
-#define S5P_CLK_MUX_STAT0_MUXARM_SHIFT	(16)
-#define S5P_CLK_MUX_STAT0_MUXARM_MASK	(0x7 << S5P_CLK_MUX_STAT0_MUXARM_SHIFT)
-#define S5P_CLK_MUX_STAT0_MUXD0_SHIFT	(20)
-#define S5P_CLK_MUX_STAT0_MUXD0_MASK	(0x7 << S5P_CLK_MUX_STAT0_MUXD0_SHIFT)
-#define S5P_CLK_MUX_STAT0_MUXD1_SHIFT	(24)
-#define S5P_CLK_MUX_STAT0_MUXD1_MASK	(0x7 << S5P_CLK_MUX_STAT0_MUXD1_SHIFT)
-#define S5P_CLK_MUX_STAT1_D1SYNC_SHIFT	(24)
-#define S5P_CLK_MUX_STAT1_D1SYNC_MASK	(0x7 << S5P_CLK_MUX_STAT1_D1SYNC_SHIFT)
-#define S5P_CLK_MUX_STAT1_D0SYNC_SHIFT	(28)
-#define S5P_CLK_MUX_STAT1_D0SYNC_MASK	(0x7 << S5P_CLK_MUX_STAT1_D0SYNC_SHIFT)
-
-#endif /* __ASM_ARCH_REGS_CLOCK_H */
diff --git a/arch/arm/mach-s5p6442/include/mach/regs-irq.h b/arch/arm/mach-s5p6442/include/mach/regs-irq.h
deleted file mode 100644
index 73782b5..0000000
--- a/arch/arm/mach-s5p6442/include/mach/regs-irq.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* linux/arch/arm/mach-s5p6442/include/mach/regs-irq.h
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5P6442 - IRQ register definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_REGS_IRQ_H
-#define __ASM_ARCH_REGS_IRQ_H __FILE__
-
-#include <asm/hardware/vic.h>
-#include <mach/map.h>
-
-#endif /* __ASM_ARCH_REGS_IRQ_H */
diff --git a/arch/arm/mach-s5p6442/include/mach/spi-clocks.h b/arch/arm/mach-s5p6442/include/mach/spi-clocks.h
deleted file mode 100644
index 7fd8820..0000000
--- a/arch/arm/mach-s5p6442/include/mach/spi-clocks.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* linux/arch/arm/mach-s5p6442/include/mach/spi-clocks.h
- *
- * Copyright (C) 2010 Samsung Electronics Co. Ltd.
- *	Jaswinder Singh <jassi.brar@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __S5P6442_PLAT_SPI_CLKS_H
-#define __S5P6442_PLAT_SPI_CLKS_H __FILE__
-
-#define S5P6442_SPI_SRCCLK_PCLK		0
-#define S5P6442_SPI_SRCCLK_SCLK		1
-
-#endif /* __S5P6442_PLAT_SPI_CLKS_H */
diff --git a/arch/arm/mach-s5p6442/include/mach/system.h b/arch/arm/mach-s5p6442/include/mach/system.h
deleted file mode 100644
index c30c1cc..0000000
--- a/arch/arm/mach-s5p6442/include/mach/system.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* linux/arch/arm/mach-s5p6442/include/mach/system.h
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5P6442 - system support header
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H __FILE__
-
-#include <plat/system-reset.h>
-
-static void arch_idle(void)
-{
-	/* nothing here yet */
-}
-
-#endif /* __ASM_ARCH_SYSTEM_H */
diff --git a/arch/arm/mach-s5p6442/include/mach/tick.h b/arch/arm/mach-s5p6442/include/mach/tick.h
deleted file mode 100644
index e1d4cab..0000000
--- a/arch/arm/mach-s5p6442/include/mach/tick.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* linux/arch/arm/mach-s5p6442/include/mach/tick.h
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * Based on arch/arm/mach-s3c6400/include/mach/tick.h
- *
- * S5P6442 - Timer tick support definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_TICK_H
-#define __ASM_ARCH_TICK_H __FILE__
-
-static inline u32 s3c24xx_ostimer_pending(void)
-{
-	u32 pend = __raw_readl(VA_VIC0 + VIC_RAW_STATUS);
-	return pend & (1 << (IRQ_TIMER4_VIC - S5P_IRQ_VIC0(0)));
-}
-
-#define TICK_MAX	(0xffffffff)
-
-#endif /* __ASM_ARCH_TICK_H */
diff --git a/arch/arm/mach-s5p6442/include/mach/timex.h b/arch/arm/mach-s5p6442/include/mach/timex.h
deleted file mode 100644
index ff8f2fc..0000000
--- a/arch/arm/mach-s5p6442/include/mach/timex.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* arch/arm/mach-s5p6442/include/mach/timex.h
- *
- * Copyright (c) 2003-2010 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S5P6442 - time parameters
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_TIMEX_H
-#define __ASM_ARCH_TIMEX_H
-
-/* CLOCK_TICK_RATE needs to be evaluatable by the cpp, so making it
- * a variable is useless. It seems as long as we make our timers an
- * exact multiple of HZ, any value that makes a 1->1 correspondence
- * for the time conversion functions to/from jiffies is acceptable.
-*/
-
-#define CLOCK_TICK_RATE 12000000
-
-#endif /* __ASM_ARCH_TIMEX_H */
diff --git a/arch/arm/mach-s5p6442/include/mach/uncompress.h b/arch/arm/mach-s5p6442/include/mach/uncompress.h
deleted file mode 100644
index 5ac7cbe..0000000
--- a/arch/arm/mach-s5p6442/include/mach/uncompress.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* linux/arch/arm/mach-s5p6442/include/mach/uncompress.h
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5P6442 - uncompress code
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_UNCOMPRESS_H
-#define __ASM_ARCH_UNCOMPRESS_H
-
-#include <mach/map.h>
-#include <plat/uncompress.h>
-
-static void arch_detect_cpu(void)
-{
-	/* we do not need to do any cpu detection here at the moment. */
-}
-
-#endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-s5p6442/include/mach/vmalloc.h b/arch/arm/mach-s5p6442/include/mach/vmalloc.h
deleted file mode 100644
index 4aa55e5..0000000
--- a/arch/arm/mach-s5p6442/include/mach/vmalloc.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* arch/arm/mach-s5p6442/include/mach/vmalloc.h
- *
- * Copyright 2010 Ben Dooks <ben-linux@fluff.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * S5P6442 vmalloc definition
-*/
-
-#ifndef __ASM_ARCH_VMALLOC_H
-#define __ASM_ARCH_VMALLOC_H
-
-#define VMALLOC_END	0xF6000000UL
-
-#endif /* __ASM_ARCH_VMALLOC_H */
diff --git a/arch/arm/mach-s5p6442/init.c b/arch/arm/mach-s5p6442/init.c
deleted file mode 100644
index 1874bdb..0000000
--- a/arch/arm/mach-s5p6442/init.c
+++ /dev/null
@@ -1,44 +0,0 @@
-/* linux/arch/arm/mach-s5p6442/s5p6442-init.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/serial_core.h>
-
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/s5p6442.h>
-#include <plat/regs-serial.h>
-
-static struct s3c24xx_uart_clksrc s5p6442_serial_clocks[] = {
-	[0] = {
-		.name		= "pclk",
-		.divisor	= 1,
-		.min_baud	= 0,
-		.max_baud	= 0,
-	},
-};
-
-/* uart registration process */
-void __init s5p6442_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
-{
-	struct s3c2410_uartcfg *tcfg = cfg;
-	u32 ucnt;
-
-	for (ucnt = 0; ucnt < no; ucnt++, tcfg++) {
-		if (!tcfg->clocks) {
-			tcfg->clocks = s5p6442_serial_clocks;
-			tcfg->clocks_size = ARRAY_SIZE(s5p6442_serial_clocks);
-		}
-	}
-
-	s3c24xx_init_uartdevs("s5pv210-uart", s5p_uart_resources, cfg, no);
-}
diff --git a/arch/arm/mach-s5p6442/mach-smdk6442.c b/arch/arm/mach-s5p6442/mach-smdk6442.c
deleted file mode 100644
index eaf6b9c..0000000
--- a/arch/arm/mach-s5p6442/mach-smdk6442.c
+++ /dev/null
@@ -1,102 +0,0 @@
-/* linux/arch/arm/mach-s5p6442/mach-smdk6442.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/serial_core.h>
-#include <linux/i2c.h>
-
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <asm/setup.h>
-#include <asm/mach-types.h>
-
-#include <mach/map.h>
-#include <mach/regs-clock.h>
-
-#include <plat/regs-serial.h>
-#include <plat/s5p6442.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
-#include <plat/iic.h>
-
-/* Following are default values for UCON, ULCON and UFCON UART registers */
-#define SMDK6442_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
-				 S3C2410_UCON_RXILEVEL |	\
-				 S3C2410_UCON_TXIRQMODE |	\
-				 S3C2410_UCON_RXIRQMODE |	\
-				 S3C2410_UCON_RXFIFO_TOI |	\
-				 S3C2443_UCON_RXERR_IRQEN)
-
-#define SMDK6442_ULCON_DEFAULT	S3C2410_LCON_CS8
-
-#define SMDK6442_UFCON_DEFAULT	(S3C2410_UFCON_FIFOMODE |	\
-				 S5PV210_UFCON_TXTRIG4 |	\
-				 S5PV210_UFCON_RXTRIG4)
-
-static struct s3c2410_uartcfg smdk6442_uartcfgs[] __initdata = {
-	[0] = {
-		.hwport		= 0,
-		.flags		= 0,
-		.ucon		= SMDK6442_UCON_DEFAULT,
-		.ulcon		= SMDK6442_ULCON_DEFAULT,
-		.ufcon		= SMDK6442_UFCON_DEFAULT,
-	},
-	[1] = {
-		.hwport		= 1,
-		.flags		= 0,
-		.ucon		= SMDK6442_UCON_DEFAULT,
-		.ulcon		= SMDK6442_ULCON_DEFAULT,
-		.ufcon		= SMDK6442_UFCON_DEFAULT,
-	},
-	[2] = {
-		.hwport		= 2,
-		.flags		= 0,
-		.ucon		= SMDK6442_UCON_DEFAULT,
-		.ulcon		= SMDK6442_ULCON_DEFAULT,
-		.ufcon		= SMDK6442_UFCON_DEFAULT,
-	},
-};
-
-static struct platform_device *smdk6442_devices[] __initdata = {
-	&s3c_device_i2c0,
-	&samsung_asoc_dma,
-	&s5p6442_device_iis0,
-	&s3c_device_wdt,
-};
-
-static struct i2c_board_info smdk6442_i2c_devs0[] __initdata = {
-	{ I2C_BOARD_INFO("wm8580", 0x1b), },
-};
-
-static void __init smdk6442_map_io(void)
-{
-	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
-	s3c24xx_init_clocks(12000000);
-	s3c24xx_init_uarts(smdk6442_uartcfgs, ARRAY_SIZE(smdk6442_uartcfgs));
-}
-
-static void __init smdk6442_machine_init(void)
-{
-	s3c_i2c0_set_platdata(NULL);
-	i2c_register_board_info(0, smdk6442_i2c_devs0,
-			ARRAY_SIZE(smdk6442_i2c_devs0));
-	platform_add_devices(smdk6442_devices, ARRAY_SIZE(smdk6442_devices));
-}
-
-MACHINE_START(SMDK6442, "SMDK6442")
-	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
-	.boot_params	= S5P_PA_SDRAM + 0x100,
-	.init_irq	= s5p6442_init_irq,
-	.map_io		= smdk6442_map_io,
-	.init_machine	= smdk6442_machine_init,
-	.timer		= &s3c24xx_timer,
-MACHINE_END
diff --git a/arch/arm/mach-s5p6442/setup-i2c0.c b/arch/arm/mach-s5p6442/setup-i2c0.c
deleted file mode 100644
index aad8565..0000000
--- a/arch/arm/mach-s5p6442/setup-i2c0.c
+++ /dev/null
@@ -1,28 +0,0 @@
-/* linux/arch/arm/mach-s5p6442/setup-i2c0.c
- *
- * Copyright (c) 2009 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * I2C0 GPIO configuration.
- *
- * Based on plat-s3c64xx/setup-i2c0.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/gpio.h>
-
-struct platform_device; /* don't need the contents */
-
-#include <plat/gpio-cfg.h>
-#include <plat/iic.h>
-
-void s3c_i2c0_cfg_gpio(struct platform_device *dev)
-{
-	s3c_gpio_cfgall_range(S5P6442_GPD1(0), 2,
-			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
-}
diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index 8492297..5878bd9 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -7,7 +7,7 @@
 
 config PLAT_S5P
 	bool
-	depends on (ARCH_S5P64X0 || ARCH_S5P6442 || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_EXYNOS4)
+	depends on (ARCH_S5P64X0 || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_EXYNOS4)
 	default y
 	select ARM_VIC if !ARCH_EXYNOS4
 	select ARM_GIC if ARCH_EXYNOS4
diff --git a/arch/arm/plat-s5p/cpu.c b/arch/arm/plat-s5p/cpu.c
index 5cf5e72..bbc2aa7 100644
--- a/arch/arm/plat-s5p/cpu.c
+++ b/arch/arm/plat-s5p/cpu.c
@@ -21,7 +21,6 @@
 
 #include <plat/cpu.h>
 #include <plat/s5p6440.h>
-#include <plat/s5p6442.h>
 #include <plat/s5p6450.h>
 #include <plat/s5pc100.h>
 #include <plat/s5pv210.h>
@@ -30,7 +29,6 @@
 /* table of supported CPUs */
 
 static const char name_s5p6440[] = "S5P6440";
-static const char name_s5p6442[] = "S5P6442";
 static const char name_s5p6450[] = "S5P6450";
 static const char name_s5pc100[] = "S5PC100";
 static const char name_s5pv210[] = "S5PV210/S5PC110";
@@ -46,14 +44,6 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.init		= s5p64x0_init,
 		.name		= name_s5p6440,
 	}, {
-		.idcode		= 0x36442000,
-		.idmask		= 0xfffff000,
-		.map_io		= s5p6442_map_io,
-		.init_clocks	= s5p6442_init_clocks,
-		.init_uarts	= s5p6442_init_uarts,
-		.init		= s5p6442_init,
-		.name		= name_s5p6442,
-	}, {
 		.idcode		= 0x36450000,
 		.idmask		= 0xfffff000,
 		.map_io		= s5p6450_map_io,
diff --git a/arch/arm/plat-s5p/include/plat/s5p6442.h b/arch/arm/plat-s5p/include/plat/s5p6442.h
deleted file mode 100644
index 7b88013..0000000
--- a/arch/arm/plat-s5p/include/plat/s5p6442.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/* arch/arm/plat-s5p/include/plat/s5p6442.h
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * Header file for s5p6442 cpu support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-/* Common init code for S5P6442 related SoCs */
-
-extern void s5p6442_common_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-extern void s5p6442_register_clocks(void);
-extern void s5p6442_setup_clocks(void);
-
-#ifdef CONFIG_CPU_S5P6442
-
-extern  int s5p6442_init(void);
-extern void s5p6442_init_irq(void);
-extern void s5p6442_map_io(void);
-extern void s5p6442_init_clocks(int xtal);
-
-#define s5p6442_init_uarts s5p6442_common_init_uarts
-
-#else
-#define s5p6442_init_clocks NULL
-#define s5p6442_init_uarts NULL
-#define s5p6442_map_io NULL
-#define s5p6442_init NULL
-#endif
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index cedfff5..6ff205b 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -80,7 +80,6 @@ extern struct sysdev_class s3c2443_sysclass;
 extern struct sysdev_class s3c6410_sysclass;
 extern struct sysdev_class s3c64xx_sysclass;
 extern struct sysdev_class s5p64x0_sysclass;
-extern struct sysdev_class s5p6442_sysclass;
 extern struct sysdev_class s5pv210_sysclass;
 extern struct sysdev_class exynos4_sysclass;
 
diff --git a/arch/arm/plat-samsung/include/plat/debug-macro.S b/arch/arm/plat-samsung/include/plat/debug-macro.S
index dc6efd9..207e275 100644
--- a/arch/arm/plat-samsung/include/plat/debug-macro.S
+++ b/arch/arm/plat-samsung/include/plat/debug-macro.S
@@ -11,7 +11,7 @@
 
 #include <plat/regs-serial.h>
 
-/* The S5PV210/S5PC110 and S5P6442 implementations are as belows. */
+/* The S5PV210/S5PC110 implementations are as belows. */
 
 	.macro fifo_level_s5pv210 rd, rx
 		ldr	\rd, [ \rx, # S3C2410_UFSTAT ]
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index f0da6b7..d64adf1 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -110,12 +110,6 @@ extern struct platform_device exynos4_device_spdif;
 extern struct platform_device exynos4_device_pd[];
 extern struct platform_device exynos4_device_ahci;
 
-extern struct platform_device s5p6442_device_pcm0;
-extern struct platform_device s5p6442_device_pcm1;
-extern struct platform_device s5p6442_device_iis0;
-extern struct platform_device s5p6442_device_iis1;
-extern struct platform_device s5p6442_device_spi;
-
 extern struct platform_device s5p6440_device_pcm;
 extern struct platform_device s5p6440_device_iis;
 
diff --git a/arch/arm/plat-samsung/include/plat/regs-serial.h b/arch/arm/plat-samsung/include/plat/regs-serial.h
index 788837e..c151c5f 100644
--- a/arch/arm/plat-samsung/include/plat/regs-serial.h
+++ b/arch/arm/plat-samsung/include/plat/regs-serial.h
@@ -194,7 +194,7 @@
 #define S3C64XX_UINTSP		0x34
 #define S3C64XX_UINTM		0x38
 
-/* Following are specific to S5PV210 and S5P6442 */
+/* Following are specific to S5PV210 */
 #define S5PV210_UCON_CLKMASK	(1<<10)
 #define S5PV210_UCON_PCLK	(0<<10)
 #define S5PV210_UCON_UCLK	(1<<10)
diff --git a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
index ff1a561..0ffe34a 100644
--- a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
+++ b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
@@ -69,6 +69,5 @@ extern void s3c64xx_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
 extern void s5pc100_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
 extern void s5pv210_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
 extern void s5p64x0_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
-extern void s5p6442_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
 
 #endif /* __S3C64XX_PLAT_SPI_H */
-- 
1.7.1
