From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:01 +0100
Subject: [PATCH 06/39] arm/mx2/devices: use SoC-prefixed names where possible
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-6-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is only NFC_BASE_ADDR left which is defined differently for mx21
and mx27.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx2/devices.c |  110 +++++++++++++++++++++---------------------
 1 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/arch/arm/mach-mx2/devices.c b/arch/arm/mach-mx2/devices.c
index bed0fdb..9bf49da 100644
--- a/arch/arm/mach-mx2/devices.c
+++ b/arch/arm/mach-mx2/devices.c
@@ -116,9 +116,9 @@ DEFINE_IMX_GPT_DEVICE(5, MX27_GPT6_BASE_ADDR, MX27_INT_GPT6);
  */
 static struct resource mxc_wdt_resources[] = {
 	{
-		.start	= WDOG_BASE_ADDR,
-		.end	= WDOG_BASE_ADDR + 0x30,
-		.flags	= IORESOURCE_MEM,
+		.start = MX2x_WDOG_BASE_ADDR,
+		.end = MX2x_WDOG_BASE_ADDR + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
 	},
 };
 
@@ -131,8 +131,8 @@ struct platform_device mxc_wdt = {
 
 static struct resource mxc_w1_master_resources[] = {
 	{
-		.start = OWIRE_BASE_ADDR,
-		.end   = OWIRE_BASE_ADDR + SZ_4K - 1,
+		.start = MX2x_OWIRE_BASE_ADDR,
+		.end = MX2x_OWIRE_BASE_ADDR + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
 	},
 };
@@ -146,13 +146,13 @@ struct platform_device mxc_w1_master_device = {
 
 static struct resource mxc_nand_resources[] = {
 	{
-		.start	= NFC_BASE_ADDR,
-		.end	= NFC_BASE_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM,
+		.start = NFC_BASE_ADDR,
+		.end = NFC_BASE_ADDR + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
 	}, {
-		.start	= MXC_INT_NANDFC,
-		.end	= MXC_INT_NANDFC,
-		.flags	= IORESOURCE_IRQ,
+		.start = MX2x_INT_NANDFC,
+		.end = MX2x_INT_NANDFC,
+		.flags = IORESOURCE_IRQ,
 	},
 };
 
@@ -171,12 +171,12 @@ struct platform_device mxc_nand_device = {
  */
 static struct resource mxc_fb[] = {
 	{
-		.start = LCDC_BASE_ADDR,
-		.end   = LCDC_BASE_ADDR + 0xFFF,
+		.start = MX2x_LCDC_BASE_ADDR,
+		.end = MX2x_LCDC_BASE_ADDR + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
 	}, {
-		.start = MXC_INT_LCDC,
-		.end   = MXC_INT_LCDC,
+		.start = MX2x_INT_LCDC,
+		.end = MX2x_INT_LCDC,
 		.flags = IORESOURCE_IRQ,
 	}
 };
@@ -195,13 +195,13 @@ struct platform_device mxc_fb_device = {
 #ifdef CONFIG_MACH_MX27
 static struct resource mxc_fec_resources[] = {
 	{
-		.start	= FEC_BASE_ADDR,
-		.end	= FEC_BASE_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM,
+		.start = MX27_FEC_BASE_ADDR,
+		.end = MX27_FEC_BASE_ADDR + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
 	}, {
-		.start	= MXC_INT_FEC,
-		.end	= MXC_INT_FEC,
-		.flags	= IORESOURCE_IRQ,
+		.start = MX27_INT_FEC,
+		.end = MX27_INT_FEC,
+		.flags = IORESOURCE_IRQ,
 	},
 };
 
@@ -241,13 +241,13 @@ DEFINE_IMX_I2C_DEVICE(1, MX27_I2C2_BASE_ADDR, MX27_INT_I2C2);
 
 static struct resource mxc_pwm_resources[] = {
 	{
-		.start	= PWM_BASE_ADDR,
-		.end	= PWM_BASE_ADDR + 0x0fff,
-		.flags	= IORESOURCE_MEM,
+		.start = MX2x_PWM_BASE_ADDR,
+		.end = MX2x_PWM_BASE_ADDR + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
 	}, {
-		.start   = MXC_INT_PWM,
-		.end     = MXC_INT_PWM,
-		.flags   = IORESOURCE_IRQ,
+		.start = MX2x_INT_PWM,
+		.end = MX2x_INT_PWM,
+		.flags = IORESOURCE_IRQ,
 	}
 };
 
@@ -297,13 +297,13 @@ DEFINE_MXC_MMC_DEVICE(1, MX2x_SDHC2_BASE_ADDR, MX2x_INT_SDHC2, MX2x_DMA_REQ_SDHC
 #ifdef CONFIG_MACH_MX27
 static struct resource otg_resources[] = {
 	{
-		.start	= OTG_BASE_ADDR,
-		.end	= OTG_BASE_ADDR + 0x1ff,
-		.flags	= IORESOURCE_MEM,
+		.start = MX27_USBOTG_BASE_ADDR,
+		.end = MX27_USBOTG_BASE_ADDR + 0x1ff,
+		.flags = IORESOURCE_MEM,
 	}, {
-		.start	= MXC_INT_USB3,
-		.end	= MXC_INT_USB3,
-		.flags	= IORESOURCE_IRQ,
+		.start = MX27_INT_USB3,
+		.end = MX27_INT_USB3,
+		.flags = IORESOURCE_IRQ,
 	},
 };
 
@@ -311,14 +311,14 @@ static u64 otg_dmamask = 0xffffffffUL;
 
 /* OTG gadget device */
 struct platform_device mxc_otg_udc_device = {
-	.name		= "fsl-usb2-udc",
-	.id		= -1,
-	.dev		= {
-		.dma_mask		= &otg_dmamask,
-		.coherent_dma_mask	= 0xffffffffUL,
+	.name = "fsl-usb2-udc",
+	.id = -1,
+	.dev = {
+		.dma_mask = &otg_dmamask,
+		.coherent_dma_mask = 0xffffffffUL,
 	},
-	.resource	= otg_resources,
-	.num_resources	= ARRAY_SIZE(otg_resources),
+	.resource = otg_resources,
+	.num_resources = ARRAY_SIZE(otg_resources),
 };
 
 /* OTG host */
@@ -339,12 +339,12 @@ static u64 usbh1_dmamask = 0xffffffffUL;
 
 static struct resource mxc_usbh1_resources[] = {
 	{
-		.start = OTG_BASE_ADDR + 0x200,
-		.end = OTG_BASE_ADDR + 0x3ff,
+		.start = MX27_USBOTG_BASE_ADDR + 0x200,
+		.end = MX27_USBOTG_BASE_ADDR + 0x3ff,
 		.flags = IORESOURCE_MEM,
 	}, {
-		.start = MXC_INT_USB1,
-		.end = MXC_INT_USB1,
+		.start = MX27_INT_USB1,
+		.end = MX27_INT_USB1,
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -365,12 +365,12 @@ static u64 usbh2_dmamask = 0xffffffffUL;
 
 static struct resource mxc_usbh2_resources[] = {
 	{
-		.start = OTG_BASE_ADDR + 0x400,
-		.end = OTG_BASE_ADDR + 0x5ff,
+		.start = MX27_USBOTG_BASE_ADDR + 0x400,
+		.end = MX27_USBOTG_BASE_ADDR + 0x5ff,
 		.flags = IORESOURCE_MEM,
 	}, {
-		.start = MXC_INT_USB2,
-		.end = MXC_INT_USB2,
+		.start = MX27_INT_USB2,
+		.end = MX27_INT_USB2,
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -426,28 +426,28 @@ DEFINE_IMX_SSI_DEVICE(1, 2, MX2x_SSI1_BASE_ADDR, MX2x_INT_SSI1);
 static struct mxc_gpio_port imx_gpio_ports[] = {
 	{
 		.chip.label = "gpio-0",
-		.irq = MXC_INT_GPIO,
-		.base = IO_ADDRESS(GPIO_BASE_ADDR),
+		.irq = MX2x_INT_GPIO,
+		.base = IO_ADDRESS(MX2x_GPIO_BASE_ADDR),
 		.virtual_irq_start = MXC_GPIO_IRQ_START,
 	}, {
 		.chip.label = "gpio-1",
-		.base = IO_ADDRESS(GPIO_BASE_ADDR + 0x100),
+		.base = IO_ADDRESS(MX2x_GPIO_BASE_ADDR + 0x100),
 		.virtual_irq_start = MXC_GPIO_IRQ_START + 32,
 	}, {
 		.chip.label = "gpio-2",
-		.base = IO_ADDRESS(GPIO_BASE_ADDR + 0x200),
+		.base = IO_ADDRESS(MX2x_GPIO_BASE_ADDR + 0x200),
 		.virtual_irq_start = MXC_GPIO_IRQ_START + 64,
 	}, {
 		.chip.label = "gpio-3",
-		.base = IO_ADDRESS(GPIO_BASE_ADDR + 0x300),
+		.base = IO_ADDRESS(MX2x_GPIO_BASE_ADDR + 0x300),
 		.virtual_irq_start = MXC_GPIO_IRQ_START + 96,
 	}, {
 		.chip.label = "gpio-4",
-		.base = IO_ADDRESS(GPIO_BASE_ADDR + 0x400),
+		.base = IO_ADDRESS(MX2x_GPIO_BASE_ADDR + 0x400),
 		.virtual_irq_start = MXC_GPIO_IRQ_START + 128,
 	}, {
 		.chip.label = "gpio-5",
-		.base = IO_ADDRESS(GPIO_BASE_ADDR + 0x500),
+		.base = IO_ADDRESS(MX2x_GPIO_BASE_ADDR + 0x500),
 		.virtual_irq_start = MXC_GPIO_IRQ_START + 160,
 	}
 };
-- 
1.6.6.2
