From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Jul 2017 16:12:58 +0200
Subject: [PATCH 03/18] drm/sun4i: Realign Makefile padding and reorder it
In-Reply-To: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
References: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
Message-ID: <fd70853df9e7ee66a20df9d42921f1f6608a2bc9.1499955058.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some options were not padded as they should, and the order in the Makefile
was chaotic. Fix that.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/Makefile | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
index e29fd3a2ba9c..42871ee7acf6 100644
--- a/drivers/gpu/drm/sun4i/Makefile
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -1,23 +1,23 @@
-sun4i-drm-y += sun4i_drv.o
-sun4i-drm-y += sun4i_framebuffer.o
+sun4i-backend-y			+= sun4i_backend.o sun4i_layer.o
 
-sun4i-drm-hdmi-y += sun4i_hdmi_enc.o
-sun4i-drm-hdmi-y += sun4i_hdmi_ddc_clk.o
-sun4i-drm-hdmi-y += sun4i_hdmi_tmds_clk.o
+sun4i-drm-y			+= sun4i_drv.o
+sun4i-drm-y			+= sun4i_framebuffer.o
 
-sun4i-tcon-y += sun4i_tcon.o
-sun4i-tcon-y += sun4i_rgb.o
-sun4i-tcon-y += sun4i_dotclock.o
-sun4i-tcon-y += sun4i_crtc.o
+sun4i-drm-hdmi-y		+= sun4i_hdmi_enc.o
+sun4i-drm-hdmi-y		+= sun4i_hdmi_ddc_clk.o
+sun4i-drm-hdmi-y		+= sun4i_hdmi_tmds_clk.o
 
-sun4i-backend-y += sun4i_backend.o sun4i_layer.o
+sun4i-tcon-y			+= sun4i_tcon.o
+sun4i-tcon-y			+= sun4i_rgb.o
+sun4i-tcon-y			+= sun4i_dotclock.o
+sun4i-tcon-y			+= sun4i_crtc.o
 
-sun8i-mixer-y += sun8i_mixer.o sun8i_layer.o
+sun8i-mixer-y			+= sun8i_mixer.o sun8i_layer.o
 
 obj-$(CONFIG_DRM_SUN4I)		+= sun4i-drm.o sun4i-tcon.o
 obj-$(CONFIG_DRM_SUN4I)		+= sun6i_drc.o
 obj-$(CONFIG_DRM_SUN4I)		+= sun4i_tv.o
 
-obj-$(CONFIG_DRM_SUN4I_BACKEND)		+= sun4i-backend.o
+obj-$(CONFIG_DRM_SUN4I_BACKEND)	+= sun4i-backend.o
 obj-$(CONFIG_DRM_SUN4I_HDMI)	+= sun4i-drm-hdmi.o
-obj-$(CONFIG_DRM_SUN8I_MIXER)		+= sun8i-mixer.o
+obj-$(CONFIG_DRM_SUN8I_MIXER)	+= sun8i-mixer.o
-- 
git-series 0.9.1
