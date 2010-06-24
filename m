From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:14 +0200
Subject: [PATCH 18/61] ARM: imx1: rename imx_csi_device to match its .name
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-19-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx1/devices.c |   12 ++++++------
 arch/arm/mach-mx1/devices.h |    2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-mx1/devices.c b/arch/arm/mach-mx1/devices.c
index 860cbb7..fa3809d 100644
--- a/arch/arm/mach-mx1/devices.c
+++ b/arch/arm/mach-mx1/devices.c
@@ -29,7 +29,7 @@
 
 #include "devices.h"
 
-static struct resource imx_csi_resources[] = {
+static struct resource imx1_camera_resources[] = {
 	{
 		.start  = 0x00224000,
 		.end    = 0x00224010,
@@ -41,17 +41,17 @@ static struct resource imx_csi_resources[] = {
 	},
 };
 
-static u64 imx_csi_dmamask = DMA_BIT_MASK(32);
+static u64 imx1_camera_dmamask = DMA_BIT_MASK(32);
 
-struct platform_device imx_csi_device = {
+struct platform_device imx1_camera_device = {
 	.name           = "mx1-camera",
 	.id             = 0, /* This is used to put cameras on this interface */
 	.dev		= {
-		.dma_mask = &imx_csi_dmamask,
+		.dma_mask = &imx1_camera_dmamask,
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
-	.resource       = imx_csi_resources,
-	.num_resources  = ARRAY_SIZE(imx_csi_resources),
+	.resource       = imx1_camera_resources,
+	.num_resources  = ARRAY_SIZE(imx1_camera_resources),
 };
 
 static struct resource imx_i2c_resources[] = {
diff --git a/arch/arm/mach-mx1/devices.h b/arch/arm/mach-mx1/devices.h
index 0da5d7c..899f8d9 100644
--- a/arch/arm/mach-mx1/devices.h
+++ b/arch/arm/mach-mx1/devices.h
@@ -1,4 +1,4 @@
-extern struct platform_device imx_csi_device;
+extern struct platform_device imx1_camera_device;
 extern struct platform_device imx_i2c_device;
 extern struct platform_device imx_uart1_device;
 extern struct platform_device imx_uart2_device;
-- 
1.7.1
