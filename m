From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 12 Apr 2011 23:12:51 +0200
Subject: [PATCH] ARM: remove ns9xxx port
In-Reply-To: <20110412205344.GE7806@n2100.arm.linux.org.uk>
References: <20110412205344.GE7806@n2100.arm.linux.org.uk>
Message-ID: <1302642771-15217-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The port is actually unmaintained and only received global
cleanups and a few build fixes since mid 2008.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

On Tue, Apr 12, 2011 at 09:53:44PM +0100, Russell King - ARM Linux wrote:
> We must reduce the size of arch/arm by all means possible.

What about this? You considered to do this some time ago[1] already and I
asked to wait because Digi planned to continue the mainline efforts
around spring 2010.

Best regards
Uwe

[1] http://mid.gmane.org/20091121105009.GD7998 at n2100.arm.linux.org.uk

 arch/arm/Kconfig                                   |   14 --
 arch/arm/Makefile                                  |    1 -
 arch/arm/configs/ns9xxx_defconfig                  |   56 -----
 arch/arm/mach-ns9xxx/Kconfig                       |   40 ----
 arch/arm/mach-ns9xxx/Makefile                      |   12 -
 arch/arm/mach-ns9xxx/Makefile.boot                 |    2 -
 arch/arm/mach-ns9xxx/board-a9m9750dev.c            |  156 --------------
 arch/arm/mach-ns9xxx/board-a9m9750dev.h            |   15 --
 arch/arm/mach-ns9xxx/board-jscc9p9360.c            |   17 --
 arch/arm/mach-ns9xxx/board-jscc9p9360.h            |   13 --
 arch/arm/mach-ns9xxx/clock.c                       |  215 --------------------
 arch/arm/mach-ns9xxx/clock.h                       |   35 ----
 arch/arm/mach-ns9xxx/generic.c                     |   19 --
 arch/arm/mach-ns9xxx/generic.h                     |   16 --
 arch/arm/mach-ns9xxx/gpio-ns9360.c                 |  118 -----------
 arch/arm/mach-ns9xxx/gpio-ns9360.h                 |   13 --
 arch/arm/mach-ns9xxx/gpio.c                        |  147 -------------
 arch/arm/mach-ns9xxx/include/mach/board.h          |   40 ----
 arch/arm/mach-ns9xxx/include/mach/debug-macro.S    |   21 --
 arch/arm/mach-ns9xxx/include/mach/entry-macro.S    |   28 ---
 arch/arm/mach-ns9xxx/include/mach/gpio.h           |   47 -----
 arch/arm/mach-ns9xxx/include/mach/hardware.h       |   77 -------
 arch/arm/mach-ns9xxx/include/mach/io.h             |   20 --
 arch/arm/mach-ns9xxx/include/mach/irqs.h           |   86 --------
 arch/arm/mach-ns9xxx/include/mach/memory.h         |   24 ---
 arch/arm/mach-ns9xxx/include/mach/module.h         |   55 -----
 .../mach-ns9xxx/include/mach/processor-ns9360.h    |   32 ---
 arch/arm/mach-ns9xxx/include/mach/processor.h      |   42 ----
 arch/arm/mach-ns9xxx/include/mach/regs-bbu.h       |   45 ----
 .../include/mach/regs-board-a9m9750dev.h           |   24 ---
 arch/arm/mach-ns9xxx/include/mach/regs-mem.h       |  135 ------------
 .../arm/mach-ns9xxx/include/mach/regs-sys-common.h |   31 ---
 .../arm/mach-ns9xxx/include/mach/regs-sys-ns9360.h |  148 --------------
 arch/arm/mach-ns9xxx/include/mach/system.h         |   35 ----
 arch/arm/mach-ns9xxx/include/mach/timex.h          |   20 --
 arch/arm/mach-ns9xxx/include/mach/uncompress.h     |  164 ---------------
 arch/arm/mach-ns9xxx/include/mach/vmalloc.h        |   16 --
 arch/arm/mach-ns9xxx/irq.c                         |   74 -------
 arch/arm/mach-ns9xxx/mach-cc9p9360dev.c            |   43 ----
 arch/arm/mach-ns9xxx/mach-cc9p9360js.c             |   31 ---
 arch/arm/mach-ns9xxx/plat-serial8250.c             |   70 -------
 arch/arm/mach-ns9xxx/processor-ns9360.c            |   53 -----
 arch/arm/mach-ns9xxx/time-ns9360.c                 |  181 ----------------
 43 files changed, 0 insertions(+), 2431 deletions(-)
 delete mode 100644 arch/arm/configs/ns9xxx_defconfig
 delete mode 100644 arch/arm/mach-ns9xxx/Kconfig
 delete mode 100644 arch/arm/mach-ns9xxx/Makefile
 delete mode 100644 arch/arm/mach-ns9xxx/Makefile.boot
 delete mode 100644 arch/arm/mach-ns9xxx/board-a9m9750dev.c
 delete mode 100644 arch/arm/mach-ns9xxx/board-a9m9750dev.h
 delete mode 100644 arch/arm/mach-ns9xxx/board-jscc9p9360.c
 delete mode 100644 arch/arm/mach-ns9xxx/board-jscc9p9360.h
 delete mode 100644 arch/arm/mach-ns9xxx/clock.c
 delete mode 100644 arch/arm/mach-ns9xxx/clock.h
 delete mode 100644 arch/arm/mach-ns9xxx/generic.c
 delete mode 100644 arch/arm/mach-ns9xxx/generic.h
 delete mode 100644 arch/arm/mach-ns9xxx/gpio-ns9360.c
 delete mode 100644 arch/arm/mach-ns9xxx/gpio-ns9360.h
 delete mode 100644 arch/arm/mach-ns9xxx/gpio.c
 delete mode 100644 arch/arm/mach-ns9xxx/include/mach/board.h
 delete mode 100644 arch/arm/mach-ns9xxx/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-ns9xxx/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-ns9xxx/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-ns9xxx/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-ns9xxx/include/mach/io.h
 delete mode 100644 arch/arm/mach-ns9xxx/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-ns9xxx/include/mach/memory.h
 delete mode 100644 arch/arm/mach-ns9xxx/include/mach/module.h
 delete mode 100644 arch/arm/mach-ns9xxx/include/mach/processor-ns9360.h
 delete mode 100644 arch/arm/mach-ns9xxx/include/mach/processor.h
 delete mode 100644 arch/arm/mach-ns9xxx/include/mach/regs-bbu.h
 delete mode 100644 arch/arm/mach-ns9xxx/include/mach/regs-board-a9m9750dev.h
 delete mode 100644 arch/arm/mach-ns9xxx/include/mach/regs-mem.h
 delete mode 100644 arch/arm/mach-ns9xxx/include/mach/regs-sys-common.h
 delete mode 100644 arch/arm/mach-ns9xxx/include/mach/regs-sys-ns9360.h
 delete mode 100644 arch/arm/mach-ns9xxx/include/mach/system.h
 delete mode 100644 arch/arm/mach-ns9xxx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-ns9xxx/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-ns9xxx/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-ns9xxx/irq.c
 delete mode 100644 arch/arm/mach-ns9xxx/mach-cc9p9360dev.c
 delete mode 100644 arch/arm/mach-ns9xxx/mach-cc9p9360js.c
 delete mode 100644 arch/arm/mach-ns9xxx/plat-serial8250.c
 delete mode 100644 arch/arm/mach-ns9xxx/processor-ns9360.c
 delete mode 100644 arch/arm/mach-ns9xxx/time-ns9360.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5b9f78b..a8bd3c5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -554,18 +554,6 @@ config ARCH_KS8695
 	  Support for Micrel/Kendin KS8695 "Centaur" (ARM922T) based
 	  System-on-Chip devices.
 
-config ARCH_NS9XXX
-	bool "NetSilicon NS9xxx"
-	select CPU_ARM926T
-	select GENERIC_GPIO
-	select GENERIC_CLOCKEVENTS
-	select HAVE_CLK
-	help
-	  Say Y here if you intend to run this kernel on a NetSilicon NS9xxx
-	  System.
-
-	  <http://www.digi.com/products/microprocessors/index.jsp>
-
 config ARCH_W90X900
 	bool "Nuvoton W90X900 CPU"
 	select CPU_ARM926T
@@ -951,8 +939,6 @@ source "arch/arm/mach-netx/Kconfig"
 source "arch/arm/mach-nomadik/Kconfig"
 source "arch/arm/plat-nomadik/Kconfig"
 
-source "arch/arm/mach-ns9xxx/Kconfig"
-
 source "arch/arm/mach-nuc93x/Kconfig"
 
 source "arch/arm/plat-omap/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 2b39030..285ca1c 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -163,7 +163,6 @@ machine-$(CONFIG_ARCH_MX5)		:= mx5
 machine-$(CONFIG_ARCH_MXS)		:= mxs
 machine-$(CONFIG_ARCH_NETX)		:= netx
 machine-$(CONFIG_ARCH_NOMADIK)		:= nomadik
-machine-$(CONFIG_ARCH_NS9XXX)		:= ns9xxx
 machine-$(CONFIG_ARCH_OMAP1)		:= omap1
 machine-$(CONFIG_ARCH_OMAP2)		:= omap2
 machine-$(CONFIG_ARCH_OMAP3)		:= omap2
