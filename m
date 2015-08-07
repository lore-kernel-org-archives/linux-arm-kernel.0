From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri,  7 Aug 2015 18:27:34 +0200
Subject: [PATCH 3/4] drm/panel: Add Samsung prefix to panel drivers
In-Reply-To: <1438964855-16989-1-git-send-email-thierry.reding@gmail.com>
References: <1438964855-16989-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1438964855-16989-3-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The likelihood of getting a large number of panel drivers from different
vendors is quite high. Add a prefix to the two existing Samsung panel
drivers to set a guideline for future patch submissions. Using vendor
prefixes consistently should allow a cleaner organization of the tree.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/configs/exynos_defconfig                                 | 2 +-
 arch/arm/configs/multi_v7_defconfig                               | 2 +-
 drivers/gpu/drm/panel/Kconfig                                     | 8 ++++----
 drivers/gpu/drm/panel/Makefile                                    | 4 ++--
 drivers/gpu/drm/panel/{panel-ld9040.c => panel-samsung-ld9040.c}  | 2 +-
 .../gpu/drm/panel/{panel-s6e8aa0.c => panel-samsung-s6e8aa0.c}    | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)
 rename drivers/gpu/drm/panel/{panel-ld9040.c => panel-samsung-ld9040.c} (99%)
 rename drivers/gpu/drm/panel/{panel-s6e8aa0.c => panel-samsung-s6e8aa0.c} (99%)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 099438e19f05..354124c3ed2c 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -132,7 +132,7 @@ CONFIG_DRM_EXYNOS_FIMD=y
 CONFIG_DRM_EXYNOS_DSI=y
 CONFIG_DRM_EXYNOS_HDMI=y
 CONFIG_DRM_PANEL_SIMPLE=y
-CONFIG_DRM_PANEL_S6E8AA0=y
+CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
 CONFIG_FB_SIMPLE=y
 CONFIG_EXYNOS_VIDEO=y
 CONFIG_EXYNOS_MIPI_DSI=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 29be77726ec8..6ba9608798ab 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -446,7 +446,7 @@ CONFIG_DRM_EXYNOS_FIMD=y
 CONFIG_DRM_EXYNOS_HDMI=y
 CONFIG_DRM_RCAR_DU=m
 CONFIG_DRM_TEGRA=y
-CONFIG_DRM_PANEL_S6E8AA0=m
+CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_FB_ARMCLCD=y
 CONFIG_FB_WM8505=y
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 6d64c7bb908b..5be25d9282e3 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -18,13 +18,13 @@ config DRM_PANEL_SIMPLE
 	  that it can be automatically turned off when the panel goes into a
 	  low power state.
 
-config DRM_PANEL_LD9040
-	tristate "LD9040 RGB/SPI panel"
+config DRM_PANEL_SAMSUNG_LD9040
+	tristate "Samsung LD9040 RGB/SPI panel"
 	depends on OF && SPI
 	select VIDEOMODE_HELPERS
 
-config DRM_PANEL_S6E8AA0
-	tristate "S6E8AA0 DSI video mode panel"
+config DRM_PANEL_SAMSUNG_S6E8AA0
+	tristate "Samsung S6E8AA0 DSI video mode panel"
 	depends on OF
 	select DRM_MIPI_DSI
 	select VIDEOMODE_HELPERS
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 4b2a0430804b..8026ce5d18b5 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -1,4 +1,4 @@
 obj-$(CONFIG_DRM_PANEL_SIMPLE) += panel-simple.o
-obj-$(CONFIG_DRM_PANEL_LD9040) += panel-ld9040.o
-obj-$(CONFIG_DRM_PANEL_S6E8AA0) += panel-s6e8aa0.o
+obj-$(CONFIG_DRM_PANEL_SAMSUNG_LD9040) += panel-samsung-ld9040.o
+obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0) += panel-samsung-s6e8aa0.o
 obj-$(CONFIG_DRM_PANEL_SHARP_LQ101R1SX01) += panel-sharp-lq101r1sx01.o
diff --git a/drivers/gpu/drm/panel/panel-ld9040.c b/drivers/gpu/drm/panel/panel-samsung-ld9040.c
similarity index 99%
rename from drivers/gpu/drm/panel/panel-ld9040.c
rename to drivers/gpu/drm/panel/panel-samsung-ld9040.c
index bba3501c5821..fcb827003a8c 100644
--- a/drivers/gpu/drm/panel/panel-ld9040.c
+++ b/drivers/gpu/drm/panel/panel-samsung-ld9040.c
@@ -378,7 +378,7 @@ static struct spi_driver ld9040_driver = {
 	.probe = ld9040_probe,
 	.remove = ld9040_remove,
 	.driver = {
-		.name = "ld9040",
+		.name = "panel-samsung-ld9040",
 		.owner = THIS_MODULE,
 		.of_match_table = ld9040_of_match,
 	},
diff --git a/drivers/gpu/drm/panel/panel-s6e8aa0.c b/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
similarity index 99%
rename from drivers/gpu/drm/panel/panel-s6e8aa0.c
rename to drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
index 9e79bc43b047..6b11e75ff645 100644
--- a/drivers/gpu/drm/panel/panel-s6e8aa0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
@@ -1052,7 +1052,7 @@ static struct mipi_dsi_driver s6e8aa0_driver = {
 	.probe = s6e8aa0_probe,
 	.remove = s6e8aa0_remove,
 	.driver = {
-		.name = "panel_s6e8aa0",
+		.name = "panel-samsung-s6e8aa0",
 		.of_match_table = s6e8aa0_of_match,
 	},
 };
-- 
2.4.5
