From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Jan 2015 17:13:08 +0100
Subject: [PATCH] [media] s5p-tv: hdmi needs I2C support
Message-ID: <2716097.eq77mxJbgq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building the s5p-tv HDMI support when CONFIG_I2C is disabled
gives us this build error:

s5p-tv/hdmi_drv.c: In function 'hdmi_probe':
s5p-tv/hdmi_drv.c:947:2: error: implicit declaration of function 'i2c_get_adapter' [-Werror=implicit-function-declaration]
  adapter = i2c_get_adapter(pdata->hdmiphy_bus);
  ^

This patch changes the Kconfig description to include I2C
as a dependency for this driver, so it cannot be configured
incorrectly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/media/platform/s5p-tv/Kconfig b/drivers/media/platform/s5p-tv/Kconfig
index 5a1835dd65e8..697aaed42486 100644
--- a/drivers/media/platform/s5p-tv/Kconfig
+++ b/drivers/media/platform/s5p-tv/Kconfig
@@ -20,6 +20,7 @@ if VIDEO_SAMSUNG_S5P_TV
 config VIDEO_SAMSUNG_S5P_HDMI
 	tristate "Samsung HDMI Driver"
 	depends on VIDEO_V4L2
+	depends on I2C
 	depends on VIDEO_SAMSUNG_S5P_TV
 	select VIDEO_SAMSUNG_S5P_HDMIPHY
 	help
