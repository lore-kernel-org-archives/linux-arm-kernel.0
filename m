From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Fri,  1 Dec 2017 07:05:47 +0100
Subject: [PATCH v2 24/27] drm/sun4i: Add DE2 definitions for YUV formats
In-Reply-To: <20171201060550.10392-1-jernej.skrabec@siol.net>
References: <20171201060550.10392-1-jernej.skrabec@siol.net>
Message-ID: <20171201060550.10392-25-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit expands translation of DRM YUV format to HW specific
information.

It doesn't do any functional changes.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 136 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_mixer.h    |  23 +++++-
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c |   2 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c |   2 +-
 4 files changed, 159 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 7f88cf5f97eb..29ceeb016d72 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -34,82 +34,218 @@ static const struct de2_fmt_info de2_formats[] = {
 	{
 		.drm_fmt = DRM_FORMAT_ARGB8888,
 		.de2_fmt = SUN8I_MIXER_FBFMT_ARGB8888,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_ABGR8888,
 		.de2_fmt = SUN8I_MIXER_FBFMT_ABGR8888,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_RGBA8888,
 		.de2_fmt = SUN8I_MIXER_FBFMT_RGBA8888,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_BGRA8888,
 		.de2_fmt = SUN8I_MIXER_FBFMT_BGRA8888,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_XRGB8888,
 		.de2_fmt = SUN8I_MIXER_FBFMT_XRGB8888,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_XBGR8888,
 		.de2_fmt = SUN8I_MIXER_FBFMT_XBGR8888,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_RGBX8888,
 		.de2_fmt = SUN8I_MIXER_FBFMT_RGBX8888,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_BGRX8888,
 		.de2_fmt = SUN8I_MIXER_FBFMT_BGRX8888,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_RGB888,
 		.de2_fmt = SUN8I_MIXER_FBFMT_RGB888,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_BGR888,
 		.de2_fmt = SUN8I_MIXER_FBFMT_BGR888,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_RGB565,
 		.de2_fmt = SUN8I_MIXER_FBFMT_RGB565,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_BGR565,
 		.de2_fmt = SUN8I_MIXER_FBFMT_BGR565,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_ARGB4444,
 		.de2_fmt = SUN8I_MIXER_FBFMT_ARGB4444,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_ABGR4444,
 		.de2_fmt = SUN8I_MIXER_FBFMT_ABGR4444,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_RGBA4444,
 		.de2_fmt = SUN8I_MIXER_FBFMT_RGBA4444,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_BGRA4444,
 		.de2_fmt = SUN8I_MIXER_FBFMT_BGRA4444,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_ARGB1555,
 		.de2_fmt = SUN8I_MIXER_FBFMT_ARGB1555,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_ABGR1555,
 		.de2_fmt = SUN8I_MIXER_FBFMT_ABGR1555,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_RGBA5551,
 		.de2_fmt = SUN8I_MIXER_FBFMT_RGBA5551,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt = DRM_FORMAT_BGRA5551,
 		.de2_fmt = SUN8I_MIXER_FBFMT_BGRA5551,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_OFF,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_UYVY,
+		.de2_fmt = SUN8I_MIXER_FBFMT_UYVY,
+		.rgb = false,
+		.csc = SUN8I_CSC_MODE_YUV2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_VYUY,
+		.de2_fmt = SUN8I_MIXER_FBFMT_VYUY,
+		.rgb = false,
+		.csc = SUN8I_CSC_MODE_YUV2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_YUYV,
+		.de2_fmt = SUN8I_MIXER_FBFMT_YUYV,
+		.rgb = false,
+		.csc = SUN8I_CSC_MODE_YUV2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_YVYU,
+		.de2_fmt = SUN8I_MIXER_FBFMT_YVYU,
+		.rgb = false,
+		.csc = SUN8I_CSC_MODE_YUV2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_NV16,
+		.de2_fmt = SUN8I_MIXER_FBFMT_NV16,
+		.rgb = false,
+		.csc = SUN8I_CSC_MODE_YUV2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_NV61,
+		.de2_fmt = SUN8I_MIXER_FBFMT_NV61,
+		.rgb = false,
+		.csc = SUN8I_CSC_MODE_YUV2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_NV12,
+		.de2_fmt = SUN8I_MIXER_FBFMT_NV12,
+		.rgb = false,
+		.csc = SUN8I_CSC_MODE_YUV2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_NV21,
+		.de2_fmt = SUN8I_MIXER_FBFMT_NV21,
+		.rgb = false,
+		.csc = SUN8I_CSC_MODE_YUV2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_YUV444,
+		.de2_fmt = SUN8I_MIXER_FBFMT_RGB888,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_YUV2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_YUV422,
+		.de2_fmt = SUN8I_MIXER_FBFMT_YUV422,
+		.rgb = false,
+		.csc = SUN8I_CSC_MODE_YUV2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_YUV420,
+		.de2_fmt = SUN8I_MIXER_FBFMT_YUV420,
+		.rgb = false,
+		.csc = SUN8I_CSC_MODE_YUV2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_YUV411,
+		.de2_fmt = SUN8I_MIXER_FBFMT_YUV411,
+		.rgb = false,
+		.csc = SUN8I_CSC_MODE_YUV2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_YVU444,
+		.de2_fmt = SUN8I_MIXER_FBFMT_RGB888,
+		.rgb = true,
+		.csc = SUN8I_CSC_MODE_YVU2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_YVU422,
+		.de2_fmt = SUN8I_MIXER_FBFMT_YUV422,
+		.rgb = false,
+		.csc = SUN8I_CSC_MODE_YVU2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_YVU420,
+		.de2_fmt = SUN8I_MIXER_FBFMT_YUV420,
+		.rgb = false,
+		.csc = SUN8I_CSC_MODE_YVU2RGB,
+	},
+	{
+		.drm_fmt = DRM_FORMAT_YVU411,
+		.de2_fmt = SUN8I_MIXER_FBFMT_YUV411,
+		.rgb = false,
+		.csc = SUN8I_CSC_MODE_YVU2RGB,
 	},
 };
 
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index 994090858b18..bc58040a88f9 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -14,6 +14,7 @@
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
+#include "sun8i_csc.h"
 #include "sunxi_engine.h"
 
 #define SUN8I_MIXER_SIZE(w, h)			(((h) - 1) << 16 | ((w) - 1))
