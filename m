From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 10 Sep 2015 15:42:32 +0200
Subject: [PATCH] ARM: exynos_defconfig: Disable simplefb support
Message-ID: <1441892552-13819-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The simplefb driver allows the kernel to render on a pre-allocated
buffer that's been initialized by firmware before the kernel boots.

This option was enabled to have display working on the Exynos5250
Snow Chromebook by commit da9d0fbf5e9a ("ARM: exynos: defconfig
update") since proper DRM/KMS support did not exist at that time.

But now that the Exynos DRM driver has support for this hardware,
there is no need to have simplefb enabled. In fact, if a user has
a u-boot that injects the simplefb dev node to the FDT before pass
it to the kernel, display won't be properly initialized and only a
blank screen will be shown since there isn't a proper handoff from
the simplefb driver to the Exynos DRM driver.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 arch/arm/configs/exynos_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 62f677f76a0b..20d878c83193 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -139,7 +139,6 @@ CONFIG_DRM_EXYNOS_DSI=y
 CONFIG_DRM_EXYNOS_HDMI=y
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
-CONFIG_FB_SIMPLE=y
 CONFIG_EXYNOS_VIDEO=y
 CONFIG_EXYNOS_MIPI_DSI=y
 CONFIG_LCD_CLASS_DEVICE=y
-- 
2.4.3
