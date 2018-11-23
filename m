From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:24:44 +0100
Subject: [PATCH v2 12/43] drm/fourcc: Add format helpers for checking YUV
 sub-sampling
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-13-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This introduces new format helpers that use the previously-introduced
format info helpers for checking YUV sub-sampling.

Only the format fourcc is required by these helpers and the formats are
iterated from the list.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/drm_fourcc.c | 105 +++++++++++++++++++++++++++++++++++
 include/drm/drm_fourcc.h     |   5 ++
 2 files changed, 110 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index b56e773f9f63..6d395c586ad5 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -492,6 +492,111 @@ bool drm_format_is_yuv_planar(uint32_t format)
 }
 EXPORT_SYMBOL(drm_format_is_yuv_planar);
 
+/**
+ * drm_format_is_yuv_sampling_410 - check that the format is a YUV format with
+ * 4:1:0 sub-sampling
+ * @format: pixel format
+ *
+ * Returns:
+ * A boolean indicating whether the format is a YUV format with 4:1:0
+ * sub-sampling.
+ */
+bool drm_format_is_yuv_sampling_410(uint32_t format)
+{
+	const struct drm_format_info *info;
+
+	info = drm_format_info(format);
+	if (!info)
+		return false;
+
+	return drm_format_info_is_yuv_sampling_410(info);
+}
+EXPORT_SYMBOL(drm_format_is_yuv_sampling_410);
+
+/**
+ * drm_format_is_yuv_sampling_411 - check that the format is a YUV format with
+ * 4:1:1 sub-sampling
+ * @format: pixel format
+ *
+ * Returns:
+ * A boolean indicating whether the format is a YUV format with 4:1:1
+ * sub-sampling.
+ */
+bool drm_format_is_yuv_sampling_411(uint32_t format)
+{
+	const struct drm_format_info *info;
+
+	info = drm_format_info(format);
+	if (!info)
+		return false;
+
+	return drm_format_info_is_yuv_sampling_411(info);
+}
+EXPORT_SYMBOL(drm_format_is_yuv_sampling_411);
+
+/**
+ * drm_format_is_yuv_sampling_420 - check that the format is a YUV format with
+ * 4:2:0 sub-sampling
+ * @format: pixel format
+ *
+ * Returns:
+ * A boolean indicating whether the format is a YUV format with 4:2:0
+ * sub-sampling.
+ */
+bool drm_format_is_yuv_sampling_420(uint32_t format)
+{
+	const struct drm_format_info *info;
+
+	info = drm_format_info(format);
+	if (!info)
+		return false;
+
+	return drm_format_info_is_yuv_sampling_420(info);
+}
+EXPORT_SYMBOL(drm_format_is_yuv_sampling_420);
+
+/**
+ * drm_format_is_yuv_sampling_422 - check that the format is a YUV format with
+ * 4:2:2 sub-sampling
+ * @format: pixel format
+ *
+ * Returns:
+ * A boolean indicating whether the format is a YUV format with 4:2:2
+ * sub-sampling.
+ */
+bool drm_format_is_yuv_sampling_422(uint32_t format)
+{
+	const struct drm_format_info *info;
+
+	info = drm_format_info(format);
+	if (!info)
+		return false;
+
+	return drm_format_info_is_yuv_sampling_422(info);
+}
+EXPORT_SYMBOL(drm_format_is_yuv_sampling_422);
+
+/**
+ * drm_format_is_yuv_sampling_444 - check that the format is a YUV format with
+ * 4:4:4 sub-sampling
+ * @format: pixel format
+ *
+ * Returns:
+ * A boolean indicating whether the format is a YUV format with 4:4:4
+ * sub-sampling.
+ */
+bool drm_format_is_yuv_sampling_444(uint32_t format)
+{
+	const struct drm_format_info *info;
+
+	info = drm_format_info(format);
+	if (!info)
+		return false;
+
+	return drm_format_info_is_yuv_sampling_444(info);
+}
+EXPORT_SYMBOL(drm_format_is_yuv_sampling_444);
+
 /**
  * drm_format_info_block_width - width in pixels of block.
  * @info: pixel format info
diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
index d170b7b323f7..cf082d8b6ad4 100644
--- a/include/drm/drm_fourcc.h
+++ b/include/drm/drm_fourcc.h
@@ -278,6 +278,11 @@ bool drm_format_is_yuv(uint32_t format);
 bool drm_format_is_yuv_packed(uint32_t format);
 bool drm_format_is_yuv_semiplanar(uint32_t format);
 bool drm_format_is_yuv_planar(uint32_t format);
+bool drm_format_is_yuv_sampling_410(uint32_t format);
+bool drm_format_is_yuv_sampling_411(uint32_t format);
+bool drm_format_is_yuv_sampling_420(uint32_t format);
+bool drm_format_is_yuv_sampling_422(uint32_t format);
+bool drm_format_is_yuv_sampling_444(uint32_t format);
 unsigned int drm_format_info_block_width(const struct drm_format_info *info,
 					 int plane);
 unsigned int drm_format_info_block_height(const struct drm_format_info *info,
-- 
2.19.1
