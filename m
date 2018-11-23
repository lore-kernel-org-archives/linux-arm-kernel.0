From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:24:43 +0100
Subject: [PATCH v2 11/43] drm/fourcc: Add format info helpers for checking YUV
 sub-sampling
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-12-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Display engine drivers often need to distinguish between different types of
YUV sub-sampling. This introduces helpers to check for common sub-sampling
ratios in their commonly-used denomination from the DRM format info.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 include/drm/drm_fourcc.h | 75 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
index b652b711df1a..d170b7b323f7 100644
--- a/include/drm/drm_fourcc.h
+++ b/include/drm/drm_fourcc.h
@@ -185,6 +185,81 @@ drm_format_info_is_yuv_planar(const struct drm_format_info *info)
 	return info->is_yuv && info->num_planes == 3;
 }
 
+/**
+ * drm_format_info_is_yuv_sampling_410 - check that the format info matches a
+ * YUV format with 4:1:0 sub-sampling
+ * @info: format info
+ *
+ * Returns:
+ * A boolean indicating whether the format info matches a YUV format with 4:1:0
+ * sub-sampling.
+ */
+static inline bool
+drm_format_info_is_yuv_sampling_410(const struct drm_format_info *info)
+{
+	return info->is_yuv && info->hsub == 4 && info->vsub == 4;
+}
+
+/**
+ * drm_format_info_is_yuv_sampling_411 - check that the format info matches a
+ * YUV format with 4:1:1 sub-sampling
+ * @info: format info
+ *
+ * Returns:
+ * A boolean indicating whether the format info matches a YUV format with 4:1:1
+ * sub-sampling.
+ */
+static inline bool
+drm_format_info_is_yuv_sampling_411(const struct drm_format_info *info)
+{
+	return info->is_yuv && info->hsub == 4 && info->vsub == 1;
+}
+
+/**
+ * drm_format_info_is_yuv_sampling_420 - check that the format info matches a
+ * YUV format with 4:2:0 sub-sampling
+ * @info: format info
+ *
+ * Returns:
+ * A boolean indicating whether the format info matches a YUV format with 4:2:0
+ * sub-sampling.
+ */
+static inline bool
+drm_format_info_is_yuv_sampling_420(const struct drm_format_info *info)
+{
+	return info->is_yuv && info->hsub == 2 && info->vsub == 2;
+}
+
+/**
+ * drm_format_info_is_yuv_sampling_422 - check that the format info matches a
+ * YUV format with 4:2:2 sub-sampling
+ * @info: format info
+ *
+ * Returns:
+ * A boolean indicating whether the format info matches a YUV format with 4:2:2
+ * sub-sampling.
+ */
+static inline bool
+drm_format_info_is_yuv_sampling_422(const struct drm_format_info *info)
+{
+	return info->is_yuv && info->hsub == 2 && info->vsub == 1;
+}
+
+/**
+ * drm_format_info_is_yuv_sampling_444 - check that the format info matches a
+ * YUV format with 4:4:4 sub-sampling
+ * @info: format info
+ *
+ * Returns:
+ * A boolean indicating whether the format info matches a YUV format with 4:4:4
+ * sub-sampling.
+ */
+static inline bool
+drm_format_info_is_yuv_sampling_444(const struct drm_format_info *info)
+{
+	return info->is_yuv && info->hsub == 1 && info->vsub == 1;
+}
+
 const struct drm_format_info *__drm_format_info(u32 format);
 const struct drm_format_info *drm_format_info(u32 format);
 const struct drm_format_info *
-- 
2.19.1
