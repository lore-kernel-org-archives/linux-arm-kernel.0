From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:39 +0200
Subject: [PATCH 43/61] ARM: imx: dynamically register imx-i2c devices (imx21)
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-44-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/devices-imx21.h |    3 +++
 arch/arm/mach-imx/devices.c       |    2 +-
 arch/arm/mach-imx/devices.h       |    2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/devices-imx21.h b/arch/arm/mach-imx/devices-imx21.h
index e85dcb1..c6e5f50 100644
--- a/arch/arm/mach-imx/devices-imx21.h
+++ b/arch/arm/mach-imx/devices-imx21.h
@@ -9,5 +9,8 @@
 #include <mach/mx21.h>
 #include <mach/devices-common.h>
 
+#define imx21_add_i2c_imx(pdata)	\
+	imx_add_imx_i2c(0, MX2x_I2C_BASE_ADDR, SZ_4K, MX2x_INT_I2C, pdata)
+
 #define imx21_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand_v1(MX21_NFC_BASE_ADDR, MX21_INT_NANDFC, pdata)
diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index a34ad60..b9f5b69 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -368,6 +368,7 @@ struct platform_device mxc_fec_device = {
 };
 #endif
 
+#ifdef CONFIG_MACH_MX27
 #define DEFINE_IMX_I2C_DEVICE(n, baseaddr, irq)				\
 	static struct resource mxc_i2c_resources ## n[] = {		\
 		{							\
@@ -390,7 +391,6 @@ struct platform_device mxc_fec_device = {
 
 DEFINE_IMX_I2C_DEVICE(0, MX2x_I2C_BASE_ADDR, MX2x_INT_I2C);
 
-#ifdef CONFIG_MACH_MX27
 DEFINE_IMX_I2C_DEVICE(1, MX27_I2C2_BASE_ADDR, MX27_INT_I2C2);
 #endif
 
diff --git a/arch/arm/mach-imx/devices.h b/arch/arm/mach-imx/devices.h
index b4eb8a0..dcaa4f9 100644
--- a/arch/arm/mach-imx/devices.h
+++ b/arch/arm/mach-imx/devices.h
@@ -28,8 +28,8 @@ extern struct platform_device mxc_w1_master_device;
 extern struct platform_device mxc_fb_device;
 extern struct platform_device mxc_fec_device;
 extern struct platform_device mxc_pwm_device;
-extern struct platform_device mxc_i2c_device0;
 #ifdef CONFIG_MACH_MX27
+extern struct platform_device mxc_i2c_device0;
 extern struct platform_device mxc_i2c_device1;
 #endif
 extern struct platform_device mxc_sdhc_device0;
-- 
1.7.1
