From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 13 Jun 2014 14:06:11 +0100
Subject: [PATCH v3 1/2] drm/panel: consolidate unnecessary explicit
 dependencies
Message-ID: <E1WvRBL-0007qq-2D@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DRM_PANEL_LD9040 and DRM_PANEL_S6E8AA0 both explicitly depended on
DRM_PANEL && DRM, whereas DRM_PANEL_SIMPLE relies upon the dependency
on the menu.

We do not need to use explicit dependencies if we make the menu depend
on DRM_PANEL && DRM - this will implicitly make each entry in the menu
depend on DRM_PANEL && DRM without this needing to be explicitly stated
against every entry.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/panel/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 4ec874da5668..d83958d39f43 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -5,7 +5,7 @@ config DRM_PANEL
 	  Panel registration and lookup framework.
 
 menu "Display Panels"
-	depends on DRM_PANEL
+	depends on DRM && DRM_PANEL
 
 config DRM_PANEL_SIMPLE
 	tristate "support for simple panels"
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
