From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Nov 2015 13:59:34 +0100
Subject: [PATCH] [media] davinci: add i2c Kconfig dependencies
Message-ID: <4284996.N31E5Y01de@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the davinci media drivers are using the i2c framework, and
fail to build if that is ever disabled, e.g.:

media/platform/davinci/vpif_display.c: In function 'vpif_probe':
media/platform/davinci/vpif_display.c:1298:14: error: implicit declaration of function 'i2c_get_adapter' [-Werror=implicit-function-declaration]

This adds explicit Kconfig dependencies so we don't see the
driver options if I2C is turned off.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This is a very rare randconfig error, normally I2C is enabled for some reason
already.

diff --git a/drivers/media/platform/davinci/Kconfig b/drivers/media/platform/davinci/Kconfig
index 469e9d28cec0..554e710de487 100644
--- a/drivers/media/platform/davinci/Kconfig
+++ b/drivers/media/platform/davinci/Kconfig
@@ -3,6 +3,7 @@ config VIDEO_DAVINCI_VPIF_DISPLAY
 	depends on VIDEO_V4L2
 	depends on ARCH_DAVINCI || COMPILE_TEST
 	depends on HAS_DMA
+	depends on I2C
 	select VIDEOBUF2_DMA_CONTIG
 	select VIDEO_ADV7343 if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_THS7303 if MEDIA_SUBDRV_AUTOSELECT
@@ -19,6 +20,7 @@ config VIDEO_DAVINCI_VPIF_CAPTURE
 	depends on VIDEO_V4L2
 	depends on ARCH_DAVINCI || COMPILE_TEST
 	depends on HAS_DMA
+	depends on I2C
 	select VIDEOBUF2_DMA_CONTIG
 	help
 	  Enables Davinci VPIF module used for capture devices.
@@ -33,6 +35,7 @@ config VIDEO_DM6446_CCDC
 	depends on VIDEO_V4L2
 	depends on ARCH_DAVINCI || COMPILE_TEST
 	depends on HAS_DMA
+	depends on I2C
 	select VIDEOBUF_DMA_CONTIG
 	help
 	   Enables DaVinci CCD hw module. DaVinci CCDC hw interfaces
@@ -49,6 +52,7 @@ config VIDEO_DM355_CCDC
 	depends on VIDEO_V4L2
 	depends on ARCH_DAVINCI || COMPILE_TEST
 	depends on HAS_DMA
+	depends on I2C
 	select VIDEOBUF_DMA_CONTIG
 	help
 	   Enables DM355 CCD hw module. DM355 CCDC hw interfaces
@@ -64,6 +68,7 @@ config VIDEO_DM365_ISIF
 	tristate "TI DM365 ISIF video capture driver"
 	depends on VIDEO_V4L2 && ARCH_DAVINCI
 	depends on HAS_DMA
+	depends on I2C
 	select VIDEOBUF_DMA_CONTIG
 	help
 	   Enables ISIF hw module. This is the hardware module for
@@ -77,6 +82,7 @@ config VIDEO_DAVINCI_VPBE_DISPLAY
 	tristate "TI DaVinci VPBE V4L2-Display driver"
 	depends on VIDEO_V4L2 && ARCH_DAVINCI
 	depends on HAS_DMA
+	depends on I2C
 	select VIDEOBUF2_DMA_CONTIG
 	help
 	    Enables Davinci VPBE module used for display devices.
