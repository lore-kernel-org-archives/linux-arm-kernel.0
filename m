From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  5 Oct 2017 14:09:39 +0200
Subject: [PATCH] drm/rockchip: add PINCTRL dependency for LVDS
Message-ID: <20171005120957.485433-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new driver fails to build when CONFIG_PINCTRL is disabled:

drivers/gpu/drm/rockchip/rockchip_lvds.c: In function 'rockchip_lvds_grf_config':
drivers/gpu/drm/rockchip/rockchip_lvds.c:229:39: error: dereferencing pointer to incomplete type 'struct dev_pin_info'
   if (lvds->pins && !IS_ERR(lvds->pins->default_state))

This adds the respective Kconfig dependency.

Fixes: 34cc0aa25456 ("drm/rockchip: Add support for Rockchip Soc LVDS")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 0c31f0a27b9c..3c70c6224bd2 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -60,6 +60,7 @@ config ROCKCHIP_INNO_HDMI
 config ROCKCHIP_LVDS
 	bool "Rockchip LVDS support"
 	depends on DRM_ROCKCHIP
+	depends on PINCTRL
 	help
 	  Choose this option to enable support for Rockchip LVDS controllers.
 	  Rockchip rk3288 SoC has LVDS TX Controller can be used, and it
-- 
2.9.0
