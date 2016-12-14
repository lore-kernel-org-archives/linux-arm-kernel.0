From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Wed, 14 Dec 2016 13:14:33 +0800
Subject: [PATCH] drm/mediatek: Support UYVY and YUYV format for overlay
Message-ID: <1481692473-18755-1-git-send-email-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MT8173 overlay can support UYVY and YUYV format,
we add the format in DRM driver.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c  | 6 ++++++
 drivers/gpu/drm/mediatek/mtk_drm_plane.c | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 019b7ca..0a340f3 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -44,6 +44,8 @@
 #define OVL_CON_CLRFMT_RGB888	(1 << 12)
 #define OVL_CON_CLRFMT_RGBA8888	(2 << 12)
 #define OVL_CON_CLRFMT_ARGB8888	(3 << 12)
+#define OVL_CON_CLRFMT_UYVY	(4 << 12)
+#define OVL_CON_CLRFMT_YUYV	(5 << 12)
 #define	OVL_CON_AEN		BIT(8)
 #define	OVL_CON_ALPHA		0xff
 
@@ -161,6 +163,10 @@ static unsigned int ovl_fmt_convert(unsigned int fmt)
 	case DRM_FORMAT_XBGR8888:
 	case DRM_FORMAT_ABGR8888:
 		return OVL_CON_CLRFMT_RGBA8888 | OVL_CON_BYTE_SWAP;
+	case DRM_FORMAT_YUYV:
+		return OVL_CON_CLRFMT_YUYV;
+	case DRM_FORMAT_UYVY:
+		return OVL_CON_CLRFMT_UYVY;
 	}
 }
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index c461a23..b94c6ee 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
@@ -28,6 +28,8 @@
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_ARGB8888,
 	DRM_FORMAT_RGB565,
+	DRM_FORMAT_YUYV,
+	DRM_FORMAT_UYVY,
 };
 
 static void mtk_plane_reset(struct drm_plane *plane)
-- 
1.9.1
