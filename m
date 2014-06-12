From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 12 Jun 2014 16:50:15 +0100
Subject: [PATCH 1/2] drm/panel: remove unnecessary dependencies
Message-ID: <E1Wv7GZ-0004SJ-PO@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DRM_PANEL_LD9040 and DRM_PANEL_S6E8AA0 both explicitly depended on
DRM_PANEL && DRM.  This is nonsense for two reasons:

(a) DRM_PANEL already depends on DRM, so DRM_PANEL can not be enabled
without DRM first being enabled.  Hence the && DRM is useless.

(b) These two configs are already beneath a menu which depends on
DRM_PANEL being enabled; these options will not be visible without
DRM_PANEL already being enabled.

Let's just remove this unnecessary verbosity.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/panel/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 4ec874da5668..44aea730b3aa 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -18,14 +18,12 @@ config DRM_PANEL_SIMPLE
 
 config DRM_PANEL_LD9040
 	tristate "LD9040 RGB/SPI panel"
-	depends on DRM && DRM_PANEL
 	depends on OF
 	select SPI
 	select VIDEOMODE_HELPERS
 
 config DRM_PANEL_S6E8AA0
 	tristate "S6E8AA0 DSI video mode panel"
-	depends on DRM && DRM_PANEL
 	depends on OF
 	select DRM_MIPI_DSI
 	select VIDEOMODE_HELPERS
-- 
1.8.3.1
