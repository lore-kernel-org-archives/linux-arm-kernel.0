From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:50:53 +0200
Subject: [PATCH 17/40] ARM: imx: fix name of macros to add imx-i2c devices
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-17-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a follow up to

	c698715 (ARM: imx: dynamically register imx-i2c devices (imx27))
	2b92084 (ARM: imx: dynamically register imx-i2c devices (imx21))
	6348e6b (ARM: imx: dynamically register imx-i2c devices (imx1))

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/devices-imx1.h            |    2 +-
 arch/arm/mach-imx/devices-imx21.h           |    2 +-
 arch/arm/mach-imx/devices-imx27.h           |    2 --
 arch/arm/mach-imx/mach-cpuimx27.c           |    2 +-
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |    4 ++--
 arch/arm/mach-imx/mach-mx1ads.c             |    2 +-
 arch/arm/mach-imx/mach-mx27ads.c            |    2 +-
 arch/arm/mach-imx/mach-mxt_td60.c           |    4 ++--
 arch/arm/mach-imx/mach-pca100.c             |    2 +-
 arch/arm/mach-imx/mach-pcm038.c             |    2 +-
 10 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-imx/devices-imx1.h b/arch/arm/mach-imx/devices-imx1.h
index 6cf0864..8197948 100644
--- a/arch/arm/mach-imx/devices-imx1.h
+++ b/arch/arm/mach-imx/devices-imx1.h
@@ -10,7 +10,7 @@
 #include <mach/devices-common.h>
 
 extern const struct imx_imx_i2c_data imx1_imx_i2c_data __initconst;
-#define imx1_add_i2c_imx(pdata)		\
+#define imx1_add_imx_i2c(pdata)		\
 	imx_add_imx_i2c(&imx1_imx_i2c_data, pdata)
 
 extern const struct imx_imx_uart_3irq_data imx1_imx_uart_data[] __initconst;
diff --git a/arch/arm/mach-imx/devices-imx21.h b/arch/arm/mach-imx/devices-imx21.h
index d3d2b26..4795d70 100644
--- a/arch/arm/mach-imx/devices-imx21.h
+++ b/arch/arm/mach-imx/devices-imx21.h
@@ -10,7 +10,7 @@
 #include <mach/devices-common.h>
 
 extern const struct imx_imx_i2c_data imx21_imx_i2c_data __initconst;
-#define imx21_add_i2c_imx(pdata)	\
+#define imx21_add_imx_i2c(pdata)	\
 	imx_add_imx_i2c(&imx21_imx_i2c_data, pdata)
 
 extern const struct imx_imx_ssi_data imx21_imx_ssi_data[] __initconst;
diff --git a/arch/arm/mach-imx/devices-imx27.h b/arch/arm/mach-imx/devices-imx27.h
index 193dfb5..1765521 100644
--- a/arch/arm/mach-imx/devices-imx27.h
+++ b/arch/arm/mach-imx/devices-imx27.h
@@ -12,8 +12,6 @@
 extern const struct imx_imx_i2c_data imx27_imx_i2c_data[] __initconst;
 #define imx27_add_imx_i2c(id, pdata)	\
 	imx_add_imx_i2c(&imx27_imx_i2c_data[id], pdata)
-#define imx27_add_i2c_imx0(pdata)	imx27_add_imx_i2c(0, pdata)
-#define imx27_add_i2c_imx1(pdata)	imx27_add_imx_i2c(1, pdata)
 
 extern const struct imx_imx_ssi_data imx27_imx_ssi_data[] __initconst;
 #define imx27_add_imx_ssi(id, pdata)    \
diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index 339150a..f00ddd9 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -259,7 +259,7 @@ static void __init eukrea_cpuimx27_init(void)
 	i2c_register_board_info(0, eukrea_cpuimx27_i2c_devices,
 				ARRAY_SIZE(eukrea_cpuimx27_i2c_devices));
 
-	imx27_add_i2c_imx1(&cpuimx27_i2c1_data);
+	imx27_add_imx_i2c(1, &cpuimx27_i2c1_data);
 
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 6dad632..7b3eed0 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -236,8 +236,8 @@ static void __init visstrim_m10_board_init(void)
 
 	i2c_register_board_info(0, visstrim_m10_i2c_devices,
 				ARRAY_SIZE(visstrim_m10_i2c_devices));
