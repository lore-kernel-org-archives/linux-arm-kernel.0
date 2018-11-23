From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:24:54 +0100
Subject: [PATCH v2 22/43] drm/sun4i: frontend: Add support for the BGRX8888
 output format
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-23-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This introduces support for the BGRX8888 output format for the frontend,
with its associated output format value definition.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 4 ++++
 drivers/gpu/drm/sun4i/sun4i_frontend.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index e579fcf63ab4..7fa8fb3eb7aa 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -143,6 +143,10 @@ static int sun4i_frontend_drm_format_to_input_sequence(uint32_t fmt, u32 *val)
 static int sun4i_frontend_drm_format_to_output_fmt(uint32_t fmt, u32 *val)
 {
 	switch (fmt) {
+	case DRM_FORMAT_BGRX8888:
+		*val = SUN4I_FRONTEND_OUTPUT_FMT_DATA_FMT_BGRX8888;
+		return 0;
+
 	case DRM_FORMAT_XRGB8888:
 		*val = SUN4I_FRONTEND_OUTPUT_FMT_DATA_FMT_XRGB8888;
 		return 0;
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index 2ee1bccf378a..800a193eebc2 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -32,6 +32,7 @@
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_XRGB		1
 
 #define SUN4I_FRONTEND_OUTPUT_FMT_REG		0x05c
+#define SUN4I_FRONTEND_OUTPUT_FMT_DATA_FMT_BGRX8888	1
 #define SUN4I_FRONTEND_OUTPUT_FMT_DATA_FMT_XRGB8888	2
 
 #define SUN4I_FRONTEND_CH0_INSIZE_REG		0x100
-- 
2.19.1
