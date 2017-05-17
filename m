From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 17 May 2017 22:47:19 +0800
Subject: [PATCH v8 3/9] drm/sun4i: add a Kconfig option for sun4i-backend
In-Reply-To: <20170517144725.3463-1-icenowy@aosc.io>
References: <20170517144725.3463-1-icenowy@aosc.io>
Message-ID: <20170517144725.3463-4-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As sun4i-backend is now a dedicated module, add an Kconfig option for
it to make it optional, since some build may only use other engines.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v7:
- Adjusted the position of BACKEND makefile item. (It's now after
  common codes shared between sun4i-backend and sun8i-mixer.)

 drivers/gpu/drm/sun4i/Kconfig  | 10 ++++++++++
 drivers/gpu/drm/sun4i/Makefile |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index a4b357db8856..5a8227f37cc4 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -12,3 +12,13 @@ config DRM_SUN4I
 	  Choose this option if you have an Allwinner SoC with a
 	  Display Engine. If M is selected the module will be called
 	  sun4i-drm.
+
+config DRM_SUN4I_BACKEND
+	tristate "Support for Allwinner A10 Display Engine Backend"
+	depends on DRM_SUN4I
+	default DRM_SUN4I
+	help
+	  Choose this option if you have an Allwinner SoC with the
+	  original Allwinner Display Engine, which has a backend to
+	  do some alpha blending and feed graphics to TCON. If M is
+	  selected the module will be called sun4i-backend.
diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
index a251fb36c951..da561d064ab8 100644
--- a/drivers/gpu/drm/sun4i/Makefile
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -9,6 +9,7 @@ sun4i-tcon-y += sun4i_crtc.o
 sun4i-backend-y += sun4i_backend.o sun4i_layer.o
 
 obj-$(CONFIG_DRM_SUN4I)		+= sun4i-drm.o sun4i-tcon.o
-obj-$(CONFIG_DRM_SUN4I)		+= sun4i-backend.o
 obj-$(CONFIG_DRM_SUN4I)		+= sun6i_drc.o
 obj-$(CONFIG_DRM_SUN4I)		+= sun4i_tv.o
+
+obj-$(CONFIG_DRM_SUN4I_BACKEND)		+= sun4i-backend.o
-- 
2.12.2
