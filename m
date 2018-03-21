From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Wed, 21 Mar 2018 16:29:02 +0100
Subject: [PATCH 08/10] drm/fourcc: Add definitions for Allwinner vendor and
 MB32 tiled format
In-Reply-To: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
Message-ID: <20180321152904.22411-9-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This introduces specific definitions for vendor Allwinner and its
specific MB32 tiled format, an NV12-based format with 32x32 tiles.

This format is the default output format used by the VPU on most
Allwinner platforms.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 include/uapi/drm/drm_fourcc.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index e04613d30a13..1b7ef9102582 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -183,6 +183,7 @@ extern "C" {
 #define DRM_FORMAT_MOD_VENDOR_QCOM    0x05
 #define DRM_FORMAT_MOD_VENDOR_VIVANTE 0x06
 #define DRM_FORMAT_MOD_VENDOR_BROADCOM 0x07
+#define DRM_FORMAT_MOD_VENDOR_ALLWINNER 0x08
 /* add more to the end as needed */
 
 #define DRM_FORMAT_RESERVED	      ((1ULL << 56) - 1)
@@ -405,6 +406,15 @@ extern "C" {
  */
 #define DRM_FORMAT_MOD_BROADCOM_VC4_T_TILED fourcc_mod_code(BROADCOM, 1)
 
+/*
+ * Allwinner "MB32" tiled format
+ *
+ * This is the primary layout coming out of the VPU, where pixels are tiled
+ * 32x32.
+ */
+#define DRM_FORMAT_MOD_ALLWINNER_MB32_TILED fourcc_mod_code(ALLWINNER, 1)
+
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.16.2
