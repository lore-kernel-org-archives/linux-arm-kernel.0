From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Tue, 23 Mar 2010 19:45:53 +0100
Subject: [PATCH 0/8] MXC: mach-mx31_3ds: Patch series that enable the
	support for Freescale i.MX31 3-Stack development board.
In-Reply-To: <1269369741.3276.162.camel@realization>
References: <1269369741.3276.162.camel@realization>
Message-ID: <1269369953.3276.164.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From c6d0b6f134ea1d78f782a2057f17315e6fd6b5d1 Mon Sep 17 00:00:00 2001
From: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Date: Tue, 19 Jan 2010 16:43:45 +0100
Subject: [PATCH 1/8] MXC: mach-mx31_3ds: Update variable names over recent mach name modification.

Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
---
 arch/arm/mach-mx3/mach-mx31_3ds.c               |   38 +++++++-------
 arch/arm/plat-mxc/include/mach/board-mx31_3ds.h |   59 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/board-mx31pdk.h  |   59 -----------------------
 3 files changed, 78 insertions(+), 78 deletions(-)
 create mode 100644 arch/arm/plat-mxc/include/mach/board-mx31_3ds.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-mx31pdk.h

diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index b88c18a..4a94c3c 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -31,20 +31,20 @@
 #include <asm/memory.h>
 #include <asm/mach/map.h>
 #include <mach/common.h>
-#include <mach/board-mx31pdk.h>
+#include <mach/board-mx31_3ds.h>
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
 #include "devices.h"
 
 /*!
- * @file mx31pdk.c
+ * @file mx31_3ds.c
  *
  * @brief This file contains the board-specific initialization routines.
  *
  * @ingroup System
  */
 
