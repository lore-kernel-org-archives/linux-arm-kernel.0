From: Ying.Liu@freescale.com (Liu Ying)
Date: Wed, 31 Dec 2014 16:23:28 +0800
Subject: [PATCH RFC v8 10/21] drm/dsi: Add a helper to get bits per pixel of
 MIPI DSI pixel format
In-Reply-To: <1420014219-915-1-git-send-email-Ying.Liu@freescale.com>
References: <1420014219-915-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <1420014219-915-11-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
v7->v8:
 * None.

v6->v7:
 * None.

v5->v6:
 * Address the over 80 characters in one line warning reported by the
   checkpatch.pl script.

v4->v5:
 * None.

v3->v4:
 * None.

v2->v3:
 * None.

v1->v2:
 * Thierry Reding suggested that the mipi_dsi_pixel_format_to_bpp() function
   could be placed at the common DRM MIPI DSI driver.
   This patch is newly added.

 include/drm/drm_mipi_dsi.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index f1d8d0d..3662021 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -163,6 +163,20 @@ static inline struct mipi_dsi_device *to_mipi_dsi_device(struct device *dev)
 	return container_of(dev, struct mipi_dsi_device, dev);
 }
 
+static inline int mipi_dsi_pixel_format_to_bpp(enum mipi_dsi_pixel_format fmt)
+{
+	switch (fmt) {
+	case MIPI_DSI_FMT_RGB888:
+	case MIPI_DSI_FMT_RGB666:
+		return 24;
+	case MIPI_DSI_FMT_RGB666_PACKED:
+		return 18;
+	case MIPI_DSI_FMT_RGB565:
+		return 16;
+	}
+	return -EINVAL;
+}
+
 struct mipi_dsi_device *of_find_mipi_dsi_device_by_node(struct device_node *np);
 int mipi_dsi_attach(struct mipi_dsi_device *dsi);
 int mipi_dsi_detach(struct mipi_dsi_device *dsi);
-- 
2.1.0