@@ -73,6 +74,22 @@
 #define SUN8I_MIXER_FBFMT_RGBA5551	18
 #define SUN8I_MIXER_FBFMT_BGRA5551	19
 
+#define SUN8I_MIXER_FBFMT_YUYV		0
+#define SUN8I_MIXER_FBFMT_UYVY		1
+#define SUN8I_MIXER_FBFMT_YVYU		2
+#define SUN8I_MIXER_FBFMT_VYUY		3
+#define SUN8I_MIXER_FBFMT_NV16		4
+#define SUN8I_MIXER_FBFMT_NV61		5
+#define SUN8I_MIXER_FBFMT_YUV422	6
+/* format 7 doesn't exist */
+#define SUN8I_MIXER_FBFMT_NV12		8
+#define SUN8I_MIXER_FBFMT_NV21		9
+#define SUN8I_MIXER_FBFMT_YUV420	10
+/* format 11 doesn't exist */
+/* format 12 is semi-planar YUV411 UVUV */
+/* format 13 is semi-planar YUV411 VUVU */
+#define SUN8I_MIXER_FBFMT_YUV411	14
+
 /*
  * These sub-engines are still unknown now, the EN registers are here only to
  * be used to disable these sub-engines.
@@ -86,8 +103,10 @@
 #define SUN8I_MIXER_DCSC_EN			0xb0000
 
 struct de2_fmt_info {
-	u32 drm_fmt;
-	u32 de2_fmt;
+	u32			drm_fmt;
+	u32			de2_fmt;
+	bool			rgb;
+	enum sun8i_csc_mode	csc;
 };
 
 /**
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index 3cf0729cc7e9..fd76ffd40580 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -154,7 +154,7 @@ static int sun8i_ui_layer_update_formats(struct sun8i_mixer *mixer, int channel,
 	u32 val;
 
 	fmt_info = sun8i_mixer_format_info(state->fb->format->format);
-	if (!fmt_info) {
+	if (!fmt_info || !fmt_info->rgb) {
 		DRM_DEBUG_DRIVER("Invalid format\n");
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index e47a0c1f640d..5a09abec189b 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -118,7 +118,7 @@ static int sun8i_vi_layer_update_formats(struct sun8i_mixer *mixer, int channel,
 	u32 val;
 
 	fmt_info = sun8i_mixer_format_info(state->fb->format->format);
-	if (!fmt_info) {
+	if (!fmt_info || !fmt_info->rgb) {
 		DRM_DEBUG_DRIVER("Invalid format\n");
 		return -EINVAL;
 	}
-- 
2.15.1
