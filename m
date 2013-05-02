From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 May 2013 17:16:11 +0200
Subject: [PATCH, RFC 07/22] drm/tilcd: select BACKLIGHT_LCD_SUPPORT
In-Reply-To: <1367507786-505303-1-git-send-email-arnd@arndb.de>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
Message-ID: <1367507786-505303-8-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dependecies for BACKLIGHT_CLASS_DEVICE are defined a bit
strange, but it seems one has to always select both BACKLIGHT_CLASS_DEVICE
and BACKLIGHT_LCD_SUPPORT to avoid this error:

drivers/gpu/drm/tilcdc/tilcdc_panel.c:396:
 undefined reference to `of_find_backlight_by_node'

Cc: Rob Clark <robdclark@gmail.com>
Cc: dri-devel at lists.freedesktop.org
Cc: Dave Airlie <airlied@redhat.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/tilcdc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tilcdc/Kconfig b/drivers/gpu/drm/tilcdc/Kconfig
index e461e99..7a4d101 100644
--- a/drivers/gpu/drm/tilcdc/Kconfig
+++ b/drivers/gpu/drm/tilcdc/Kconfig
@@ -6,6 +6,7 @@ config DRM_TILCDC
 	select DRM_GEM_CMA_HELPER
 	select VIDEOMODE_HELPERS
 	select BACKLIGHT_CLASS_DEVICE
+	select BACKLIGHT_LCD_SUPPORT
 	help
 	  Choose this option if you have an TI SoC with LCDC display
 	  controller, for example AM33xx in beagle-bone, DA8xx, or
-- 
1.8.1.2