-	imx27_add_i2c_imx0(&visstrim_m10_i2c_data);
-	imx27_add_i2c_imx1(&visstrim_m10_i2c_data);
+	imx27_add_imx_i2c(0, &visstrim_m10_i2c_data);
+	imx27_add_imx_i2c(1, &visstrim_m10_i2c_data);
 	mxc_register_device(&mxc_sdhc_device0, &visstrim_m10_sdhc_pdata);
 	mxc_register_device(&mxc_otg_host, &visstrim_m10_usbotg_pdata);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
diff --git a/arch/arm/mach-imx/mach-mx1ads.c b/arch/arm/mach-imx/mach-mx1ads.c
index 77a760c..6e2f249 100644
--- a/arch/arm/mach-imx/mach-mx1ads.c
+++ b/arch/arm/mach-imx/mach-mx1ads.c
@@ -131,7 +131,7 @@ static void __init mx1ads_init(void)
 	i2c_register_board_info(0, mx1ads_i2c_devices,
 				ARRAY_SIZE(mx1ads_i2c_devices));
 
-	imx1_add_i2c_imx(&mx1ads_i2c_data);
+	imx1_add_imx_i2c(&mx1ads_i2c_data);
 }
 
 static void __init mx1ads_timer_init(void)
diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index 9c77da9..6be6033 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -308,7 +308,7 @@ static void __init mx27ads_board_init(void)
 	/* only the i2c master 1 is used on this CPU card */
 	i2c_register_board_info(1, mx27ads_i2c_devices,
 				ARRAY_SIZE(mx27ads_i2c_devices));
-	imx27_add_i2c_imx1(&mx27ads_i2c1_data);
+	imx27_add_imx_i2c(1, &mx27ads_i2c1_data);
 	mxc_register_device(&mxc_fb_device, &mx27ads_fb_data);
 	mxc_register_device(&mxc_sdhc_device0, &sdhc1_pdata);
 	mxc_register_device(&mxc_sdhc_device1, &sdhc2_pdata);
diff --git a/arch/arm/mach-imx/mach-mxt_td60.c b/arch/arm/mach-imx/mach-mxt_td60.c
index a3a1e45..d878bb9 100644
--- a/arch/arm/mach-imx/mach-mxt_td60.c
+++ b/arch/arm/mach-imx/mach-mxt_td60.c
@@ -255,8 +255,8 @@ static void __init mxt_td60_board_init(void)
 	i2c_register_board_info(1, mxt_td60_i2c2_devices,
 				ARRAY_SIZE(mxt_td60_i2c2_devices));
 
-	imx27_add_i2c_imx0(&mxt_td60_i2c0_data);
-	imx27_add_i2c_imx1(&mxt_td60_i2c1_data);
+	imx27_add_imx_i2c(0, &mxt_td60_i2c0_data);
+	imx27_add_imx_i2c(1, &mxt_td60_i2c1_data);
 	mxc_register_device(&mxc_fb_device, &mxt_td60_fb_data);
 	mxc_register_device(&mxc_sdhc_device0, &sdhc1_pdata);
 
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index 93e0d66..cccf521 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -400,7 +400,7 @@ static void __init pca100_init(void)
 	i2c_register_board_info(1, pca100_i2c_devices,
 				ARRAY_SIZE(pca100_i2c_devices));
 
-	imx27_add_i2c_imx1(&pca100_i2c1_data);
+	imx27_add_imx_i2c(1, &pca100_i2c1_data);
 
 #if defined(CONFIG_SPI_IMX) || defined(CONFIG_SPI_IMX_MODULE)
 	mxc_gpio_mode(GPIO_PORTD | 28 | GPIO_GPIO | GPIO_IN);
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index 9212e8f..641f9bb 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -309,7 +309,7 @@ static void __init pcm038_init(void)
 	i2c_register_board_info(1, pcm038_i2c_devices,
 				ARRAY_SIZE(pcm038_i2c_devices));
 
-	imx27_add_i2c_imx1(&pcm038_i2c1_data);
+	imx27_add_imx_i2c(1, &pcm038_i2c1_data);
 
 	/* PE18 for user-LED D40 */
 	mxc_gpio_mode(GPIO_PORTE | 18 | GPIO_GPIO | GPIO_OUT);
-- 
1.7.2.3
