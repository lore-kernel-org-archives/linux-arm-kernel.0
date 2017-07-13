From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Jul 2017 16:12:57 +0200
Subject: [PATCH 02/18] drm/sun4i: Add if statement instead of depends on
In-Reply-To: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
References: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
Message-ID: <d51d45d57d2bacaa5bafcd861aa0142fcaf0ad77.1499955058.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The depends on relationship is obvious, and using an if statement will
propagate it to every option without the need for each and every one of
them to define it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index 5bcad8f5fb4f..5cc116692913 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -13,9 +13,10 @@ config DRM_SUN4I
 	  Display Engine. If M is selected the module will be called
 	  sun4i-drm.
 
+if DRM_SUN4I
+
 config DRM_SUN4I_HDMI
        tristate "Allwinner A10 HDMI Controller Support"
-       depends on DRM_SUN4I
        default DRM_SUN4I
        help
 	  Choose this option if you have an Allwinner SoC with an HDMI
@@ -23,7 +24,6 @@ config DRM_SUN4I_HDMI
 
 config DRM_SUN4I_BACKEND
 	tristate "Support for Allwinner A10 Display Engine Backend"
-	depends on DRM_SUN4I
 	default DRM_SUN4I
 	help
 	  Choose this option if you have an Allwinner SoC with the
@@ -33,10 +33,11 @@ config DRM_SUN4I_BACKEND
 
 config DRM_SUN8I_MIXER
 	tristate "Support for Allwinner Display Engine 2.0 Mixer"
-	depends on DRM_SUN4I
 	default MACH_SUN8I
 	help
 	  Choose this option if you have an Allwinner SoC with the
 	  Allwinner Display Engine 2.0, which has a mixer to do some
 	  graphics mixture and feed graphics to TCON, If M is
 	  selected the module will be called sun8i-mixer.
+
+endif
-- 
git-series 0.9.1
