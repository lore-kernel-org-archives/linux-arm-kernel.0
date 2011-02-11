From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 11 Feb 2011 10:21:08 +0100
Subject: [PATCH 2/3] ARM: mx3: remove some useless comments
In-Reply-To: <20110211081050.GD27982@pengutronix.de>
References: <20110211081050.GD27982@pengutronix.de>
Message-ID: <1297416069-6861-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/mach-mx31_3ds.c |    8 --------
 arch/arm/mach-mx3/mach-mx31ads.c  |   14 +-------------
 arch/arm/mach-mx3/mach-qong.c     |    9 ---------
 arch/arm/mach-mx3/mm.c            |    9 ---------
 4 files changed, 1 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 1360fe4..817a275 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -42,10 +42,6 @@
 /* CPLD IRQ line for external uart, external ethernet etc */
 #define EXPIO_PARENT_INT	IOMUX_TO_IRQ(MX31_PIN_GPIO1_1)
 
-/*
- * This file contains the board-specific initialization routines.
- */
-
 static int mx31_3ds_pins[] = {
 	/* UART1 */
 	MX31_PIN_CTS1__CTS1,
@@ -364,10 +360,6 @@ static struct sys_timer mx31_3ds_timer = {
 	.init	= mx31_3ds_timer_init,
 };
 
-/*
- * The following uses standard kernel macros defined in arch.h in order to
- * initialize __mach_desc_MX31_3DS data structure.
- */
 MACHINE_START(MX31_3DS, "Freescale MX31PDK (3DS)")
 	/* Maintainer: Freescale Semiconductor, Inc. */
 	.boot_params = MX3x_PHYS_OFFSET + 0x100,
diff --git a/arch/arm/mach-mx3/mach-mx31ads.c b/arch/arm/mach-mx3/mach-mx31ads.c
index cb80b96..14e7671 100644
--- a/arch/arm/mach-mx3/mach-mx31ads.c
+++ b/arch/arm/mach-mx3/mach-mx31ads.c
@@ -69,9 +69,6 @@
 #define EXPIO_INT_XUART_INTB	(MXC_EXP_IO_BASE + 11)
 
 #define MXC_MAX_EXP_IO_LINES	16
-/*
- * This file contains the board-specific initialization routines.
- */
 
 /*
  * The serial port definition structure.
@@ -497,9 +494,7 @@ static void mxc_init_audio(void)
 	mxc_iomux_setup_multiple_pins(ssi_pins, ARRAY_SIZE(ssi_pins), "ssi");
 }
 
-/*!
- * This structure defines static mappings for the i.MX31ADS board.
- */
+/* static mappings */
 static struct map_desc mx31ads_io_desc[] __initdata = {
 	{
 		.virtual	= MX31_CS4_BASE_ADDR_VIRT,
@@ -509,9 +504,6 @@ static struct map_desc mx31ads_io_desc[] __initdata = {
 	},
 };
 
-/*!
- * Set up static virtual mappings.
- */
 static void __init mx31ads_map_io(void)
 {
 	mx31_map_io();
@@ -541,10 +533,6 @@ static struct sys_timer mx31ads_timer = {
 	.init	= mx31ads_timer_init,
 };
 
-/*
- * The following uses standard kernel macros defined in arch.h in order to
- * initialize __mach_desc_MX31ADS data structure.
- */
 MACHINE_START(MX31ADS, "Freescale MX31ADS")
 	/* Maintainer: Freescale Semiconductor, Inc. */
 	.boot_params = MX3x_PHYS_OFFSET + 0x100,
diff --git a/arch/arm/mach-mx3/mach-qong.c b/arch/arm/mach-mx3/mach-qong.c
index 0028163..17f758b 100644
--- a/arch/arm/mach-mx3/mach-qong.c
+++ b/arch/arm/mach-mx3/mach-qong.c
@@ -54,10 +54,6 @@
 
 #define QONG_FPGA_IRQ		IOMUX_TO_IRQ(MX31_PIN_DTR_DCE1)
 
-/*
- * This file contains the board-specific initialization routines.
- */
-
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
@@ -263,11 +259,6 @@ static struct sys_timer qong_timer = {
 	.init	= qong_timer_init,
 };
 
-/*
- * The following uses standard kernel macros defined in arch.h in order to
- * initialize __mach_desc_QONG data structure.
- */
-
 MACHINE_START(QONG, "Dave/DENX QongEVB-LITE")
 	/* Maintainer: DENX Software Engineering GmbH */
 	.boot_params = MX3x_PHYS_OFFSET + 0x100,
diff --git a/arch/arm/mach-mx3/mm.c b/arch/arm/mach-mx3/mm.c
index 3387319..eefd4cf 100644
--- a/arch/arm/mach-mx3/mm.c
+++ b/arch/arm/mach-mx3/mm.c
@@ -28,14 +28,6 @@
 #include <mach/hardware.h>
 #include <mach/iomux-v3.h>
 
-/*!
- * @file mm.c
- *
- * @brief This file creates static virtual to physical mappings, common to all MX3 boards.
- *
- * @ingroup Memory
- */
-
 #ifdef CONFIG_SOC_IMX31
 static struct map_desc mx31_io_desc[] __initdata = {
 	imx_map_entry(MX31, X_MEMC, MT_DEVICE),
@@ -135,4 +127,3 @@ static int mxc_init_l2x0(void)
 
 arch_initcall(mxc_init_l2x0);
 #endif
-
-- 
1.7.2.3