diff --git a/arch/arm/configs/ns9xxx_defconfig b/arch/arm/configs/ns9xxx_defconfig
deleted file mode 100644
index 1f528a0..0000000
--- a/arch/arm/configs/ns9xxx_defconfig
+++ /dev/null
@@ -1,56 +0,0 @@
-CONFIG_IKCONFIG=y
-CONFIG_IKCONFIG_PROC=y
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_NS9XXX=y
-CONFIG_MACH_CC9P9360DEV=y
-CONFIG_MACH_CC9P9360JS=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_FPE_NWFPE=y
-CONFIG_NET=y
-CONFIG_PACKET=m
-CONFIG_INET=y
-CONFIG_IP_PNP=y
-CONFIG_SYN_COOKIES=y
-CONFIG_MTD=m
-CONFIG_MTD_CONCAT=m
-CONFIG_MTD_CHAR=m
-CONFIG_MTD_BLOCK=m
-CONFIG_MTD_CFI=m
-CONFIG_MTD_JEDECPROBE=m
-CONFIG_MTD_CFI_AMDSTD=m
-CONFIG_MTD_PHYSMAP=m
-CONFIG_BLK_DEV_LOOP=m
-CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-# CONFIG_SERIO_SERPORT is not set
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-# CONFIG_LEGACY_PTYS is not set
-# CONFIG_HW_RANDOM is not set
-CONFIG_I2C=m
-CONFIG_I2C_GPIO=m
-# CONFIG_HWMON is not set
-# CONFIG_VGA_CONSOLE is not set
-# CONFIG_USB_SUPPORT is not set
-CONFIG_NEW_LEDS=y
-CONFIG_LEDS_CLASS=m
-CONFIG_LEDS_GPIO=m
-CONFIG_LEDS_TRIGGERS=y
-CONFIG_LEDS_TRIGGER_TIMER=m
-CONFIG_LEDS_TRIGGER_HEARTBEAT=m
-CONFIG_RTC_CLASS=m
-CONFIG_EXT2_FS=m
-CONFIG_TMPFS=y
-CONFIG_JFFS2_FS=m
-CONFIG_NFS_FS=y
-CONFIG_ROOT_NFS=y
-# CONFIG_ENABLE_MUST_CHECK is not set
-CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_ERRORS=y
diff --git a/arch/arm/mach-ns9xxx/Kconfig b/arch/arm/mach-ns9xxx/Kconfig
deleted file mode 100644
index dd0cd5a..0000000
--- a/arch/arm/mach-ns9xxx/Kconfig
+++ /dev/null
@@ -1,40 +0,0 @@
-if ARCH_NS9XXX
-
-menu "NS9xxx Implementations"
-
-config NS9XXX_HAVE_SERIAL8250
-	bool
-
-config PROCESSOR_NS9360
-	bool
-
-config MODULE_CC9P9360
-	bool
-	select PROCESSOR_NS9360
-
-config BOARD_A9M9750DEV
-	select NS9XXX_HAVE_SERIAL8250
-	bool
-
-config BOARD_JSCC9P9360
-	bool
-
-config MACH_CC9P9360DEV
-	bool "ConnectCore 9P 9360 on an A9M9750 Devboard"
-	select MODULE_CC9P9360
-	select BOARD_A9M9750DEV
-	help
-	  Say Y here if you are using the Digi ConnectCore 9P 9360
-	  on an A9M9750 Development Board.
-
-config MACH_CC9P9360JS
-	bool "ConnectCore 9P 9360 on a JSCC9P9360 Devboard"
-	select MODULE_CC9P9360
-	select BOARD_JSCC9P9360
-	help
-	  Say Y here if you are using the Digi ConnectCore 9P 9360
-	  on an JSCC9P9360 Development Board.
-
-endmenu
-
-endif
diff --git a/arch/arm/mach-ns9xxx/Makefile b/arch/arm/mach-ns9xxx/Makefile
deleted file mode 100644
index 41efaf9..0000000
--- a/arch/arm/mach-ns9xxx/Makefile
+++ /dev/null
@@ -1,12 +0,0 @@
-obj-y := clock.o generic.o gpio.o irq.o
-
-obj-$(CONFIG_MACH_CC9P9360DEV) += mach-cc9p9360dev.o
-obj-$(CONFIG_MACH_CC9P9360JS) += mach-cc9p9360js.o
-
-obj-$(CONFIG_PROCESSOR_NS9360) += gpio-ns9360.o processor-ns9360.o time-ns9360.o
-
-obj-$(CONFIG_BOARD_A9M9750DEV) += board-a9m9750dev.o
-obj-$(CONFIG_BOARD_JSCC9P9360) += board-jscc9p9360.o
-
-# platform devices
-obj-$(CONFIG_NS9XXX_HAVE_SERIAL8250) += plat-serial8250.o
diff --git a/arch/arm/mach-ns9xxx/Makefile.boot b/arch/arm/mach-ns9xxx/Makefile.boot
deleted file mode 100644
index 5465491..0000000
--- a/arch/arm/mach-ns9xxx/Makefile.boot
+++ /dev/null
@@ -1,2 +0,0 @@
-zreladdr-y := 0x8000
-params_phys-y := 0x100
diff --git a/arch/arm/mach-ns9xxx/board-a9m9750dev.c b/arch/arm/mach-ns9xxx/board-a9m9750dev.c
deleted file mode 100644
index e27687d..0000000
--- a/arch/arm/mach-ns9xxx/board-a9m9750dev.c
+++ /dev/null
@@ -1,156 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/board-a9m9750dev.c
- *
- * Copyright (C) 2006,2007 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#include <linux/irq.h>
-
-#include <asm/mach/map.h>
-#include <asm/gpio.h>
-
-#include <mach/board.h>
-#include <mach/processor-ns9360.h>
-#include <mach/regs-sys-ns9360.h>
-#include <mach/regs-mem.h>
-#include <mach/regs-bbu.h>
-#include <mach/regs-board-a9m9750dev.h>
-
-#include "board-a9m9750dev.h"
-
-static struct map_desc board_a9m9750dev_io_desc[] __initdata = {
-	{ /* FPGA on CS0 */
-		.virtual = io_p2v(NS9XXX_CSxSTAT_PHYS(0)),
-		.pfn = __phys_to_pfn(NS9XXX_CSxSTAT_PHYS(0)),
-		.length = NS9XXX_CS0STAT_LENGTH,
-		.type = MT_DEVICE,
-	},
-};
-
-void __init board_a9m9750dev_map_io(void)
-{
-	iotable_init(board_a9m9750dev_io_desc,
-		     ARRAY_SIZE(board_a9m9750dev_io_desc));
-}
-
-static void a9m9750dev_fpga_ack_irq(struct irq_data *d)
-{
-	/* nothing */
-}
-
-static void a9m9750dev_fpga_mask_irq(struct irq_data *d)
-{
-	u8 ier;
-
-	ier = __raw_readb(FPGA_IER);
-
-	ier &= ~(1 << (d->irq - FPGA_IRQ(0)));
-
-	__raw_writeb(ier, FPGA_IER);
-}
-
-static void a9m9750dev_fpga_maskack_irq(struct irq_data *d)
-{
-	a9m9750dev_fpga_mask_irq(d);
-	a9m9750dev_fpga_ack_irq(d);
-}
-
-static void a9m9750dev_fpga_unmask_irq(struct irq_data *d)
-{
-	u8 ier;
-
-	ier = __raw_readb(FPGA_IER);
-
-	ier |= 1 << (d->irq - FPGA_IRQ(0));
-
-	__raw_writeb(ier, FPGA_IER);
-}
-
-static struct irq_chip a9m9750dev_fpga_chip = {
-	.irq_ack	= a9m9750dev_fpga_ack_irq,
-	.irq_mask	= a9m9750dev_fpga_mask_irq,
-	.irq_mask_ack	= a9m9750dev_fpga_maskack_irq,
-	.irq_unmask	= a9m9750dev_fpga_unmask_irq,
-};
-
-static void a9m9750dev_fpga_demux_handler(unsigned int irq,
-		struct irq_desc *desc)
-{
-	u8 stat = __raw_readb(FPGA_ISR);
-
-	desc->irq_data.chip->irq_mask_ack(&desc->irq_data);
-
-	while (stat != 0) {
-		int irqno = fls(stat) - 1;
-
-		stat &= ~(1 << irqno);
-
-		generic_handle_irq(FPGA_IRQ(irqno));
-	}
-
-	desc->irq_data.chip->irq_unmask(&desc->irq_data);
-}
-
-void __init board_a9m9750dev_init_irq(void)
-{
-	u32 eic;
-	int i;
-
-	if (gpio_request(11, "board a9m9750dev extirq2") == 0)
-		ns9360_gpio_configure(11, 0, 1);
-	else
-		printk(KERN_ERR "%s: cannot get gpio 11 for IRQ_NS9XXX_EXT2\n",
-				__func__);
-
-	for (i = FPGA_IRQ(0); i <= FPGA_IRQ(7); ++i) {
-		irq_set_chip_and_handler(i, &a9m9750dev_fpga_chip,
-					 handle_level_irq);
-		set_irq_flags(i, IRQF_VALID);
-	}
-
-	/* IRQ_NS9XXX_EXT2: level sensitive + active low */
-	eic = __raw_readl(SYS_EIC(2));
-	REGSET(eic, SYS_EIC, PLTY, AL);
-	REGSET(eic, SYS_EIC, LVEDG, LEVEL);
-	__raw_writel(eic, SYS_EIC(2));
-
-	irq_set_chained_handler(IRQ_NS9XXX_EXT2,
-				a9m9750dev_fpga_demux_handler);
-}
-
-void __init board_a9m9750dev_init_machine(void)
-{
-	u32 reg;
-
-	/* setup static CS0: memory base ... */
-	reg = __raw_readl(SYS_SMCSSMB(0));
-	REGSETIM(reg, SYS_SMCSSMB, CSxB, NS9XXX_CSxSTAT_PHYS(0) >> 12);
-	__raw_writel(reg, SYS_SMCSSMB(0));
-
-	/* ... and mask */
-	reg = __raw_readl(SYS_SMCSSMM(0));
-	REGSETIM(reg, SYS_SMCSSMM, CSxM, 0xfffff);
-	REGSET(reg, SYS_SMCSSMM, CSEx, EN);
-	__raw_writel(reg, SYS_SMCSSMM(0));
-
-	/* setup static CS0: memory configuration */
-	reg = __raw_readl(MEM_SMC(0));
-	REGSET(reg, MEM_SMC, PSMC, OFF);
-	REGSET(reg, MEM_SMC, BSMC, OFF);
-	REGSET(reg, MEM_SMC, EW, OFF);
-	REGSET(reg, MEM_SMC, PB, 1);
-	REGSET(reg, MEM_SMC, PC, AL);
-	REGSET(reg, MEM_SMC, PM, DIS);
-	REGSET(reg, MEM_SMC, MW, 8);
-	__raw_writel(reg, MEM_SMC(0));
-
-	/* setup static CS0: timing */
-	__raw_writel(0x2, MEM_SMWED(0));
-	__raw_writel(0x2, MEM_SMOED(0));
-	__raw_writel(0x6, MEM_SMRD(0));
-	__raw_writel(0x6, MEM_SMWD(0));
-}
diff --git a/arch/arm/mach-ns9xxx/board-a9m9750dev.h b/arch/arm/mach-ns9xxx/board-a9m9750dev.h
deleted file mode 100644
index edc75ab..0000000
--- a/arch/arm/mach-ns9xxx/board-a9m9750dev.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/board-a9m9750dev.h
- *
- * Copyright (C) 2006 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#include <linux/init.h>
-
-void __init board_a9m9750dev_map_io(void);
-void __init board_a9m9750dev_init_machine(void);
-void __init board_a9m9750dev_init_irq(void);
diff --git a/arch/arm/mach-ns9xxx/board-jscc9p9360.c b/arch/arm/mach-ns9xxx/board-jscc9p9360.c
deleted file mode 100644
index 4bd3eec..0000000
--- a/arch/arm/mach-ns9xxx/board-jscc9p9360.c
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/board-jscc9p9360.c
- *
- * Copyright (C) 2006,2007 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#include "board-jscc9p9360.h"
-
-void __init board_jscc9p9360_init_machine(void)
-{
-	/* TODO: reserve GPIOs for push buttons, etc pp */
-}
-
diff --git a/arch/arm/mach-ns9xxx/board-jscc9p9360.h b/arch/arm/mach-ns9xxx/board-jscc9p9360.h
deleted file mode 100644
index 1a81a07..0000000
--- a/arch/arm/mach-ns9xxx/board-jscc9p9360.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/board-jscc9p9360.h
- *
- * Copyright (C) 2006 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#include <linux/init.h>
-
-void __init board_jscc9p9360_init_machine(void);
diff --git a/arch/arm/mach-ns9xxx/clock.c b/arch/arm/mach-ns9xxx/clock.c
deleted file mode 100644
index cf81cbc..0000000
--- a/arch/arm/mach-ns9xxx/clock.c
+++ /dev/null
@@ -1,215 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/clock.c
- *
- * Copyright (C) 2007 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#include <linux/err.h>
-#include <linux/module.h>
-#include <linux/list.h>
-#include <linux/clk.h>
-#include <linux/string.h>
-#include <linux/platform_device.h>
-#include <linux/semaphore.h>
-
-#include "clock.h"
-
-static LIST_HEAD(clocks);
-static DEFINE_SPINLOCK(clk_lock);
-
-struct clk *clk_get(struct device *dev, const char *id)
-{
-	struct clk *p, *ret = NULL, *retgen = NULL;
-	unsigned long flags;
-	int idno;
-
-	if (dev == NULL || dev->bus != &platform_bus_type)
-		idno = -1;
-	else
-		idno = to_platform_device(dev)->id;
-
-	spin_lock_irqsave(&clk_lock, flags);
-	list_for_each_entry(p, &clocks, node) {
-		if (strcmp(id, p->name) == 0) {
-			if (p->id == idno) {
-				if (!try_module_get(p->owner))
-					continue;
-				ret = p;
-				break;
-			} else if (p->id == -1)
-				/* remember match with id == -1 in case there is
-				 * no clock for idno */
-				retgen = p;
-		}
-	}
-
-	if (!ret && retgen && try_module_get(retgen->owner))
-		ret = retgen;
-
-	if (ret)
-		++ret->refcount;
-
-	spin_unlock_irqrestore(&clk_lock, flags);
-
-	return ret ? ret : ERR_PTR(-ENOENT);
-}
-EXPORT_SYMBOL(clk_get);
-
-void clk_put(struct clk *clk)
-{
-	module_put(clk->owner);
-	--clk->refcount;
-}
-EXPORT_SYMBOL(clk_put);
-
-static int clk_enable_unlocked(struct clk *clk)
-{
-	int ret = 0;
-	if (clk->parent) {
-		ret = clk_enable_unlocked(clk->parent);
-		if (ret)
-			return ret;
-	}
-
-	if (clk->usage++ == 0 && clk->endisable)
-		ret = clk->endisable(clk, 1);
-
-	return ret;
-}
-
-int clk_enable(struct clk *clk)
-{
-	int ret;
-	unsigned long flags;
-
-	spin_lock_irqsave(&clk_lock, flags);
-
-	ret = clk_enable_unlocked(clk);
-
-	spin_unlock_irqrestore(&clk_lock, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL(clk_enable);
-
-static void clk_disable_unlocked(struct clk *clk)
-{
-	if (--clk->usage == 0 && clk->endisable)
-		clk->endisable(clk, 0);
-
-	if (clk->parent)
-		clk_disable_unlocked(clk->parent);
-}
-
-void clk_disable(struct clk *clk)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&clk_lock, flags);
-
-	clk_disable_unlocked(clk);
-
-	spin_unlock_irqrestore(&clk_lock, flags);
-}
-EXPORT_SYMBOL(clk_disable);
-
-unsigned long clk_get_rate(struct clk *clk)
-{
-	if (clk->get_rate)
-		return clk->get_rate(clk);
-
-	if (clk->rate)
-		return clk->rate;
-
-	if (clk->parent)
-		return clk_get_rate(clk->parent);
-
-	return 0;
-}
-EXPORT_SYMBOL(clk_get_rate);
-
-int clk_register(struct clk *clk)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&clk_lock, flags);
-
-	list_add(&clk->node, &clocks);
-
-	if (clk->parent)
-		++clk->parent->refcount;
-
-	spin_unlock_irqrestore(&clk_lock, flags);
-
-	return 0;
-}
-
-int clk_unregister(struct clk *clk)
-{
-	int ret = 0;
-	unsigned long flags;
-
-	spin_lock_irqsave(&clk_lock, flags);
-
-	if (clk->usage || clk->refcount)
-		ret = -EBUSY;
-	else
-		list_del(&clk->node);
-
-	if (clk->parent)
-		--clk->parent->refcount;
-
-	spin_unlock_irqrestore(&clk_lock, flags);
-
-	return ret;
-}
-
-#if defined CONFIG_DEBUG_FS
-
-#include <linux/debugfs.h>
-#include <linux/seq_file.h>
-
-static int clk_debugfs_show(struct seq_file *s, void *null)
-{
-	unsigned long flags;
-	struct clk *p;
-
-	spin_lock_irqsave(&clk_lock, flags);
-
-	list_for_each_entry(p, &clocks, node)
-		seq_printf(s, "%s.%d: usage=%lu refcount=%lu rate=%lu\n",
-				p->name, p->id, p->usage, p->refcount,
-				p->usage ? clk_get_rate(p) : 0);
-
-	spin_unlock_irqrestore(&clk_lock, flags);
-
-	return 0;
-}
-
-static int clk_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, clk_debugfs_show, NULL);
-}
-
-static const struct file_operations clk_debugfs_operations = {
-	.open = clk_debugfs_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static int __init clk_debugfs_init(void)
-{
-	struct dentry *dentry;
-
-	dentry = debugfs_create_file("clk", S_IFREG | S_IRUGO, NULL, NULL,
-			&clk_debugfs_operations);
-	return IS_ERR(dentry) ? PTR_ERR(dentry) : 0;
-}
-subsys_initcall(clk_debugfs_init);
-
-#endif /* if defined CONFIG_DEBUG_FS */
diff --git a/arch/arm/mach-ns9xxx/clock.h b/arch/arm/mach-ns9xxx/clock.h
deleted file mode 100644
index b86c30d..0000000
--- a/arch/arm/mach-ns9xxx/clock.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/clock.h
- *
- * Copyright (C) 2007 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#ifndef __NS9XXX_CLOCK_H
-#define __NS9XXX_CLOCK_H
-
-#include <linux/list.h>
-
-struct clk {
-	struct module *owner;
-	const char *name;
-	int id;
-
-	struct clk *parent;
-
-	unsigned long rate;
-	int (*endisable)(struct clk *, int enable);
-	unsigned long (*get_rate)(struct clk *);
-
-	struct list_head node;
-	unsigned long refcount;
-	unsigned long usage;
-};
-
-int clk_register(struct clk *clk);
-int clk_unregister(struct clk *clk);
-
-#endif /* ifndef __NS9XXX_CLOCK_H */
diff --git a/arch/arm/mach-ns9xxx/generic.c b/arch/arm/mach-ns9xxx/generic.c
deleted file mode 100644
index 1e0f467..0000000
--- a/arch/arm/mach-ns9xxx/generic.c
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/generic.c
- *
- * Copyright (C) 2006,2007 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <asm/memory.h>
-
-#include "generic.h"
-
-void __init ns9xxx_init_machine(void)
-{
-}
diff --git a/arch/arm/mach-ns9xxx/generic.h b/arch/arm/mach-ns9xxx/generic.h
deleted file mode 100644
index 8249319..0000000
--- a/arch/arm/mach-ns9xxx/generic.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/generic.h
- *
- * Copyright (C) 2006,2007 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#include <linux/time.h>
-#include <asm/mach/time.h>
-#include <linux/init.h>
-
-void __init ns9xxx_init_irq(void);
-void __init ns9xxx_init_machine(void);
diff --git a/arch/arm/mach-ns9xxx/gpio-ns9360.c b/arch/arm/mach-ns9xxx/gpio-ns9360.c
deleted file mode 100644
index 377330c..0000000
--- a/arch/arm/mach-ns9xxx/gpio-ns9360.c
+++ /dev/null
@@ -1,118 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/gpio-ns9360.c
- *
- * Copyright (C) 2006,2007 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#include <linux/bug.h>
-#include <linux/errno.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-
-#include <mach/regs-bbu.h>
-#include <mach/processor-ns9360.h>
-
-#include "gpio-ns9360.h"
-
-static inline int ns9360_valid_gpio(unsigned gpio)
-{
-	return gpio <= 72;
-}
-
-static inline void __iomem *ns9360_gpio_get_gconfaddr(unsigned gpio)
-{
-	if (gpio < 56)
-		return BBU_GCONFb1(gpio / 8);
-	else
-		/*
-		 * this could be optimised away on
-		 * ns9750 only builds, but it isn't ...
-		 */
-		return BBU_GCONFb2((gpio - 56) / 8);
-}
-
-static inline void __iomem *ns9360_gpio_get_gctrladdr(unsigned gpio)
-{
-	if (gpio < 32)
-		return BBU_GCTRL1;
-	else if (gpio < 64)
-		return BBU_GCTRL2;
-	else
-		/* this could be optimised away on ns9750 only builds */
-		return BBU_GCTRL3;
-}
-
-static inline void __iomem *ns9360_gpio_get_gstataddr(unsigned gpio)
-{
-	if (gpio < 32)
-		return BBU_GSTAT1;
-	else if (gpio < 64)
-		return BBU_GSTAT2;
-	else
-		/* this could be optimised away on ns9750 only builds */
-		return BBU_GSTAT3;
-}
-
-/*
- * each gpio can serve for 4 different purposes [0..3].  These are called
- * "functions" and passed in the parameter func.  Functions 0-2 are always some
- * special things, function 3 is GPIO.  If func == 3 dir specifies input or
- * output, and with inv you can enable an inverter (independent of func).
- */
-int __ns9360_gpio_configure(unsigned gpio, int dir, int inv, int func)
-{
-	void __iomem *conf = ns9360_gpio_get_gconfaddr(gpio);
-	u32 confval;
-
-	confval = __raw_readl(conf);
-	REGSETIM_IDX(confval, BBU_GCONFx, DIR, gpio & 7, dir);
-	REGSETIM_IDX(confval, BBU_GCONFx, INV, gpio & 7, inv);
-	REGSETIM_IDX(confval, BBU_GCONFx, FUNC, gpio & 7, func);
-	__raw_writel(confval, conf);
-
-	return 0;
-}
-
-int ns9360_gpio_configure(unsigned gpio, int inv, int func)
-{
-	if (likely(ns9360_valid_gpio(gpio))) {
-		if (func == 3) {
-			printk(KERN_WARNING "use gpio_direction_input "
-					"or gpio_direction_output\n");
-			return -EINVAL;
-		} else
-			return __ns9360_gpio_configure(gpio, 0, inv, func);
-	} else
-		return -EINVAL;
-}
-EXPORT_SYMBOL(ns9360_gpio_configure);
-
-int ns9360_gpio_get_value(unsigned gpio)
-{
-	void __iomem *stat = ns9360_gpio_get_gstataddr(gpio);
-	int ret;
-
-	ret = 1 & (__raw_readl(stat) >> (gpio & 31));
-
-	return ret;
-}
-
-void ns9360_gpio_set_value(unsigned gpio, int value)
-{
-	void __iomem *ctrl = ns9360_gpio_get_gctrladdr(gpio);
-	u32 ctrlval;
-
-	ctrlval = __raw_readl(ctrl);
-
-	if (value)
-		ctrlval |= 1 << (gpio & 31);
-	else
-		ctrlval &= ~(1 << (gpio & 31));
-
-	__raw_writel(ctrlval, ctrl);
-}
diff --git a/arch/arm/mach-ns9xxx/gpio-ns9360.h b/arch/arm/mach-ns9xxx/gpio-ns9360.h
deleted file mode 100644
index 131cd17..0000000
--- a/arch/arm/mach-ns9xxx/gpio-ns9360.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/gpio-ns9360.h
- *
- * Copyright (C) 2006,2007 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-int __ns9360_gpio_configure(unsigned gpio, int dir, int inv, int func);
-int ns9360_gpio_get_value(unsigned gpio);
-void ns9360_gpio_set_value(unsigned gpio, int value);
diff --git a/arch/arm/mach-ns9xxx/gpio.c b/arch/arm/mach-ns9xxx/gpio.c
deleted file mode 100644
index 5503ca0..0000000
--- a/arch/arm/mach-ns9xxx/gpio.c
+++ /dev/null
@@ -1,147 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/gpio.c
- *
- * Copyright (C) 2006,2007 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#include <linux/kernel.h>
-#include <linux/compiler.h>
-#include <linux/init.h>
-#include <linux/spinlock.h>
-#include <linux/module.h>
-#include <linux/bitops.h>
-
-#include <mach/gpio.h>
-#include <mach/processor.h>
-#include <mach/processor-ns9360.h>
-#include <asm/bug.h>
-#include <asm/types.h>
-
-#include "gpio-ns9360.h"
-
-#if defined(CONFIG_PROCESSOR_NS9360)
-#define GPIO_MAX 72
-#elif defined(CONFIG_PROCESSOR_NS9750)
-#define GPIO_MAX 49
-#endif
-
-/* protects BBU_GCONFx and BBU_GCTRLx */
-static spinlock_t gpio_lock = __SPIN_LOCK_UNLOCKED(gpio_lock);
-
-/* only access gpiores with atomic ops */
-static DECLARE_BITMAP(gpiores, GPIO_MAX + 1);
-
-static inline int ns9xxx_valid_gpio(unsigned gpio)
-{
-#if defined(CONFIG_PROCESSOR_NS9360)
-	if (processor_is_ns9360())
-		return gpio <= 72;
-	else
-#endif
-#if defined(CONFIG_PROCESSOR_NS9750)
-	if (processor_is_ns9750())
-		return gpio <= 49;
-	else
-#endif
-	{
-		BUG();
-		return 0;
-	}
-}
-
-int gpio_request(unsigned gpio, const char *label)
-{
-	if (likely(ns9xxx_valid_gpio(gpio)))
-		return test_and_set_bit(gpio, gpiores) ? -EBUSY : 0;
-	else
-		return -EINVAL;
-}
-EXPORT_SYMBOL(gpio_request);
-
-void gpio_free(unsigned gpio)
-{
-	might_sleep();
-	clear_bit(gpio, gpiores);
-	return;
-}
-EXPORT_SYMBOL(gpio_free);
-
-int gpio_direction_input(unsigned gpio)
-{
-	if (likely(ns9xxx_valid_gpio(gpio))) {
-		int ret = -EINVAL;
-		unsigned long flags;
-
-		spin_lock_irqsave(&gpio_lock, flags);
-#if defined(CONFIG_PROCESSOR_NS9360)
-		if (processor_is_ns9360())
-			ret = __ns9360_gpio_configure(gpio, 0, 0, 3);
-		else
-#endif
-			BUG();
-
-		spin_unlock_irqrestore(&gpio_lock, flags);
-
-		return ret;
-
-	} else
-		return -EINVAL;
-}
-EXPORT_SYMBOL(gpio_direction_input);
-
-int gpio_direction_output(unsigned gpio, int value)
-{
-	if (likely(ns9xxx_valid_gpio(gpio))) {
-		int ret = -EINVAL;
-		unsigned long flags;
-
-		gpio_set_value(gpio, value);
-
-		spin_lock_irqsave(&gpio_lock, flags);
-#if defined(CONFIG_PROCESSOR_NS9360)
-		if (processor_is_ns9360())
-			ret = __ns9360_gpio_configure(gpio, 1, 0, 3);
-		else
-#endif
-			BUG();
-
-		spin_unlock_irqrestore(&gpio_lock, flags);
-
-		return ret;
-	} else
-		return -EINVAL;
-}
-EXPORT_SYMBOL(gpio_direction_output);
-
-int gpio_get_value(unsigned gpio)
-{
-#if defined(CONFIG_PROCESSOR_NS9360)
-	if (processor_is_ns9360())
-		return ns9360_gpio_get_value(gpio);
-	else
-#endif
-	{
-		BUG();
-		return -EINVAL;
-	}
-}
-EXPORT_SYMBOL(gpio_get_value);
-
-void gpio_set_value(unsigned gpio, int value)
-{
-	unsigned long flags;
-	spin_lock_irqsave(&gpio_lock, flags);
-#if defined(CONFIG_PROCESSOR_NS9360)
-	if (processor_is_ns9360())
-		ns9360_gpio_set_value(gpio, value);
-	else
-#endif
-		BUG();
-
-	spin_unlock_irqrestore(&gpio_lock, flags);
-}
-EXPORT_SYMBOL(gpio_set_value);
diff --git a/arch/arm/mach-ns9xxx/include/mach/board.h b/arch/arm/mach-ns9xxx/include/mach/board.h
deleted file mode 100644
index 19ca6de..0000000
--- a/arch/arm/mach-ns9xxx/include/mach/board.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/include/mach/board.h
- *
- * Copyright (C) 2006,2007 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#ifndef __ASM_ARCH_BOARD_H
-#define __ASM_ARCH_BOARD_H
-
-#include <asm/mach-types.h>
-
-#define board_is_a9m9750dev()	(0			\
-		|| machine_is_cc9p9750dev()		\
-		)
-
-#define board_is_a9mvali()	(0			\
-		|| machine_is_cc9p9750val()		\
-		)
-
-#define board_is_jscc9p9210()	(0			\
-		|| machine_is_cc9p9210js()		\
-		)
-
-#define board_is_jscc9p9215()	(0			\
-		|| machine_is_cc9p9215js()		\
-		)
-
-#define board_is_jscc9p9360()	(0			\
-		|| machine_is_cc9p9360js()		\
-		)
-
-#define board_is_uncbas()	(0			\
-		|| machine_is_cc7ucamry()		\
-		)
-
-#endif /* ifndef __ASM_ARCH_BOARD_H */
diff --git a/arch/arm/mach-ns9xxx/include/mach/debug-macro.S b/arch/arm/mach-ns9xxx/include/mach/debug-macro.S
deleted file mode 100644
index 5a2acbd..0000000
--- a/arch/arm/mach-ns9xxx/include/mach/debug-macro.S
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/include/mach/debug-macro.S
- * Copyright (C) 2006 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#include <mach/hardware.h>
-#include <asm/memory.h>
-
-#include <mach/regs-board-a9m9750dev.h>
-
-		.macro	addruart, rp, rv
-		ldr	\rp, =NS9XXX_CSxSTAT_PHYS(0)
-		ldr	\rv, =io_p2v(NS9XXX_CSxSTAT_PHYS(0))
-		.endm
-
-#define UART_SHIFT	2
-#include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-ns9xxx/include/mach/entry-macro.S b/arch/arm/mach-ns9xxx/include/mach/entry-macro.S
deleted file mode 100644
index 71ca031..0000000
--- a/arch/arm/mach-ns9xxx/include/mach/entry-macro.S
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/include/mach/entry-macro.S
- *
- * Copyright (C) 2006,2007 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#include <mach/hardware.h>
-#include <mach/regs-sys-common.h>
-
-		.macro	get_irqnr_preamble, base, tmp
-		ldr	\base, =SYS_ISRADDR
-		.endm
-
-		.macro	arch_ret_to_user, tmp1, tmp2
-		.endm
-
-		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-		ldr	\irqstat, [\base, #(SYS_ISA - SYS_ISRADDR)]
-		cmp	\irqstat, #0
-		ldrne	\irqnr, [\base]
-		.endm
-
-		.macro	disable_fiq
-		.endm
diff --git a/arch/arm/mach-ns9xxx/include/mach/gpio.h b/arch/arm/mach-ns9xxx/include/mach/gpio.h
deleted file mode 100644
index 5eb3490..0000000
--- a/arch/arm/mach-ns9xxx/include/mach/gpio.h
+++ /dev/null
@@ -1,47 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/include/mach/gpio.h
- *
- * Copyright (C) 2007 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
-*/
-#ifndef __ASM_ARCH_GPIO_H
-#define __ASM_ARCH_GPIO_H
-
-#include <asm/errno.h>
-
-int gpio_request(unsigned gpio, const char *label);
-
-void gpio_free(unsigned gpio);
-
-int ns9xxx_gpio_configure(unsigned gpio, int inv, int func);
-
-int gpio_direction_input(unsigned gpio);
-
-int gpio_direction_output(unsigned gpio, int value);
-
-int gpio_get_value(unsigned gpio);
-
-void gpio_set_value(unsigned gpio, int value);
-
-/*
- * ns9xxx can use gpio pins to trigger an irq, but it's not generic
- * enough to be supported by the gpio_to_irq/irq_to_gpio interface
- */
-static inline int gpio_to_irq(unsigned gpio)
-{
-	return -EINVAL;
-}
-
-static inline int irq_to_gpio(unsigned irq)
-{
-	return -EINVAL;
-}
-
-/* get the cansleep() stubs */
-#include <asm-generic/gpio.h>
-
-#endif /* ifndef __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-ns9xxx/include/mach/hardware.h b/arch/arm/mach-ns9xxx/include/mach/hardware.h
deleted file mode 100644
index 7663112..0000000
--- a/arch/arm/mach-ns9xxx/include/mach/hardware.h
+++ /dev/null
@@ -1,77 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/include/mach/hardware.h
- *
- * Copyright (C) 2006 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#ifndef __ASM_ARCH_HARDWARE_H
-#define __ASM_ARCH_HARDWARE_H
-
-/*
- * NetSilicon NS9xxx internal mapping:
- *
- * physical                <--> virtual
- * 0x90000000 - 0x906fffff <--> 0xf9000000 - 0xf96fffff
- * 0xa0100000 - 0xa0afffff <--> 0xfa100000 - 0xfaafffff
- */
-#define io_p2v(x)	(0xf0000000 \
-			 + (((x) & 0xf0000000) >> 4) \
-			 + ((x) & 0x00ffffff))
-
-#define io_v2p(x)	((((x) & 0x0f000000) << 4) \
-			 + ((x) & 0x00ffffff))
-
-#define __REGSHIFT(mask)	((mask) & (-(mask)))
-
-#define __REGBIT(bit)		((u32)1 << (bit))
-#define __REGBITS(hbit, lbit)	((((u32)1 << ((hbit) - (lbit) + 1)) - 1) << (lbit))
-#define __REGVAL(mask, value)	(((value) * __REGSHIFT(mask)) & (mask))
-
-#ifndef __ASSEMBLY__
-
-#  define __REG(x)	((void __iomem __force *)io_p2v((x)))
-#  define __REG2(x, y)	((void __iomem __force *)(io_p2v((x)) + 4 * (y)))
-
-#  define __REGSET(var, field, value)					\
-	((var) = (((var) & ~((field) & ~(value))) | (value)))
-
-#  define REGSET(var, reg, field, value)				\
-	__REGSET(var, reg ## _ ## field, reg ## _ ## field ## _ ## value)
-
-#  define REGSET_IDX(var, reg, field, idx, value)			\
-	__REGSET(var, reg ## _ ## field((idx)), reg ## _ ## field ## _ ## value((idx)))
-
-#  define REGSETIM(var, reg, field, value)				\
-	__REGSET(var, reg ## _ ## field, __REGVAL(reg ## _ ## field, (value)))
-
-#  define REGSETIM_IDX(var, reg, field, idx, value)			\
-	__REGSET(var, reg ## _ ## field((idx)), __REGVAL(reg ## _ ## field((idx)), (value)))
-
-#  define __REGGET(var, field)						\
-	(((var) & (field)))
-
-#  define REGGET(var, reg, field)					\
-	 __REGGET(var, reg ## _ ## field)
-
-#  define REGGET_IDX(var, reg, field, idx)				\
-	 __REGGET(var, reg ## _ ## field((idx)))
-
-#  define REGGETIM(var, reg, field)					\
-	 __REGGET(var, reg ## _ ## field) / __REGSHIFT(reg ## _ ## field)
-
-#  define REGGETIM_IDX(var, reg, field, idx)				\
-	 __REGGET(var, reg ## _ ## field((idx))) /			\
-	 __REGSHIFT(reg ## _ ## field((idx)))
-
-#else
-
-#  define __REG(x)	io_p2v(x)
-#  define __REG2(x, y)	io_p2v((x) + 4 * (y))
-
-#endif
-
-#endif /* ifndef __ASM_ARCH_HARDWARE_H */
diff --git a/arch/arm/mach-ns9xxx/include/mach/io.h b/arch/arm/mach-ns9xxx/include/mach/io.h
deleted file mode 100644
index f08451d..0000000
--- a/arch/arm/mach-ns9xxx/include/mach/io.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/include/mach/io.h
- *
- * Copyright (C) 2006 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#ifndef __ASM_ARCH_IO_H
-#define __ASM_ARCH_IO_H
-
-#define IO_SPACE_LIMIT  0xffffffff /* XXX */
-
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)    (a)
-#define __mem_isa(a)    (IO_BASE + (a))
-
-#endif /* ifndef __ASM_ARCH_IO_H */
diff --git a/arch/arm/mach-ns9xxx/include/mach/irqs.h b/arch/arm/mach-ns9xxx/include/mach/irqs.h
deleted file mode 100644
index 1348394..0000000
--- a/arch/arm/mach-ns9xxx/include/mach/irqs.h
+++ /dev/null
@@ -1,86 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/include/mach/irqs.h
- *
- * Copyright (C) 2006,2007 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#ifndef __ASM_ARCH_IRQS_H
-#define __ASM_ARCH_IRQS_H
-
-/* NetSilicon 9360 */
-#define IRQ_NS9XXX_WATCHDOG	0
-#define IRQ_NS9XXX_AHBBUSERR	1
-#define IRQ_NS9360_BBUSAGG	2
-/* irq 3 is reserved for NS9360 */
-#define IRQ_NS9XXX_ETHRX	4
-#define IRQ_NS9XXX_ETHTX	5
-#define IRQ_NS9XXX_ETHPHY	6
-#define IRQ_NS9360_LCD		7
-#define IRQ_NS9360_SERBRX	8
-#define IRQ_NS9360_SERBTX	9
-#define IRQ_NS9360_SERARX	10
-#define IRQ_NS9360_SERATX	11
-#define IRQ_NS9360_SERCRX	12
-#define IRQ_NS9360_SERCTX	13
-#define IRQ_NS9360_I2C		14
-#define IRQ_NS9360_BBUSDMA	15
-#define IRQ_NS9360_TIMER0	16
-#define IRQ_NS9360_TIMER1	17
-#define IRQ_NS9360_TIMER2	18
-#define IRQ_NS9360_TIMER3	19
-#define IRQ_NS9360_TIMER4	20
-#define IRQ_NS9360_TIMER5	21
-#define IRQ_NS9360_TIMER6	22
-#define IRQ_NS9360_TIMER7	23
-#define IRQ_NS9360_RTC		24
-#define IRQ_NS9360_USBHOST	25
-#define IRQ_NS9360_USBDEVICE	26
-#define IRQ_NS9360_IEEE1284	27
-#define IRQ_NS9XXX_EXT0		28
-#define IRQ_NS9XXX_EXT1		29
-#define IRQ_NS9XXX_EXT2		30
-#define IRQ_NS9XXX_EXT3		31
-
-#define BBUS_IRQ(irq)	(32 + irq)
-
-#define IRQ_BBUS_DMA		BBUS_IRQ(0)
-#define IRQ_BBUS_SERBRX		BBUS_IRQ(2)
-#define IRQ_BBUS_SERBTX		BBUS_IRQ(3)
-#define IRQ_BBUS_SERARX		BBUS_IRQ(4)
-#define IRQ_BBUS_SERATX		BBUS_IRQ(5)
-#define IRQ_BBUS_SERCRX		BBUS_IRQ(6)
-#define IRQ_BBUS_SERCTX		BBUS_IRQ(7)
-#define IRQ_BBUS_SERDRX		BBUS_IRQ(8)
-#define IRQ_BBUS_SERDTX		BBUS_IRQ(9)
-#define IRQ_BBUS_I2C		BBUS_IRQ(10)
-#define IRQ_BBUS_1284		BBUS_IRQ(11)
-#define IRQ_BBUS_UTIL		BBUS_IRQ(12)
-#define IRQ_BBUS_RTC		BBUS_IRQ(13)
-#define IRQ_BBUS_USBHST		BBUS_IRQ(14)
-#define IRQ_BBUS_USBDEV		BBUS_IRQ(15)
-#define IRQ_BBUS_AHBDMA1	BBUS_IRQ(24)
-#define IRQ_BBUS_AHBDMA2	BBUS_IRQ(25)
-
-/*
- * these Interrupts are specific for the a9m9750dev board.
- * They are generated by an FPGA that interrupts the CPU on
- * IRQ_NS9360_EXT2
- */
-#define FPGA_IRQ(irq)	(64 + irq)
-
-#define IRQ_FPGA_UARTA		FPGA_IRQ(0)
-#define IRQ_FPGA_UARTB		FPGA_IRQ(1)
-#define IRQ_FPGA_UARTC		FPGA_IRQ(2)
-#define IRQ_FPGA_UARTD		FPGA_IRQ(3)
-#define IRQ_FPGA_TOUCH		FPGA_IRQ(4)
-#define IRQ_FPGA_CF		FPGA_IRQ(5)
-#define IRQ_FPGA_CAN0		FPGA_IRQ(6)
-#define IRQ_FPGA_CAN1		FPGA_IRQ(7)
-
-#define NR_IRQS	72
-
-#endif /* __ASM_ARCH_IRQS_H */
diff --git a/arch/arm/mach-ns9xxx/include/mach/memory.h b/arch/arm/mach-ns9xxx/include/mach/memory.h
deleted file mode 100644
index 5c65aee..0000000
--- a/arch/arm/mach-ns9xxx/include/mach/memory.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/include/mach/memory.h
- *
- * Copyright (C) 2006 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
-*/
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-/* x in [0..3] */
-#define NS9XXX_CSxSTAT_PHYS(x)	UL(((x) + 4) << 28)
-
-#define NS9XXX_CS0STAT_LENGTH	UL(0x1000)
-#define NS9XXX_CS1STAT_LENGTH	UL(0x1000)
-#define NS9XXX_CS2STAT_LENGTH	UL(0x1000)
-#define NS9XXX_CS3STAT_LENGTH	UL(0x1000)
-
-#define PLAT_PHYS_OFFSET	UL(0x00000000)
-
-#endif
diff --git a/arch/arm/mach-ns9xxx/include/mach/module.h b/arch/arm/mach-ns9xxx/include/mach/module.h
deleted file mode 100644
index 628e975..0000000
--- a/arch/arm/mach-ns9xxx/include/mach/module.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/include/mach/module.h
- *
- * Copyright (C) 2007 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#ifndef __ASM_ARCH_MODULE_H
-#define __ASM_ARCH_MODULE_H
-
-#include <asm/mach-types.h>
-
-#define module_is_cc7ucamry()	(0			\
-		|| machine_is_cc7ucamry()		\
-		)
-
-#define module_is_cc9c()	(0			\
-		)
-
-#define module_is_cc9p9210()	(0			\
-		|| machine_is_cc9p9210()		\
-		|| machine_is_cc9p9210js()		\
-		)
-
-#define module_is_cc9p9215()	(0			\
-		|| machine_is_cc9p9215()		\
-		|| machine_is_cc9p9215js()		\
-		)
-
-#define module_is_cc9p9360()	(0			\
-		|| machine_is_cc9p9360dev()		\
-		|| machine_is_cc9p9360js()		\
-		)
-
-#define module_is_cc9p9750()	(0			\
-		|| machine_is_a9m9750()			\
-		|| machine_is_cc9p9750js()		\
-		|| machine_is_cc9p9750val()		\
-		)
-
-#define module_is_ccw9c()	(0			\
-		)
-
-#define module_is_inc20otter()	(0			\
-		|| machine_is_inc20otter()		\
-		)
-
-#define module_is_otter()	(0			\
-		|| machine_is_otter()			\
-		)
-
-#endif /* ifndef __ASM_ARCH_MODULE_H */
diff --git a/arch/arm/mach-ns9xxx/include/mach/processor-ns9360.h b/arch/arm/mach-ns9xxx/include/mach/processor-ns9360.h
deleted file mode 100644
index f41deda..0000000
--- a/arch/arm/mach-ns9xxx/include/mach/processor-ns9360.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/include/mach/processor-ns9360.h
- *
- * Copyright (C) 2007 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#ifndef __ASM_ARCH_PROCESSORNS9360_H
-#define __ASM_ARCH_PROCESSORNS9360_H
-
-#include <linux/init.h>
-
-void ns9360_reset(char mode);
-
-unsigned long ns9360_systemclock(void) __attribute__((const));
-
-static inline unsigned long ns9360_cpuclock(void) __attribute__((const));
-static inline unsigned long ns9360_cpuclock(void)
-{
-	return ns9360_systemclock() / 2;
-}
-
-void __init ns9360_map_io(void);
-
-extern struct sys_timer ns9360_timer;
-
-int ns9360_gpio_configure(unsigned gpio, int inv, int func);
-
-#endif /* ifndef __ASM_ARCH_PROCESSORNS9360_H */
diff --git a/arch/arm/mach-ns9xxx/include/mach/processor.h b/arch/arm/mach-ns9xxx/include/mach/processor.h
deleted file mode 100644
index 9f77f74..0000000
--- a/arch/arm/mach-ns9xxx/include/mach/processor.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/include/mach/processor.h
- *
- * Copyright (C) 2006,2007 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#ifndef __ASM_ARCH_PROCESSOR_H
-#define __ASM_ARCH_PROCESSOR_H
-
-#include <mach/module.h>
-
-#define processor_is_ns9210()	(0			\
-		|| module_is_cc7ucamry()		\
-		|| module_is_cc9p9210()			\
-		|| module_is_inc20otter()		\
-		|| module_is_otter()			\
-		)
-
-#define processor_is_ns9215()	(0			\
-		|| module_is_cc9p9215()			\
-		)
-
-#define processor_is_ns9360()	(0			\
-		|| module_is_cc9p9360()			\
-		|| module_is_cc9c()			\
-		|| module_is_ccw9c()			\
-		)
-
-#define processor_is_ns9750()	(0			\
-		|| module_is_cc9p9750()			\
-		)
-
-#define processor_is_ns921x()	(0			\
-		|| processor_is_ns9210()		\
-		|| processor_is_ns9215()		\
-		)
-
-#endif /* ifndef __ASM_ARCH_PROCESSOR_H */
diff --git a/arch/arm/mach-ns9xxx/include/mach/regs-bbu.h b/arch/arm/mach-ns9xxx/include/mach/regs-bbu.h
deleted file mode 100644
index af227c0..0000000
--- a/arch/arm/mach-ns9xxx/include/mach/regs-bbu.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/include/mach/regs-bbu.h
- *
- * Copyright (C) 2006 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#ifndef __ASM_ARCH_REGSBBU_H
-#define __ASM_ARCH_REGSBBU_H
-
-#include <mach/hardware.h>
-
-/* BBus Utility */
-
-/* GPIO Configuration Registers block 1 */
-/* NOTE: the HRM starts counting at 1 for the GPIO registers, here the start is
- * at 0 for each block.  That is, BBU_GCONFb1(0) is GPIO Configuration Register
- * #1, BBU_GCONFb2(0) is GPIO Configuration Register #8. */
-#define BBU_GCONFb1(x)	__REG2(0x90600010, (x))
-#define BBU_GCONFb2(x)	__REG2(0x90600100, (x))
-
-#define BBU_GCONFx_DIR(m)	__REGBIT(3 + (((m) & 7) << 2))
-#define BBU_GCONFx_DIR_INPUT(m)	__REGVAL(BBU_GCONFx_DIR(m), 0)
-#define BBU_GCONFx_DIR_OUTPUT(m)	__REGVAL(BBU_GCONFx_DIR(m), 1)
-#define BBU_GCONFx_INV(m)	__REGBIT(2 + (((m) & 7) << 2))
-#define BBU_GCONFx_INV_NO(m)		__REGVAL(BBU_GCONFx_INV(m), 0)
-#define BBU_GCONFx_INV_YES(m)		__REGVAL(BBU_GCONFx_INV(m), 1)
-#define BBU_GCONFx_FUNC(m)	__REGBITS(1 + (((m) & 7) << 2), ((m) & 7) << 2)
-#define BBU_GCONFx_FUNC_0(m)		__REGVAL(BBU_GCONFx_FUNC(m), 0)
-#define BBU_GCONFx_FUNC_1(m)		__REGVAL(BBU_GCONFx_FUNC(m), 1)
-#define BBU_GCONFx_FUNC_2(m)		__REGVAL(BBU_GCONFx_FUNC(m), 2)
-#define BBU_GCONFx_FUNC_3(m)		__REGVAL(BBU_GCONFx_FUNC(m), 3)
-
-#define BBU_GCTRL1	__REG(0x90600030)
-#define BBU_GCTRL2	__REG(0x90600034)
-#define BBU_GCTRL3	__REG(0x90600120)
-
-#define BBU_GSTAT1	__REG(0x90600040)
-#define BBU_GSTAT2	__REG(0x90600044)
-#define BBU_GSTAT3	__REG(0x90600130)
-
-#endif /* ifndef __ASM_ARCH_REGSBBU_H */
diff --git a/arch/arm/mach-ns9xxx/include/mach/regs-board-a9m9750dev.h b/arch/arm/mach-ns9xxx/include/mach/regs-board-a9m9750dev.h
deleted file mode 100644
index cd15936..0000000
--- a/arch/arm/mach-ns9xxx/include/mach/regs-board-a9m9750dev.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/include/mach/regs-board-a9m9750dev.h
- *
- * Copyright (C) 2006 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#ifndef __ASM_ARCH_REGSBOARDA9M9750_H
-#define __ASM_ARCH_REGSBOARDA9M9750_H
-
-#include <mach/hardware.h>
-
-#define FPGA_UARTA_BASE	io_p2v(NS9XXX_CSxSTAT_PHYS(0))
-#define FPGA_UARTB_BASE	io_p2v(NS9XXX_CSxSTAT_PHYS(0) + 0x08)
-#define FPGA_UARTC_BASE	io_p2v(NS9XXX_CSxSTAT_PHYS(0) + 0x10)
-#define FPGA_UARTD_BASE	io_p2v(NS9XXX_CSxSTAT_PHYS(0) + 0x18)
-
-#define FPGA_IER	__REG(NS9XXX_CSxSTAT_PHYS(0) + 0x50)
-#define FPGA_ISR	__REG(NS9XXX_CSxSTAT_PHYS(0) + 0x60)
-
-#endif /* ifndef __ASM_ARCH_REGSBOARDA9M9750_H */
diff --git a/arch/arm/mach-ns9xxx/include/mach/regs-mem.h b/arch/arm/mach-ns9xxx/include/mach/regs-mem.h
deleted file mode 100644
index f1625bf..0000000
--- a/arch/arm/mach-ns9xxx/include/mach/regs-mem.h
+++ /dev/null
@@ -1,135 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/include/mach/regs-mem.h
- *
- * Copyright (C) 2006 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#ifndef __ASM_ARCH_REGSMEM_H
-#define __ASM_ARCH_REGSMEM_H
-
-#include <mach/hardware.h>
-
-/* Memory Module */
-
-/* Control register */
-#define MEM_CTRL	__REG(0xa0700000)
-
-/* Status register */
-#define MEM_STAT	__REG(0xa0700004)
-
-/* Configuration register */
-#define MEM_CONF	__REG(0xa0700008)
-
-/* Dynamic Memory Control register */
-#define MEM_DMCTRL	__REG(0xa0700020)
-
-/* Dynamic Memory Refresh Timer */
-#define MEM_DMRT	__REG(0xa0700024)
-
-/* Dynamic Memory Read Configuration register */
-#define MEM_DMRC	__REG(0xa0700028)
-
-/* Dynamic Memory Precharge Command Period (tRP) */
-#define MEM_DMPCP	__REG(0xa0700030)
-
-/* Dynamic Memory Active to Precharge Command Period (tRAS) */
-#define MEM_DMAPCP	__REG(0xa0700034)
-
-/* Dynamic Memory Self-Refresh Exit Time (tSREX) */
-#define MEM_DMSRET	__REG(0xa0700038)
-
-/* Dynamic Memory Last Data Out to Active Time (tAPR) */
-#define MEM_DMLDOAT	__REG(0xa070003c)
-
-/* Dynamic Memory Data-in to Active Command Time (tDAL or TAPW) */
-#define MEM_DMDIACT	__REG(0xa0700040)
-
-/* Dynamic Memory Write Recovery Time (tWR, tDPL, tRWL, tRDL) */
-#define MEM_DMWRT	__REG(0xa0700044)
-
-/* Dynamic Memory Active to Active Command Period (tRC) */
-#define MEM_DMAACP	__REG(0xa0700048)
-
-/* Dynamic Memory Auto Refresh Period, and Auto Refresh to Active Command Period (tRFC) */
-#define MEM_DMARP	__REG(0xa070004c)
-
-/* Dynamic Memory Exit Self-Refresh to Active Command (tXSR) */
-#define MEM_DMESRAC	__REG(0xa0700050)
-
-/* Dynamic Memory Active Bank A to Active B Time (tRRD) */
-#define MEM_DMABAABT	__REG(0xa0700054)
-
-/* Dynamic Memory Load Mode register to Active Command Time (tMRD) */
-#define MEM_DMLMACT	__REG(0xa0700058)
-
-/* Static Memory Extended Wait */
-#define MEM_SMEW	__REG(0xa0700080)
-
-/* Dynamic Memory Configuration Register x */
-#define MEM_DMCONF(x) 	__REG2(0xa0700100, (x) << 3)
-
-/* Dynamic Memory RAS and CAS Delay x */
-#define MEM_DMRCD(x)	__REG2(0xa0700104, (x) << 3)
-
-/* Static Memory Configuration Register x */
-#define MEM_SMC(x)	__REG2(0xa0700200, (x) << 3)
-
-/* Static Memory Configuration Register x: Write protect */
-#define MEM_SMC_PSMC		__REGBIT(20)
-#define MEM_SMC_PSMC_OFF		__REGVAL(MEM_SMC_PSMC, 0)
-#define MEM_SMC_PSMC_ON			__REGVAL(MEM_SMC_PSMC, 1)
-
-/* Static Memory Configuration Register x: Buffer enable */
-#define MEM_SMC_BSMC		__REGBIT(19)
-#define MEM_SMC_BSMC_OFF		__REGVAL(MEM_SMC_BSMC, 0)
-#define MEM_SMC_BSMC_ON			__REGVAL(MEM_SMC_BSMC, 1)
-
-/* Static Memory Configuration Register x: Extended Wait */
-#define MEM_SMC_EW		__REGBIT(8)
-#define MEM_SMC_EW_OFF			__REGVAL(MEM_SMC_EW, 0)
-#define MEM_SMC_EW_ON			__REGVAL(MEM_SMC_EW, 1)
-
-/* Static Memory Configuration Register x: Byte lane state */
-#define MEM_SMC_PB		__REGBIT(7)
-#define MEM_SMC_PB_0			__REGVAL(MEM_SMC_PB, 0)
-#define MEM_SMC_PB_1			__REGVAL(MEM_SMC_PB, 1)
-
-/* Static Memory Configuration Register x: Chip select polarity */
-#define MEM_SMC_PC		__REGBIT(6)
-#define MEM_SMC_PC_AL			__REGVAL(MEM_SMC_PC, 0)
-#define MEM_SMC_PC_AH			__REGVAL(MEM_SMC_PC, 1)
-
-/* static memory configuration register x: page mode*/
-#define MEM_SMC_PM		__REGBIT(3)
-#define MEM_SMC_PM_DIS			__REGVAL(MEM_SMC_PM, 0)
-#define MEM_SMC_PM_ASYNC		__REGVAL(MEM_SMC_PM, 1)
-
-/* static memory configuration register x: Memory width */
-#define MEM_SMC_MW		__REGBITS(1, 0)
-#define MEM_SMC_MW_8			__REGVAL(MEM_SMC_MW, 0)
-#define MEM_SMC_MW_16			__REGVAL(MEM_SMC_MW, 1)
-#define MEM_SMC_MW_32			__REGVAL(MEM_SMC_MW, 2)
-
-/* Static Memory Write Enable Delay x */
-#define MEM_SMWED(x)	__REG2(0xa0700204, (x) << 3)
-
-/* Static Memory Output Enable Delay x */
-#define MEM_SMOED(x)	__REG2(0xa0700208, (x) << 3)
-
-/* Static Memory Read Delay x */
-#define MEM_SMRD(x)	__REG2(0xa070020c, (x) << 3)
-
-/* Static Memory Page Mode Read Delay 0 */
-#define MEM_SMPMRD(x)	__REG2(0xa0700210, (x) << 3)
-
-/* Static Memory Write Delay */
-#define MEM_SMWD(x)	__REG2(0xa0700214, (x) << 3)
-
-/* Static Memory Turn Round Delay x */
-#define MEM_SWT(x)	__REG2(0xa0700218, (x) << 3)
-
-#endif /* ifndef __ASM_ARCH_REGSMEM_H */
diff --git a/arch/arm/mach-ns9xxx/include/mach/regs-sys-common.h b/arch/arm/mach-ns9xxx/include/mach/regs-sys-common.h
deleted file mode 100644
index 14f91df..0000000
--- a/arch/arm/mach-ns9xxx/include/mach/regs-sys-common.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/include/mach/regs-sys-common.h
- *
- * Copyright (C) 2007 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_REGSSYSCOMMON_H
-#define __ASM_ARCH_REGSSYSCOMMON_H
-#include <mach/hardware.h>
-
-/* Interrupt Vector Address Register Level x */
-#define SYS_IVA(x)	__REG2(0xa09000c4, (x))
-
-/* Interrupt Configuration registers */
-#define SYS_IC(x)	__REG2(0xa0900144, (x))
-
-/* ISRADDR */
-#define SYS_ISRADDR     __REG(0xa0900164)
-
-/* Interrupt Status Active */
-#define SYS_ISA		__REG(0xa0900168)
-
-/* Interrupt Status Raw */
-#define SYS_ISR		__REG(0xa090016c)
-
-#endif /* ifndef __ASM_ARCH_REGSSYSCOMMON_H */
diff --git a/arch/arm/mach-ns9xxx/include/mach/regs-sys-ns9360.h b/arch/arm/mach-ns9xxx/include/mach/regs-sys-ns9360.h
deleted file mode 100644
index 8ff254d..0000000
--- a/arch/arm/mach-ns9xxx/include/mach/regs-sys-ns9360.h
+++ /dev/null
@@ -1,148 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/include/mach/regs-sys-ns9360.h
- *
- * Copyright (C) 2006,2007 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#ifndef __ASM_ARCH_REGSSYSNS9360_H
-#define __ASM_ARCH_REGSSYSNS9360_H
-
-#include <mach/hardware.h>
-
-/* System Control Module */
-
-/* AHB Arbiter Gen Configuration */
-#define SYS_AHBAGENCONF	__REG(0xa0900000)
-
-/* BRC */
-#define SYS_BRC(x)	__REG2(0xa0900004, (x))
-
-/* Timer x Reload Count register */
-#define SYS_TRC(x)	__REG2(0xa0900044, (x))
-
-/* Timer x Read register */
-#define SYS_TR(x)	__REG2(0xa0900084, (x))
-
-/* Timer Interrupt Status register */
-#define SYS_TIS		__REG(0xa0900170)
-
-/* PLL Configuration register */
-#define SYS_PLL		__REG(0xa0900188)
-
-/* PLL FS status */
-#define SYS_PLL_FS		__REGBITS(24, 23)
-
-/* PLL ND status */
-#define SYS_PLL_ND		__REGBITS(20, 16)
-
-/* PLL Configuration register: PLL SW change */
-#define SYS_PLL_SWC		__REGBIT(15)
-#define SYS_PLL_SWC_NO			__REGVAL(SYS_PLL_SWC, 0)
-#define SYS_PLL_SWC_YES			__REGVAL(SYS_PLL_SWC, 1)
-
-/* Timer x Control register */
-#define SYS_TC(x)	__REG2(0xa0900190, (x))
-
-/* Timer x Control register: Timer enable */
-#define SYS_TCx_TEN		__REGBIT(15)
-#define SYS_TCx_TEN_DIS			__REGVAL(SYS_TCx_TEN, 0)
-#define SYS_TCx_TEN_EN			__REGVAL(SYS_TCx_TEN, 1)
-
-/* Timer x Control register: CPU debug mode */
-#define SYS_TCx_TDBG		__REGBIT(10)
-#define SYS_TCx_TDBG_CONT		__REGVAL(SYS_TCx_TDBG, 0)
-#define SYS_TCx_TDBG_STOP		__REGVAL(SYS_TCx_TDBG, 1)
-
-/* Timer x Control register: Interrupt clear */
-#define SYS_TCx_INTC		__REGBIT(9)
-#define SYS_TCx_INTC_UNSET		__REGVAL(SYS_TCx_INTC, 0)
-#define SYS_TCx_INTC_SET		__REGVAL(SYS_TCx_INTC, 1)
-
-/* Timer x Control register: Timer clock select */
-#define SYS_TCx_TLCS		__REGBITS(8, 6)
-#define SYS_TCx_TLCS_CPU		__REGVAL(SYS_TCx_TLCS, 0)	/* CPU clock */
-#define SYS_TCx_TLCS_DIV2		__REGVAL(SYS_TCx_TLCS, 1)	/* CPU clock / 2 */
-#define SYS_TCx_TLCS_DIV4		__REGVAL(SYS_TCx_TLCS, 2)	/* CPU clock / 4 */
-#define SYS_TCx_TLCS_DIV8		__REGVAL(SYS_TCx_TLCS, 3)	/* CPU clock / 8 */
-#define SYS_TCx_TLCS_DIV16		__REGVAL(SYS_TCx_TLCS, 4)	/* CPU clock / 16 */
-#define SYS_TCx_TLCS_DIV32		__REGVAL(SYS_TCx_TLCS, 5)	/* CPU clock / 32 */
-#define SYS_TCx_TLCS_DIV64		__REGVAL(SYS_TCx_TLCS, 6)	/* CPU clock / 64 */
-#define SYS_TCx_TLCS_EXT		__REGVAL(SYS_TCx_TLCS, 7)
-
-/* Timer x Control register: Timer mode */
-#define SYS_TCx_TM		__REGBITS(5, 4)
-#define SYS_TCx_TM_IEE			__REGVAL(SYS_TCx_TM, 0)		/* Internal timer or external event */
-#define SYS_TCx_TM_ELL			__REGVAL(SYS_TCx_TM, 1)		/* External low-level, gated timer */
-#define SYS_TCx_TM_EHL			__REGVAL(SYS_TCx_TM, 2)		/* External high-level, gated timer */
-#define SYS_TCx_TM_CONCAT		__REGVAL(SYS_TCx_TM, 3)		/* Concatenate the lower timer. */
-
-/* Timer x Control register: Interrupt select */
-#define SYS_TCx_INTS		__REGBIT(3)
-#define SYS_TCx_INTS_DIS		__REGVAL(SYS_TCx_INTS, 0)
-#define SYS_TCx_INTS_EN			__REGVAL(SYS_TCx_INTS, 1)
-
-/* Timer x Control register: Up/down select */
-#define SYS_TCx_UDS		__REGBIT(2)
-#define SYS_TCx_UDS_UP			__REGVAL(SYS_TCx_UDS, 0)
-#define SYS_TCx_UDS_DOWN		__REGVAL(SYS_TCx_UDS, 1)
-
-/* Timer x Control register: 32- or 16-bit timer */
-#define SYS_TCx_TSZ		__REGBIT(1)
-#define SYS_TCx_TSZ_16			__REGVAL(SYS_TCx_TSZ, 0)
-#define SYS_TCx_TSZ_32			__REGVAL(SYS_TCx_TSZ, 1)
-
-/* Timer x Control register: Reload enable */
-#define SYS_TCx_REN		__REGBIT(0)
-#define SYS_TCx_REN_DIS			__REGVAL(SYS_TCx_REN, 0)
-#define SYS_TCx_REN_EN			__REGVAL(SYS_TCx_REN, 1)
-
-/* System Memory Chip Select x Dynamic Memory Base */
-#define SYS_SMCSDMB(x)	__REG2(0xa09001d0, (x) << 1)
-
-/* System Memory Chip Select x Dynamic Memory Mask */
-#define SYS_SMCSDMM(x)	__REG2(0xa09001d4, (x) << 1)
-
-/* System Memory Chip Select x Static Memory Base */
-#define SYS_SMCSSMB(x)	__REG2(0xa09001f0, (x) << 1)
-
-/* System Memory Chip Select x Static Memory Base: Chip select x base */
-#define SYS_SMCSSMB_CSxB	__REGBITS(31, 12)
-
-/* System Memory Chip Select x Static Memory Mask */
-#define SYS_SMCSSMM(x)	__REG2(0xa09001f4, (x) << 1)
-
-/* System Memory Chip Select x Static Memory Mask: Chip select x mask */
-#define SYS_SMCSSMM_CSxM	__REGBITS(31, 12)
-
-/* System Memory Chip Select x Static Memory Mask: Chip select x enable */
-#define SYS_SMCSSMM_CSEx	__REGBIT(0)
-#define SYS_SMCSSMM_CSEx_DIS		__REGVAL(SYS_SMCSSMM_CSEx, 0)
-#define SYS_SMCSSMM_CSEx_EN		__REGVAL(SYS_SMCSSMM_CSEx, 1)
-
-/* General purpose, user-defined ID register */
-#define SYS_GENID	__REG(0xa0900210)
-
-/* External Interrupt x Control register */
-#define SYS_EIC(x)	__REG2(0xa0900214, (x))
-
-/* External Interrupt x Control register: Status */
-#define SYS_EIC_STS		__REGBIT(3)
-
-/* External Interrupt x Control register: Clear */
-#define SYS_EIC_CLR		__REGBIT(2)
-
-/* External Interrupt x Control register: Polarity */
-#define SYS_EIC_PLTY		__REGBIT(1)
-#define SYS_EIC_PLTY_AH			__REGVAL(SYS_EIC_PLTY, 0)
-#define SYS_EIC_PLTY_AL			__REGVAL(SYS_EIC_PLTY, 1)
-
-/* External Interrupt x Control register: Level edge */
-#define SYS_EIC_LVEDG		__REGBIT(0)
-#define SYS_EIC_LVEDG_LEVEL		__REGVAL(SYS_EIC_LVEDG, 0)
-#define SYS_EIC_LVEDG_EDGE		__REGVAL(SYS_EIC_LVEDG, 1)
-
-#endif /* ifndef __ASM_ARCH_REGSSYSNS9360_H */
diff --git a/arch/arm/mach-ns9xxx/include/mach/system.h b/arch/arm/mach-ns9xxx/include/mach/system.h
deleted file mode 100644
index 1561588..0000000
--- a/arch/arm/mach-ns9xxx/include/mach/system.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/include/mach/system.h
- *
- * Copyright (C) 2006,2007 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H
-
-#include <asm/proc-fns.h>
-#include <mach/processor.h>
-#include <mach/processor-ns9360.h>
-
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-#ifdef CONFIG_PROCESSOR_NS9360
-	if (processor_is_ns9360())
-		ns9360_reset(mode);
-	else
-#endif
-		BUG();
-
-	BUG();
-}
-
-#endif /* ifndef __ASM_ARCH_SYSTEM_H */
diff --git a/arch/arm/mach-ns9xxx/include/mach/timex.h b/arch/arm/mach-ns9xxx/include/mach/timex.h
deleted file mode 100644
index 734a8d8..0000000
--- a/arch/arm/mach-ns9xxx/include/mach/timex.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/include/mach/timex.h
- *
- * Copyright (C) 2005-2006 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#ifndef __ASM_ARCH_TIMEX_H
-#define __ASM_ARCH_TIMEX_H
-
-/*
- * value for CLOCK_TICK_RATE stolen from arch/arm/mach-s3c2410/include/mach/timex.h.
- * See there for an explanation.
- */
-#define CLOCK_TICK_RATE         12000000
-
-#endif /* ifndef __ASM_ARCH_TIMEX_H */
diff --git a/arch/arm/mach-ns9xxx/include/mach/uncompress.h b/arch/arm/mach-ns9xxx/include/mach/uncompress.h
deleted file mode 100644
index 770a68c..0000000
--- a/arch/arm/mach-ns9xxx/include/mach/uncompress.h
+++ /dev/null
@@ -1,164 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/include/mach/uncompress.h
- *
- * Copyright (C) 2006 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#ifndef __ASM_ARCH_UNCOMPRESS_H
-#define __ASM_ARCH_UNCOMPRESS_H
-
-#include <linux/io.h>
-
-#define __REG(x)	((void __iomem __force *)(x))
-
-static void putc_dummy(char c, void __iomem *base)
-{
-	/* nothing */
-}
-
-static int timeout;
-
-static void putc_ns9360(char c, void __iomem *base)
-{
-	do {
-		if (timeout)
-			--timeout;
-
-		if (__raw_readl(base + 8) & (1 << 3)) {
-			__raw_writeb(c, base + 16);
-			timeout = 0x10000;
-			break;
-		}
-	} while (timeout);
-}
-
-static void putc_a9m9750dev(char c, void __iomem *base)
-{
-	do {
-		if (timeout)
-			--timeout;
-
-		if (__raw_readb(base + 5) & (1 << 5)) {
-			__raw_writeb(c, base);
-			timeout = 0x10000;
-			break;
-		}
-	} while (timeout);
-
-}
-
-static void putc_ns921x(char c, void __iomem *base)
-{
-	do {
-		if (timeout)
-			--timeout;
-
-		if (!(__raw_readl(base) & (1 << 11))) {
-			__raw_writeb(c, base + 0x0028);
-			timeout = 0x10000;
-			break;
-		}
-	} while (timeout);
-}
-
-#define MSCS __REG(0xA0900184)
-
-#define NS9360_UARTA	__REG(0x90200040)
-#define NS9360_UARTB	__REG(0x90200000)
-#define NS9360_UARTC	__REG(0x90300000)
-#define NS9360_UARTD	__REG(0x90300040)
-
-#define NS9360_UART_ENABLED(base)					\
-		(__raw_readl(NS9360_UARTA) & (1 << 31))
-
-#define A9M9750DEV_UARTA	__REG(0x40000000)
-
-#define NS921XSYS_CLOCK	__REG(0xa090017c)
-#define NS921X_UARTA	__REG(0x90010000)
-#define NS921X_UARTB	__REG(0x90018000)
-#define NS921X_UARTC	__REG(0x90020000)
-#define NS921X_UARTD	__REG(0x90028000)
-
-#define NS921X_UART_ENABLED(base)					\
-		(__raw_readl((base) + 0x1000) & (1 << 29))
-
-static void autodetect(void (**putc)(char, void __iomem *), void __iomem **base)
-{
-	timeout = 0x10000;
-	if (((__raw_readl(MSCS) >> 16) & 0xfe) == 0x00) {
-		/* ns9360 or ns9750 */
-		if (NS9360_UART_ENABLED(NS9360_UARTA)) {
-			*putc = putc_ns9360;
-			*base = NS9360_UARTA;
-			return;
-		} else if (NS9360_UART_ENABLED(NS9360_UARTB)) {
-			*putc = putc_ns9360;
-			*base = NS9360_UARTB;
-			return;
-		} else if (NS9360_UART_ENABLED(NS9360_UARTC)) {
-			*putc = putc_ns9360;
-			*base = NS9360_UARTC;
-			return;
-		} else if (NS9360_UART_ENABLED(NS9360_UARTD)) {
-			*putc = putc_ns9360;
-			*base = NS9360_UARTD;
-			return;
-		} else if (__raw_readl(__REG(0xa09001f4)) == 0xfffff001) {
-			*putc = putc_a9m9750dev;
-			*base = A9M9750DEV_UARTA;
-			return;
-		}
-	} else if (((__raw_readl(MSCS) >> 16) & 0xfe) == 0x02) {
-		/* ns921x */
-		u32 clock = __raw_readl(NS921XSYS_CLOCK);
-
-		if ((clock & (1 << 1)) &&
-				NS921X_UART_ENABLED(NS921X_UARTA)) {
-			*putc = putc_ns921x;
-			*base = NS921X_UARTA;
-			return;
-		} else if ((clock & (1 << 2)) &&
-				NS921X_UART_ENABLED(NS921X_UARTB)) {
-			*putc = putc_ns921x;
-			*base = NS921X_UARTB;
-			return;
-		} else if ((clock & (1 << 3)) &&
-				NS921X_UART_ENABLED(NS921X_UARTC)) {
-			*putc = putc_ns921x;
-			*base = NS921X_UARTC;
-			return;
-		} else if ((clock & (1 << 4)) &&
-				NS921X_UART_ENABLED(NS921X_UARTD)) {
-			*putc = putc_ns921x;
-			*base = NS921X_UARTD;
-			return;
-		}
-	}
-
-	*putc = putc_dummy;
-}
-
-void (*myputc)(char, void __iomem *);
-void __iomem *base;
-
-static void putc(char c)
-{
-	myputc(c, base);
-}
-
-static void arch_decomp_setup(void)
-{
-	autodetect(&myputc, &base);
-}
-#define arch_decomp_wdog()
-
-static void flush(void)
-{
-	/* nothing */
-}
-
-#endif /* ifndef __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-ns9xxx/include/mach/vmalloc.h b/arch/arm/mach-ns9xxx/include/mach/vmalloc.h
deleted file mode 100644
index c865197..0000000
--- a/arch/arm/mach-ns9xxx/include/mach/vmalloc.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/include/mach/vmalloc.h
- *
- * Copyright (C) 2006 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#ifndef __ASM_ARCH_VMALLOC_H
-#define __ASM_ARCH_VMALLOC_H
-
-#define VMALLOC_END     (0xf0000000UL)
-
-#endif /* ifndef __ASM_ARCH_VMALLOC_H */
diff --git a/arch/arm/mach-ns9xxx/irq.c b/arch/arm/mach-ns9xxx/irq.c
deleted file mode 100644
index 37ab0a2..0000000
--- a/arch/arm/mach-ns9xxx/irq.c
+++ /dev/null
@@ -1,74 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/irq.c
- *
- * Copyright (C) 2006,2007 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#include <linux/interrupt.h>
-#include <linux/kernel_stat.h>
-#include <linux/io.h>
-#include <asm/mach/irq.h>
-#include <mach/regs-sys-common.h>
-#include <mach/irqs.h>
-#include <mach/board.h>
-
-#include "generic.h"
-
-/* simple interrupt prio table: prio(x) < prio(y) <=> x < y */
-#define irq2prio(i) (i)
-#define prio2irq(p) (p)
-
-static void ns9xxx_mask_irq(struct irq_data *d)
-{
-	/* XXX: better use cpp symbols */
-	int prio = irq2prio(d->irq);
-	u32 ic = __raw_readl(SYS_IC(prio / 4));
-	ic &= ~(1 << (7 + 8 * (3 - (prio & 3))));
-	__raw_writel(ic, SYS_IC(prio / 4));
-}
-
-static void ns9xxx_eoi_irq(struct irq_data *d)
-{
-	__raw_writel(0, SYS_ISRADDR);
-}
-
-static void ns9xxx_unmask_irq(struct irq_data *d)
-{
-	/* XXX: better use cpp symbols */
-	int prio = irq2prio(d->irq);
-	u32 ic = __raw_readl(SYS_IC(prio / 4));
-	ic |= 1 << (7 + 8 * (3 - (prio & 3)));
-	__raw_writel(ic, SYS_IC(prio / 4));
-}
-
-static struct irq_chip ns9xxx_chip = {
-	.irq_eoi	= ns9xxx_eoi_irq,
-	.irq_mask	= ns9xxx_mask_irq,
-	.irq_unmask	= ns9xxx_unmask_irq,
-};
-
-void __init ns9xxx_init_irq(void)
-{
-	int i;
-
-	/* disable all IRQs */
-	for (i = 0; i < 8; ++i)
-		__raw_writel(prio2irq(4 * i) << 24 |
-				prio2irq(4 * i + 1) << 16 |
-				prio2irq(4 * i + 2) << 8 |
-				prio2irq(4 * i + 3),
-				SYS_IC(i));
-
-	for (i = 0; i < 32; ++i)
-		__raw_writel(prio2irq(i), SYS_IVA(i));
-
-	for (i = 0; i <= 31; ++i) {
-		irq_set_chip_and_handler(i, &ns9xxx_chip, handle_fasteoi_irq);
-		set_irq_flags(i, IRQF_VALID);
-		irq_set_status_flags(i, IRQ_LEVEL);
-	}
-}
diff --git a/arch/arm/mach-ns9xxx/mach-cc9p9360dev.c b/arch/arm/mach-ns9xxx/mach-cc9p9360dev.c
deleted file mode 100644
index 2858417..0000000
--- a/arch/arm/mach-ns9xxx/mach-cc9p9360dev.c
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/mach-cc9p9360dev.c
- *
- * Copyright (C) 2006,2007 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#include <asm/mach/arch.h>
-#include <asm/mach-types.h>
-
-#include <mach/processor-ns9360.h>
-
-#include "board-a9m9750dev.h"
-#include "generic.h"
-
-static void __init mach_cc9p9360dev_map_io(void)
-{
-	ns9360_map_io();
-	board_a9m9750dev_map_io();
-}
-
-static void __init mach_cc9p9360dev_init_irq(void)
-{
-	ns9xxx_init_irq();
-	board_a9m9750dev_init_irq();
-}
-
-static void __init mach_cc9p9360dev_init_machine(void)
-{
-	ns9xxx_init_machine();
-	board_a9m9750dev_init_machine();
-}
-
-MACHINE_START(CC9P9360DEV, "Digi ConnectCore 9P 9360 on an A9M9750 Devboard")
-	.map_io = mach_cc9p9360dev_map_io,
-	.init_irq = mach_cc9p9360dev_init_irq,
-	.init_machine = mach_cc9p9360dev_init_machine,
-	.timer = &ns9360_timer,
-	.boot_params = 0x100,
-MACHINE_END
diff --git a/arch/arm/mach-ns9xxx/mach-cc9p9360js.c b/arch/arm/mach-ns9xxx/mach-cc9p9360js.c
deleted file mode 100644
index 729f68d..0000000
--- a/arch/arm/mach-ns9xxx/mach-cc9p9360js.c
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/mach-cc9p9360js.c
- *
- * Copyright (C) 2006,2007 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#include <asm/mach/arch.h>
-#include <asm/mach-types.h>
-
-#include <mach/processor-ns9360.h>
-
-#include "board-jscc9p9360.h"
-#include "generic.h"
-
-static void __init mach_cc9p9360js_init_machine(void)
-{
-	ns9xxx_init_machine();
-	board_jscc9p9360_init_machine();
-}
-
-MACHINE_START(CC9P9360JS, "Digi ConnectCore 9P 9360 on an JSCC9P9360 Devboard")
-	.map_io = ns9360_map_io,
-	.init_irq = ns9xxx_init_irq,
-	.init_machine = mach_cc9p9360js_init_machine,
-	.timer = &ns9360_timer,
-	.boot_params = 0x100,
-MACHINE_END
diff --git a/arch/arm/mach-ns9xxx/plat-serial8250.c b/arch/arm/mach-ns9xxx/plat-serial8250.c
deleted file mode 100644
index 463e924..0000000
--- a/arch/arm/mach-ns9xxx/plat-serial8250.c
+++ /dev/null
@@ -1,70 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/plat-serial8250.c
- *
- * Copyright (C) 2008 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#include <linux/platform_device.h>
-#include <linux/serial_8250.h>
-#include <linux/slab.h>
-
-#include <mach/regs-board-a9m9750dev.h>
-#include <mach/board.h>
-
-#define DRIVER_NAME "serial8250"
-
-static int __init ns9xxx_plat_serial8250_init(void)
-{
-	struct plat_serial8250_port *pdata;
-	struct platform_device *pdev;
-	int ret = -ENOMEM;
-	int i;
-
-	if (!board_is_a9m9750dev())
-		return -ENODEV;
-
-	pdev = platform_device_alloc(DRIVER_NAME, 0);
-	if (!pdev)
-		goto err;
-
-	pdata = kzalloc(5 * sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		goto err;
-
-	pdev->dev.platform_data = pdata;
-
-	pdata[0].iobase = FPGA_UARTA_BASE;
-	pdata[1].iobase = FPGA_UARTB_BASE;
-	pdata[2].iobase = FPGA_UARTC_BASE;
-	pdata[3].iobase = FPGA_UARTD_BASE;
-
-	for (i = 0; i < 4; ++i) {
-		pdata[i].membase = (void __iomem *)pdata[i].iobase;
-		pdata[i].mapbase = pdata[i].iobase;
-		pdata[i].iotype = UPIO_MEM;
-		pdata[i].uartclk = 18432000;
-		pdata[i].flags = UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
-	}
-
-	pdata[0].irq = IRQ_FPGA_UARTA;
-	pdata[1].irq = IRQ_FPGA_UARTB;
-	pdata[2].irq = IRQ_FPGA_UARTC;
-	pdata[3].irq = IRQ_FPGA_UARTD;
-
-	ret = platform_device_add(pdev);
-	if (ret) {
-err:
-		platform_device_put(pdev);
-
-		printk(KERN_WARNING "Could not add %s (errno=%d)\n",
-				DRIVER_NAME, ret);
-	}
-
-	return 0;
-}
-
-arch_initcall(ns9xxx_plat_serial8250_init);
diff --git a/arch/arm/mach-ns9xxx/processor-ns9360.c b/arch/arm/mach-ns9xxx/processor-ns9360.c
deleted file mode 100644
index aed1999..0000000
--- a/arch/arm/mach-ns9xxx/processor-ns9360.c
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/processor-ns9360.c
- *
- * Copyright (C) 2007 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#include <linux/io.h>
-#include <linux/kernel.h>
-
-#include <asm/page.h>
-#include <asm/mach/map.h>
-#include <mach/processor-ns9360.h>
-#include <mach/regs-sys-ns9360.h>
-
-void ns9360_reset(char mode)
-{
-	u32 reg;
-
-	reg = __raw_readl(SYS_PLL) >> 16;
-	REGSET(reg, SYS_PLL, SWC, YES);
-	__raw_writel(reg, SYS_PLL);
-}
-
-#define CRYSTAL 29491200 /* Hz */
-unsigned long ns9360_systemclock(void)
-{
-	u32 pll = __raw_readl(SYS_PLL);
-	return CRYSTAL * (REGGETIM(pll, SYS_PLL, ND) + 1)
-		>> REGGETIM(pll, SYS_PLL, FS);
-}
-
-static struct map_desc ns9360_io_desc[] __initdata = {
-	{ /* BBus */
-		.virtual = io_p2v(0x90000000),
-		.pfn = __phys_to_pfn(0x90000000),
-		.length = 0x00700000,
-		.type = MT_DEVICE,
-	}, { /* AHB */
-		.virtual = io_p2v(0xa0100000),
-		.pfn = __phys_to_pfn(0xa0100000),
-		.length = 0x00900000,
-		.type = MT_DEVICE,
-	},
-};
-
-void __init ns9360_map_io(void)
-{
-	iotable_init(ns9360_io_desc, ARRAY_SIZE(ns9360_io_desc));
-}
diff --git a/arch/arm/mach-ns9xxx/time-ns9360.c b/arch/arm/mach-ns9xxx/time-ns9360.c
deleted file mode 100644
index 9ca32f5..0000000
--- a/arch/arm/mach-ns9xxx/time-ns9360.c
+++ /dev/null
@@ -1,181 +0,0 @@
-/*
- * arch/arm/mach-ns9xxx/time-ns9360.c
- *
- * Copyright (C) 2006,2007 by Digi International Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-#include <linux/jiffies.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/stringify.h>
-#include <linux/clocksource.h>
-#include <linux/clockchips.h>
-
-#include <mach/processor-ns9360.h>
-#include <mach/regs-sys-ns9360.h>
-#include <mach/irqs.h>
-#include <mach/system.h>
-#include "generic.h"
-
-#define TIMER_CLOCKSOURCE 0
-#define TIMER_CLOCKEVENT 1
-static u32 latch;
-
-static cycle_t ns9360_clocksource_read(struct clocksource *cs)
-{
-	return __raw_readl(SYS_TR(TIMER_CLOCKSOURCE));
-}
-
-static struct clocksource ns9360_clocksource = {
-	.name	= "ns9360-timer" __stringify(TIMER_CLOCKSOURCE),
-	.rating	= 300,
-	.read	= ns9360_clocksource_read,
-	.mask	= CLOCKSOURCE_MASK(32),
-	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
-static void ns9360_clockevent_setmode(enum clock_event_mode mode,
-		struct clock_event_device *clk)
-{
-	u32 tc = __raw_readl(SYS_TC(TIMER_CLOCKEVENT));
-
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		__raw_writel(latch, SYS_TRC(TIMER_CLOCKEVENT));
-		REGSET(tc, SYS_TCx, REN, EN);
-		REGSET(tc, SYS_TCx, INTS, EN);
-		REGSET(tc, SYS_TCx, TEN, EN);
-		break;
-
-	case CLOCK_EVT_MODE_ONESHOT:
-		REGSET(tc, SYS_TCx, REN, DIS);
-		REGSET(tc, SYS_TCx, INTS, EN);
-
-		/* fall through */
-
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_RESUME:
-	default:
-		REGSET(tc, SYS_TCx, TEN, DIS);
-		break;
-	}
-
-	__raw_writel(tc, SYS_TC(TIMER_CLOCKEVENT));
-}
-
-static int ns9360_clockevent_setnextevent(unsigned long evt,
-		struct clock_event_device *clk)
-{
-	u32 tc = __raw_readl(SYS_TC(TIMER_CLOCKEVENT));
-
-	if (REGGET(tc, SYS_TCx, TEN)) {
-		REGSET(tc, SYS_TCx, TEN, DIS);
-		__raw_writel(tc, SYS_TC(TIMER_CLOCKEVENT));
-	}
-
-	REGSET(tc, SYS_TCx, TEN, EN);
-
-	__raw_writel(evt, SYS_TRC(TIMER_CLOCKEVENT));
-
-	__raw_writel(tc, SYS_TC(TIMER_CLOCKEVENT));
-
-	return 0;
-}
-
-static struct clock_event_device ns9360_clockevent_device = {
-	.name		= "ns9360-timer" __stringify(TIMER_CLOCKEVENT),
-	.shift		= 20,
-	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_mode	= ns9360_clockevent_setmode,
-	.set_next_event	= ns9360_clockevent_setnextevent,
-};
-
-static irqreturn_t ns9360_clockevent_handler(int irq, void *dev_id)
-{
-	int timerno = irq - IRQ_NS9360_TIMER0;
-	u32 tc;
-
-	struct clock_event_device *evt = &ns9360_clockevent_device;
-
-	/* clear irq */
-	tc = __raw_readl(SYS_TC(timerno));
-	if (REGGET(tc, SYS_TCx, REN) == SYS_TCx_REN_DIS) {
-		REGSET(tc, SYS_TCx, TEN, DIS);
-		__raw_writel(tc, SYS_TC(timerno));
-	}
-	REGSET(tc, SYS_TCx, INTC, SET);
-	__raw_writel(tc, SYS_TC(timerno));
-	REGSET(tc, SYS_TCx, INTC, UNSET);
-	__raw_writel(tc, SYS_TC(timerno));
-
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
-static struct irqaction ns9360_clockevent_action = {
-	.name		= "ns9360-timer" __stringify(TIMER_CLOCKEVENT),
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= ns9360_clockevent_handler,
-};
-
-static void __init ns9360_timer_init(void)
-{
-	int tc;
-
-	tc = __raw_readl(SYS_TC(TIMER_CLOCKSOURCE));
-	if (REGGET(tc, SYS_TCx, TEN)) {
-		REGSET(tc, SYS_TCx, TEN, DIS);
-		__raw_writel(tc, SYS_TC(TIMER_CLOCKSOURCE));
-	}
-
-	__raw_writel(0, SYS_TRC(TIMER_CLOCKSOURCE));
-
-	REGSET(tc, SYS_TCx, TEN, EN);
-	REGSET(tc, SYS_TCx, TDBG, STOP);
-	REGSET(tc, SYS_TCx, TLCS, CPU);
-	REGSET(tc, SYS_TCx, TM, IEE);
-	REGSET(tc, SYS_TCx, INTS, DIS);
-	REGSET(tc, SYS_TCx, UDS, UP);
-	REGSET(tc, SYS_TCx, TSZ, 32);
-	REGSET(tc, SYS_TCx, REN, EN);
-
-	__raw_writel(tc, SYS_TC(TIMER_CLOCKSOURCE));
-
-	clocksource_register_hz(&ns9360_clocksource, ns9360_cpuclock());
-
-	latch = SH_DIV(ns9360_cpuclock(), HZ, 0);
-
-	tc = __raw_readl(SYS_TC(TIMER_CLOCKEVENT));
-	REGSET(tc, SYS_TCx, TEN, DIS);
-	REGSET(tc, SYS_TCx, TDBG, STOP);
-	REGSET(tc, SYS_TCx, TLCS, CPU);
-	REGSET(tc, SYS_TCx, TM, IEE);
-	REGSET(tc, SYS_TCx, INTS, DIS);
-	REGSET(tc, SYS_TCx, UDS, DOWN);
-	REGSET(tc, SYS_TCx, TSZ, 32);
-	REGSET(tc, SYS_TCx, REN, EN);
-	__raw_writel(tc, SYS_TC(TIMER_CLOCKEVENT));
-
-	ns9360_clockevent_device.mult = div_sc(ns9360_cpuclock(),
-			NSEC_PER_SEC, ns9360_clockevent_device.shift);
-	ns9360_clockevent_device.max_delta_ns =
-		clockevent_delta2ns(-1, &ns9360_clockevent_device);
-	ns9360_clockevent_device.min_delta_ns =
-		clockevent_delta2ns(1, &ns9360_clockevent_device);
-
-	ns9360_clockevent_device.cpumask = cpumask_of(0);
-	clockevents_register_device(&ns9360_clockevent_device);
-
-	setup_irq(IRQ_NS9360_TIMER0 + TIMER_CLOCKEVENT,
-			&ns9360_clockevent_action);
-}
-
-struct sys_timer ns9360_timer = {
-	.init = ns9360_timer_init,
-};
-- 
1.7.2.3
