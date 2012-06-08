From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri,  8 Jun 2012 16:24:40 -0600
Subject: [PATCH RESEND 6/6] drivers/tosa: driver needs I2C and SPI to compile
In-Reply-To: <1339194280-27475-1-git-send-email-mathieu.poirier@linaro.org>
References: <1339194280-27475-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1339194280-27475-7-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

This driver requires both SPI and I2C to build.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/video/backlight/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index fa2b037..2979292 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -88,7 +88,7 @@ config LCD_PLATFORM
 
 config LCD_TOSA
 	tristate "Sharp SL-6000 LCD Driver"
-	depends on SPI && MACH_TOSA
+	depends on I2C && SPI && MACH_TOSA
 	help
 	  If you have an Sharp SL-6000 Zaurus say Y to enable a driver
 	  for its LCD.
-- 
1.7.5.4
