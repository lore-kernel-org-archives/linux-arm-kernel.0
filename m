From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 20 May 2011 09:59:25 +0200
Subject: [PATCH 9/9] ARM i.MX3: remove now useless ipu platform data from
	boards
In-Reply-To: <1305878365-827-1-git-send-email-s.hauer@pengutronix.de>
References: <1305878365-827-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1305878365-827-11-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ipu now uses dynamically allocated irqs, thus we do not need
the platform data anymore. Also, remove the temporary irq_alloc_descs
in the i.MX platform code.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c |    6 +-----
 arch/arm/mach-imx/mach-armadillo5x0.c          |    6 +-----
 arch/arm/mach-imx/mach-mx31_3ds.c              |    6 +-----
 arch/arm/mach-imx/mach-mx31moboard.c           |    6 +-----
 arch/arm/mach-imx/mach-pcm037.c                |    6 +-----
 arch/arm/mach-imx/mach-pcm043.c                |    6 +-----
 arch/arm/mach-imx/mach-vpr200.c                |    6 +-----
 arch/arm/mach-imx/mm-imx31.c                   |    6 ------
 arch/arm/mach-imx/mm-imx35.c                   |    6 ------
 arch/arm/mach-imx/mx31lilly-db.c               |    6 +-----
 arch/arm/plat-mxc/include/mach/ipu.h           |    1 -
 arch/arm/plat-mxc/include/mach/irqs.h          |    3 ---
 12 files changed, 8 insertions(+), 56 deletions(-)

diff --git a/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
index 4909ea0..260a8bc 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
@@ -95,10 +95,6 @@ static const struct fb_videomode fb_modedb[] = {
 	},
 };
 
-static const struct ipu_platform_data mx3_ipu_data __initconst = {
-	.irq_base = MXC_IPU_IRQ_START,
-};
-
 static struct mx3fb_platform_data mx3fb_pdata __initdata = {
 	.name		= "CMO-QVGA",
 	.mode		= fb_modedb,
@@ -276,7 +272,7 @@ void __init eukrea_mbimxsd35_baseboard_init(void)
 #endif
 
 	imx35_add_imx_uart1(&uart_pdata);
-	imx35_add_ipu_core(&mx3_ipu_data);
+	imx35_add_ipu_core(NULL);
 	imx35_add_mx3_sdc_fb(&mx3fb_pdata);
 
 	imx35_add_imx_ssi(0, &eukrea_mbimxsd_ssi_pdata);
diff --git a/arch/arm/mach-imx/mach-armadillo5x0.c b/arch/arm/mach-imx/mach-armadillo5x0.c
index ffb40ff..00eebeb 100644
--- a/arch/arm/mach-imx/mach-armadillo5x0.c
+++ b/arch/arm/mach-imx/mach-armadillo5x0.c
@@ -371,10 +371,6 @@ static const struct fb_videomode fb_modedb[] = {
 	},
 };
 
-static const struct ipu_platform_data mx3_ipu_data __initconst = {
-	.irq_base = MXC_IPU_IRQ_START,
-};
-
 static struct mx3fb_platform_data mx3fb_pdata __initdata = {
 	.name		= "CRT-VGA",
 	.mode		= fb_modedb,
@@ -508,7 +504,7 @@ static void __init armadillo5x0_init(void)
 	imx31_add_mxc_mmc(0, &sdhc_pdata);
 
 	/* Register FB */
-	imx31_add_ipu_core(&mx3_ipu_data);
+	imx31_add_ipu_core(NULL);
 	imx31_add_mx3_sdc_fb(&mx3fb_pdata);
 
 	/* Register NOR Flash */
diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index 9b98244..3b1b374 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -273,10 +273,6 @@ static const struct fb_videomode fb_modedb[] = {
 	},
 };
 
-static struct ipu_platform_data mx3_ipu_data = {
-	.irq_base = MXC_IPU_IRQ_START,
-};
-
 static struct mx3fb_platform_data mx3fb_pdata __initdata = {
 	.name		= "Epson-VGA",
 	.mode		= fb_modedb,
@@ -726,7 +722,7 @@ static void __init mx31_3ds_init(void)
 	imx31_add_mxc_mmc(0, &sdhc1_pdata);
 
 	imx31_add_spi_imx0(&spi0_pdata);
-	imx31_add_ipu_core(&mx3_ipu_data);
+	imx31_add_ipu_core(NULL);
 	imx31_add_mx3_sdc_fb(&mx3fb_pdata);
 
 	/* CSI */
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index eaa51e4..18e97d7 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -455,10 +455,6 @@ static struct platform_device mx31moboard_leds_device = {
 	},
 };
 
