From: arnd@arndb.de (Arnd Bergmann)
Date: Sun,  2 Oct 2011 16:45:33 +0200
Subject: [PATCH 03/30] video/omap: fix build dependencies
In-Reply-To: <1317566760-25681-1-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Message-ID: <1317566760-25681-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Four of the LCD panel drivers depend on the backlight class,
so add the dependency in Kconfig.
Selecting the BACKLIGHT_CLASS_DEVICE symbol does not generally
work since it has other dependencies.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/Kconfig |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
index 609a280..8e4278c 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -19,13 +19,15 @@ config PANEL_LGPHILIPS_LB035Q02
 config PANEL_SHARP_LS037V7DW01
         tristate "Sharp LS037V7DW01 LCD Panel"
         depends on OMAP2_DSS_DPI
-        select BACKLIGHT_CLASS_DEVICE
+        depends on BACKLIGHT_CLASS_DEVICE
         help
           LCD Panel used in TI's SDP3430 and EVM boards
 
 config PANEL_NEC_NL8048HL11_01B
 	tristate "NEC NL8048HL11-01B Panel"
 	depends on OMAP2_DSS_DPI
+	depends on SPI
+	depends on BACKLIGHT_CLASS_DEVICE
 	help
 		This NEC NL8048HL11-01B panel is TFT LCD
 		used in the Zoom2/3/3630 sdp boards.
@@ -33,6 +35,7 @@ config PANEL_NEC_NL8048HL11_01B
 config PANEL_TAAL
         tristate "Taal DSI Panel"
         depends on OMAP2_DSS_DSI
+        depends on BACKLIGHT_CLASS_DEVICE
         help
           Taal DSI command mode panel from TPO.
 
@@ -45,7 +48,7 @@ config PANEL_TPO_TD043MTEA1
 config PANEL_ACX565AKM
 	tristate "ACX565AKM Panel"
 	depends on OMAP2_DSS_SDI && SPI
-	select BACKLIGHT_CLASS_DEVICE
+	depends on BACKLIGHT_CLASS_DEVICE
 	help
 	  This is the LCD panel used on Nokia N900
 endmenu
-- 
1.7.5.4