-static int mx31pdk_pins[] = {
+static int mx31_3ds_pins[] = {
 	/* UART1 */
 	MX31_PIN_CTS1__CTS1,
 	MX31_PIN_RTS1__RTS1,
@@ -95,7 +95,7 @@ static struct platform_device smsc911x_device = {
  * LEDs, switches, interrupts for Ethernet.
  */
 
-static void mx31pdk_expio_irq_handler(uint32_t irq, struct irq_desc *desc)
+static void mx31_3ds_expio_irq_handler(uint32_t irq, struct irq_desc *desc)
 {
 	uint32_t imr_val;
 	uint32_t int_valid;
@@ -163,7 +163,7 @@ static struct irq_chip expio_irq_chip = {
 	.unmask = expio_unmask_irq,
 };
 
-static int __init mx31pdk_init_expio(void)
+static int __init mx31_3ds_init_expio(void)
 {
 	int i;
 	int ret;
@@ -176,7 +176,7 @@ static int __init mx31pdk_init_expio(void)
 		return -ENODEV;
 	}
 
-	pr_info("i.MX31PDK Debug board detected, rev = 0x%04X\n",
+	pr_info("i.MX31 3DS Debug board detected, rev = 0x%04X\n",
 		__raw_readw(CPLD_CODE_VER_REG));
 
 	/*
@@ -201,7 +201,7 @@ static int __init mx31pdk_init_expio(void)
 		set_irq_flags(i, IRQF_VALID);
 	}
 	set_irq_type(EXPIO_PARENT_INT, IRQ_TYPE_LEVEL_LOW);
-	set_irq_chained_handler(EXPIO_PARENT_INT, mx31pdk_expio_irq_handler);
+	set_irq_chained_handler(EXPIO_PARENT_INT, mx31_3ds_expio_irq_handler);
 
 	return 0;
 }
@@ -209,7 +209,7 @@ static int __init mx31pdk_init_expio(void)
 /*
  * This structure defines the MX31 memory map.
  */
-static struct map_desc mx31pdk_io_desc[] __initdata = {
+static struct map_desc mx31_3ds_io_desc[] __initdata = {
 	{
 		.virtual = MX31_CS5_BASE_ADDR_VIRT,
 		.pfn = __phys_to_pfn(MX31_CS5_BASE_ADDR),
@@ -221,10 +221,10 @@ static struct map_desc mx31pdk_io_desc[] __initdata = {
 /*
  * Set up static virtual mappings.
  */
-static void __init mx31pdk_map_io(void)
+static void __init mx31_3ds_map_io(void)
 {
 	mx31_map_io();
-	iotable_init(mx31pdk_io_desc, ARRAY_SIZE(mx31pdk_io_desc));
+	iotable_init(mx31_3ds_io_desc, ARRAY_SIZE(mx31_3ds_io_desc));
 }
 
 /*!
@@ -232,35 +232,35 @@ static void __init mx31pdk_map_io(void)
  */
 static void __init mxc_board_init(void)
 {
-	mxc_iomux_setup_multiple_pins(mx31pdk_pins, ARRAY_SIZE(mx31pdk_pins),
-				      "mx31pdk");
+	mxc_iomux_setup_multiple_pins(mx31_3ds_pins, ARRAY_SIZE(mx31_3ds_pins),
+				      "mx31_3ds");
 
 	mxc_register_device(&mxc_uart_device0, &uart_pdata);
 
-	if (!mx31pdk_init_expio())
+	if (!mx31_3ds_init_expio())
 		platform_device_register(&smsc911x_device);
 }
 
-static void __init mx31pdk_timer_init(void)
+static void __init mx31_3ds_timer_init(void)
 {
 	mx31_clocks_init(26000000);
 }
 
-static struct sys_timer mx31pdk_timer = {
-	.init	= mx31pdk_timer_init,
+static struct sys_timer mx31_3ds_timer = {
+	.init	= mx31_3ds_timer_init,
 };
 
 /*
  * The following uses standard kernel macros defined in arch.h in order to
- * initialize __mach_desc_MX31PDK data structure.
+ * initialize __mach_desc_MX31_3DS data structure.
  */
 MACHINE_START(MX31_3DS, "Freescale MX31PDK (3DS)")
 	/* Maintainer: Freescale Semiconductor, Inc. */
 	.phys_io	= MX31_AIPS1_BASE_ADDR,
 	.io_pg_offst	= (MX31_AIPS1_BASE_ADDR_VIRT >> 18) & 0xfffc,
 	.boot_params    = MX3x_PHYS_OFFSET + 0x100,
-	.map_io         = mx31pdk_map_io,
+	.map_io         = mx31_3ds_map_io,
 	.init_irq       = mx31_init_irq,
 	.init_machine   = mxc_board_init,
-	.timer          = &mx31pdk_timer,
+	.timer          = &mx31_3ds_timer,
 MACHINE_END
diff --git a/arch/arm/plat-mxc/include/mach/board-mx31_3ds.h b/arch/arm/plat-mxc/include/mach/board-mx31_3ds.h
new file mode 100644
index 0000000..da92933
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/board-mx31_3ds.h
@@ -0,0 +1,59 @@
+/*
+ * Copyright 2008 Freescale Semiconductor, Inc. All Rights Reserved.
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_ARCH_MXC_BOARD_MX31_3DS_H__
+#define __ASM_ARCH_MXC_BOARD_MX31_3DS_H__
+
+/* Definitions for components on the Debug board */
+
+/* Base address of CPLD controller on the Debug board */
+#define DEBUG_BASE_ADDRESS		CS5_IO_ADDRESS(CS5_BASE_ADDR)
+
+/* LAN9217 ethernet base address */
+#define LAN9217_BASE_ADDR		CS5_BASE_ADDR
+
+/* CPLD config and interrupt base address */
+#define CPLD_ADDR			(DEBUG_BASE_ADDRESS + 0x20000)
+
+/* LED switchs */
+#define CPLD_LED_REG			(CPLD_ADDR + 0x00)
+/* buttons */
+#define CPLD_SWITCH_BUTTONS_REG	(EXPIO_ADDR + 0x08)
+/* status, interrupt */
+#define CPLD_INT_STATUS_REG		(CPLD_ADDR + 0x10)
+#define CPLD_INT_MASK_REG		(CPLD_ADDR + 0x38)
+#define CPLD_INT_RESET_REG		(CPLD_ADDR + 0x20)
+/* magic word for debug CPLD */
+#define CPLD_MAGIC_NUMBER1_REG		(CPLD_ADDR + 0x40)
+#define CPLD_MAGIC_NUMBER2_REG		(CPLD_ADDR + 0x48)
+/* CPLD code version */
+#define CPLD_CODE_VER_REG		(CPLD_ADDR + 0x50)
+/* magic word for debug CPLD */
+#define CPLD_MAGIC_NUMBER3_REG		(CPLD_ADDR + 0x58)
+/* module reset register */
+#define CPLD_MODULE_RESET_REG		(CPLD_ADDR + 0x60)
+/* CPU ID and Personality ID */
+#define CPLD_MCU_BOARD_ID_REG		(CPLD_ADDR + 0x68)
+
+/* CPLD IRQ line for external uart, external ethernet etc */
+#define EXPIO_PARENT_INT	IOMUX_TO_IRQ(MX31_PIN_GPIO1_1)
+
+#define MXC_EXP_IO_BASE		(MXC_BOARD_IRQ_START)
+#define MXC_IRQ_TO_EXPIO(irq)	((irq) - MXC_EXP_IO_BASE)
+
+#define EXPIO_INT_ENET		(MXC_EXP_IO_BASE + 0)
+#define EXPIO_INT_XUART_A	(MXC_EXP_IO_BASE + 1)
+#define EXPIO_INT_XUART_B	(MXC_EXP_IO_BASE + 2)
+#define EXPIO_INT_BUTTON_A	(MXC_EXP_IO_BASE + 3)
+#define EXPIO_INT_BUTTON_B	(MXC_EXP_IO_BASE + 4)
+
+#define MXC_MAX_EXP_IO_LINES	16
+
+#endif /* __ASM_ARCH_MXC_BOARD_MX31_3DS_H__ */
diff --git a/arch/arm/plat-mxc/include/mach/board-mx31pdk.h b/arch/arm/plat-mxc/include/mach/board-mx31pdk.h
deleted file mode 100644
index 2bbd6ed..0000000
--- a/arch/arm/plat-mxc/include/mach/board-mx31pdk.h
+++ /dev/null
@@ -1,59 +0,0 @@
-/*
- * Copyright 2008 Freescale Semiconductor, Inc. All Rights Reserved.
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_MXC_BOARD_MX31PDK_H__
-#define __ASM_ARCH_MXC_BOARD_MX31PDK_H__
-
-/* Definitions for components on the Debug board */
-
-/* Base address of CPLD controller on the Debug board */
-#define DEBUG_BASE_ADDRESS		CS5_IO_ADDRESS(CS5_BASE_ADDR)
-
-/* LAN9217 ethernet base address */
-#define LAN9217_BASE_ADDR		CS5_BASE_ADDR
-
-/* CPLD config and interrupt base address */
-#define CPLD_ADDR			(DEBUG_BASE_ADDRESS + 0x20000)
-
-/* LED switchs */
-#define CPLD_LED_REG			(CPLD_ADDR + 0x00)
-/* buttons */
-#define CPLD_SWITCH_BUTTONS_REG	(EXPIO_ADDR + 0x08)
-/* status, interrupt */
-#define CPLD_INT_STATUS_REG		(CPLD_ADDR + 0x10)
-#define CPLD_INT_MASK_REG		(CPLD_ADDR + 0x38)
-#define CPLD_INT_RESET_REG		(CPLD_ADDR + 0x20)
-/* magic word for debug CPLD */
-#define CPLD_MAGIC_NUMBER1_REG		(CPLD_ADDR + 0x40)
-#define CPLD_MAGIC_NUMBER2_REG		(CPLD_ADDR + 0x48)
-/* CPLD code version */
-#define CPLD_CODE_VER_REG		(CPLD_ADDR + 0x50)
-/* magic word for debug CPLD */
-#define CPLD_MAGIC_NUMBER3_REG		(CPLD_ADDR + 0x58)
-/* module reset register */
-#define CPLD_MODULE_RESET_REG		(CPLD_ADDR + 0x60)
-/* CPU ID and Personality ID */
-#define CPLD_MCU_BOARD_ID_REG		(CPLD_ADDR + 0x68)
-
-/* CPLD IRQ line for external uart, external ethernet etc */
-#define EXPIO_PARENT_INT	IOMUX_TO_IRQ(MX31_PIN_GPIO1_1)
-
-#define MXC_EXP_IO_BASE		(MXC_BOARD_IRQ_START)
-#define MXC_IRQ_TO_EXPIO(irq)	((irq) - MXC_EXP_IO_BASE)
-
-#define EXPIO_INT_ENET		(MXC_EXP_IO_BASE + 0)
-#define EXPIO_INT_XUART_A	(MXC_EXP_IO_BASE + 1)
-#define EXPIO_INT_XUART_B	(MXC_EXP_IO_BASE + 2)
-#define EXPIO_INT_BUTTON_A	(MXC_EXP_IO_BASE + 3)
-#define EXPIO_INT_BUTTON_B	(MXC_EXP_IO_BASE + 4)
-
-#define MXC_MAX_EXP_IO_LINES	16
-
-#endif /* __ASM_ARCH_MXC_BOARD_MX31PDK_H__ */
-- 
1.6.3.3