-static const struct ipu_platform_data mx3_ipu_data __initconst = {
-	.irq_base = MXC_IPU_IRQ_START,
-};
-
 static struct platform_device *devices[] __initdata = {
 	&mx31moboard_flash,
 	&mx31moboard_leds_device,
@@ -477,7 +473,7 @@ static int __init mx31moboard_init_cam(void)
 	int dma, ret = -ENOMEM;
 	struct platform_device *pdev;
 
-	imx31_add_ipu_core(&mx3_ipu_data);
+	imx31_add_ipu_core(NULL);
 
 	pdev = imx31_alloc_mx3_camera(&camera_pdata);
 	if (IS_ERR(pdev))
diff --git a/arch/arm/mach-imx/mach-pcm037.c b/arch/arm/mach-imx/mach-pcm037.c
index 89c213b..2789fd1 100644
--- a/arch/arm/mach-imx/mach-pcm037.c
+++ b/arch/arm/mach-imx/mach-pcm037.c
@@ -439,10 +439,6 @@ static struct platform_device *devices[] __initdata = {
 	&pcm037_mt9v022,
 };
 
-static const struct ipu_platform_data mx3_ipu_data __initconst = {
-	.irq_base = MXC_IPU_IRQ_START,
-};
-
 static const struct fb_videomode fb_modedb[] = {
 	{
 		/* 240x320 @ 60 Hz Sharp */
@@ -634,7 +630,7 @@ static void __init pcm037_init(void)
 
 	imx31_add_mxc_nand(&pcm037_nand_board_info);
 	imx31_add_mxc_mmc(0, &sdhc_pdata);
-	imx31_add_ipu_core(&mx3_ipu_data);
+	imx31_add_ipu_core(NULL);
 	imx31_add_mx3_sdc_fb(&mx3fb_pdata);
 
 	/* CSI */
diff --git a/arch/arm/mach-imx/mach-pcm043.c b/arch/arm/mach-imx/mach-pcm043.c
index 0264416..1820a95b 100644
--- a/arch/arm/mach-imx/mach-pcm043.c
+++ b/arch/arm/mach-imx/mach-pcm043.c
@@ -77,10 +77,6 @@ static const struct fb_videomode fb_modedb[] = {
 	},
 };
 
-static const struct ipu_platform_data mx3_ipu_data __initconst = {
-	.irq_base = MXC_IPU_IRQ_START,
-};
-
 static struct mx3fb_platform_data mx3fb_pdata __initdata = {
 	.name		= "Sharp-LQ035Q7",
 	.mode		= fb_modedb,
@@ -385,7 +381,7 @@ static void __init pcm043_init(void)
 
 	imx35_add_imx_i2c0(&pcm043_i2c0_data);
 
-	imx35_add_ipu_core(&mx3_ipu_data);
+	imx35_add_ipu_core(NULL);
 	imx35_add_mx3_sdc_fb(&mx3fb_pdata);
 
 	if (otg_mode_host) {
diff --git a/arch/arm/mach-imx/mach-vpr200.c b/arch/arm/mach-imx/mach-vpr200.c
index d74e347..190a19e 100644
--- a/arch/arm/mach-imx/mach-vpr200.c
+++ b/arch/arm/mach-imx/mach-vpr200.c
@@ -87,10 +87,6 @@ static const struct fb_videomode fb_modedb[] = {
 	}
 };
 
-static const struct ipu_platform_data mx3_ipu_data __initconst = {
-	.irq_base = MXC_IPU_IRQ_START,
-};
-
 static struct mx3fb_platform_data mx3fb_pdata __initdata = {
 	.name		= "PT0708048",
 	.mode		= fb_modedb,
@@ -288,7 +284,7 @@ static void __init vpr200_board_init(void)
 	imx35_add_imx_uart0(NULL);
 	imx35_add_imx_uart2(NULL);
 
-	imx35_add_ipu_core(&mx3_ipu_data);
+	imx35_add_ipu_core(NULL);
 	imx35_add_mx3_sdc_fb(&mx3fb_pdata);
 
 	imx35_add_fsl_usb2_udc(&otg_device_pdata);
diff --git a/arch/arm/mach-imx/mm-imx31.c b/arch/arm/mach-imx/mm-imx31.c
index e055ef0..af0a982 100644
--- a/arch/arm/mach-imx/mm-imx31.c
+++ b/arch/arm/mach-imx/mm-imx31.c
@@ -61,12 +61,6 @@ static struct mxc_gpio_port imx31_gpio_ports[] = {
 
 void __init mx31_init_irq(void)
 {
-	int ret;
-
 	mxc_init_irq(MX31_IO_ADDRESS(MX31_AVIC_BASE_ADDR));
 	mxc_gpio_init(imx31_gpio_ports,	ARRAY_SIZE(imx31_gpio_ports));
-
-	/* The ipu driver should handle this */
-	ret = irq_alloc_descs(MXC_IPU_IRQ_START, MXC_IPU_IRQ_START, 160, 0);
-	BUG_ON(ret != MXC_IPU_IRQ_START);
 }
diff --git a/arch/arm/mach-imx/mm-imx35.c b/arch/arm/mach-imx/mm-imx35.c
index abe908b..d10bff5 100644
--- a/arch/arm/mach-imx/mm-imx35.c
+++ b/arch/arm/mach-imx/mm-imx35.c
@@ -59,12 +59,6 @@ static struct mxc_gpio_port imx35_gpio_ports[] = {
 
 void __init mx35_init_irq(void)
 {
-	int ret;
-
 	mxc_init_irq(MX35_IO_ADDRESS(MX35_AVIC_BASE_ADDR));
 	mxc_gpio_init(imx35_gpio_ports,	ARRAY_SIZE(imx35_gpio_ports));
-
-	/* The ipu driver should handle this */
-	ret = irq_alloc_descs(MXC_IPU_IRQ_START, MXC_IPU_IRQ_START, 160, 0);
-	BUG_ON(ret != MXC_IPU_IRQ_START);
 }
diff --git a/arch/arm/mach-imx/mx31lilly-db.c b/arch/arm/mach-imx/mx31lilly-db.c
index 7d26f76..dc0fc9b 100644
--- a/arch/arm/mach-imx/mx31lilly-db.c
+++ b/arch/arm/mach-imx/mx31lilly-db.c
@@ -161,10 +161,6 @@ static const struct imxmmc_platform_data mmc_pdata __initconst = {
 };
 
 /* Framebuffer support */
-static const struct ipu_platform_data ipu_data __initconst = {
-	.irq_base = MXC_IPU_IRQ_START,
-};
-
 static const struct fb_videomode fb_modedb = {
 	/* 640x480 TFT panel (IPS-056T) */
 	.name		= "CRT-VGA",
@@ -198,7 +194,7 @@ static void __init mx31lilly_init_fb(void)
 		return;
 	}
 
-	imx31_add_ipu_core(&ipu_data);
+	imx31_add_ipu_core(NULL);
 	imx31_add_mx3_sdc_fb(&fb_pdata);
 	gpio_direction_output(LCD_VCC_EN_GPIO, 1);
 }
diff --git a/arch/arm/plat-mxc/include/mach/ipu.h b/arch/arm/plat-mxc/include/mach/ipu.h
index a9221f1..0b38d13 100644
--- a/arch/arm/plat-mxc/include/mach/ipu.h
+++ b/arch/arm/plat-mxc/include/mach/ipu.h
@@ -111,7 +111,6 @@ enum ipu_rotate_mode {
 };
 
 struct ipu_platform_data {
-	unsigned int	irq_base;
 };
 
 /*
diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
index 8253463..c281cf0 100644
--- a/arch/arm/plat-mxc/include/mach/irqs.h
+++ b/arch/arm/plat-mxc/include/mach/irqs.h
@@ -22,9 +22,6 @@
 /* one board (mx31ads) still depends on this. Do not add new dependencies */
 #define MXC_BOARD_IRQ_START	512
 
-/* should go away once the ipu uses dynamically allocated irqs */
-#define MXC_IPU_IRQ_START	1024
-
 /* All irqs dynamically allocated */
 #define NR_IRQS			0
 
-- 
1.7.4.1
