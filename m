From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:24:53 +0100
Subject: [PATCH v2 21/43] drm/sun4i: frontend: Add support for the BGRX8888
 input format
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-22-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This introduces support for the BGRX8888 input format for the frontend,
with its associated pixel sequence value definition. Other fields are
already configured correctly as they no longer depend on the format's
fourcc directly.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 5 +++++
 drivers/gpu/drm/sun4i/sun4i_frontend.h | 1 +
 drivers/gpu/drm/sun4i/sun4i_layer.c    | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 7a8efbd516ac..e579fcf63ab4 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -127,6 +127,10 @@ static int sun4i_frontend_drm_format_to_input_mode(uint32_t fmt, u32 *val)
 static int sun4i_frontend_drm_format_to_input_sequence(uint32_t fmt, u32 *val)
 {
 	switch (fmt) {
+	case DRM_FORMAT_BGRX8888:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_BGRX;
+		return 0;
+
 	case DRM_FORMAT_XRGB8888:
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_XRGB;
 		return 0;
@@ -149,6 +153,7 @@ static int sun4i_frontend_drm_format_to_output_fmt(uint32_t fmt, u32 *val)
 }
 
 static const uint32_t sun4i_frontend_formats[] = {
+	DRM_FORMAT_BGRX8888,
 	DRM_FORMAT_XRGB8888,
 };
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index 56bd5a3f9723..2ee1bccf378a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -28,6 +28,7 @@
 #define SUN4I_FRONTEND_INPUT_FMT_REG		0x04c
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PACKED	(1 << 8)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_RGB		(5 << 4)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_BGRX		0
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_XRGB		1
 
 #define SUN4I_FRONTEND_OUTPUT_FMT_REG		0x05c
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index c3368b17e5f1..6155eca6b1bd 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -131,6 +131,7 @@ static const uint32_t sun4i_layer_formats[] = {
 	DRM_FORMAT_ARGB8888,
 	DRM_FORMAT_ARGB4444,
 	DRM_FORMAT_ARGB1555,
+	DRM_FORMAT_BGRX8888,
 	DRM_FORMAT_RGBA5551,
 	DRM_FORMAT_RGBA4444,
 	DRM_FORMAT_RGB888,
-- 
2.19.1
