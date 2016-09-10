From: mark.yao@rock-chips.com (Mark Yao)
Date: Sat, 10 Sep 2016 10:29:03 +0800
Subject: [PATCH 2/3] drm: add ARM vendor format afbc
In-Reply-To: <1473474544-16248-1-git-send-email-mark.yao@rock-chips.com>
References: <1473474544-16248-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1473474544-16248-2-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AFBC is arm vendor format, it's a compressed format.

The AFBC format is supported by rk3399 vop big.

We know little about AFBC layout, hope to some guys can
fixme about the afbc comment.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 include/uapi/drm/drm_fourcc.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index a5890bf..9a47d7e 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -159,6 +159,7 @@ extern "C" {
 #define DRM_FORMAT_MOD_VENDOR_NV      0x03
 #define DRM_FORMAT_MOD_VENDOR_SAMSUNG 0x04
 #define DRM_FORMAT_MOD_VENDOR_QCOM    0x05
+#define DRM_FORMAT_MOD_VENDOR_ARM     0x06
 /* add more to the end as needed */
 
 #define fourcc_mod_code(vendor, val) \
@@ -233,6 +234,12 @@ extern "C" {
  */
 #define DRM_FORMAT_MOD_SAMSUNG_64_32_TILE	fourcc_mod_code(SAMSUNG, 1)
 
+/*
+ * FIXME: AFBC is arm vendor format, it's a compressed format.
+ *
+ */
+#define DRM_FORMAT_MOD_ARM_AFBC	fourcc_mod_code(ARM, 1)
+
 #if defined(__cplusplus)
 }
 #endif
-- 
1.9.1
