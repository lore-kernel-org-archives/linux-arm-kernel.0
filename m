From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:15 +0200
Subject: [PATCH 19/61] ARM: imx1: rename imx_i2c_device to follow a common
	naming scheme
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-20-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx1/devices.c     |    2 +-
 arch/arm/mach-mx1/devices.h     |    2 +-
 arch/arm/mach-mx1/mach-mx1ads.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx1/devices.c b/arch/arm/mach-mx1/devices.c
index fa3809d..c770aa0 100644
--- a/arch/arm/mach-mx1/devices.c
+++ b/arch/arm/mach-mx1/devices.c
@@ -66,7 +66,7 @@ static struct resource imx_i2c_resources[] = {
 	},
 };
 
-struct platform_device imx_i2c_device = {
+struct platform_device imx_i2c_device0 = {
 	.name           = "imx-i2c",
 	.id             = 0,
 	.resource       = imx_i2c_resources,
diff --git a/arch/arm/mach-mx1/devices.h b/arch/arm/mach-mx1/devices.h
index 899f8d9..851d6df 100644
--- a/arch/arm/mach-mx1/devices.h
+++ b/arch/arm/mach-mx1/devices.h
@@ -1,5 +1,5 @@
 extern struct platform_device imx1_camera_device;
-extern struct platform_device imx_i2c_device;
+extern struct platform_device imx_i2c_device0;
 extern struct platform_device imx_uart1_device;
 extern struct platform_device imx_uart2_device;
 extern struct platform_device imx_rtc_device;
diff --git a/arch/arm/mach-mx1/mach-mx1ads.c b/arch/arm/mach-mx1/mach-mx1ads.c
index 27c8222..16adc61 100644
--- a/arch/arm/mach-mx1/mach-mx1ads.c
+++ b/arch/arm/mach-mx1/mach-mx1ads.c
@@ -131,7 +131,7 @@ static void __init mx1ads_init(void)
 	i2c_register_board_info(0, mx1ads_i2c_devices,
 				ARRAY_SIZE(mx1ads_i2c_devices));
 
-	mxc_register_device(&imx_i2c_device, &mx1ads_i2c_data);
+	mxc_register_device(&imx_i2c_device0, &mx1ads_i2c_data);
 }
 
 static void __init mx1ads_timer_init(void)
-- 
1.7.1
