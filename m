From: john@metanate.com (John Keeping)
Date: Sat, 21 Jan 2017 16:31:23 +0000
Subject: [PATCH v2 21/26] drm/rockchip: dw-mipi-dsi: use positive check for
 N{H, V}SYNC
In-Reply-To: <20170121163128.22240-1-john@metanate.com>
References: <20170121163128.22240-1-john@metanate.com>
Message-ID: <20170121163128.22240-22-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This matches other drivers.

Signed-off-by: John Keeping <john@metanate.com>
---
Unchanged in v2
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 3e19693ae59b..e448d71be447 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -771,9 +771,9 @@ static void dw_mipi_dsi_dpi_config(struct dw_mipi_dsi *dsi,
 		break;
 	}
 
-	if (!(mode->flags & DRM_MODE_FLAG_PVSYNC))
+	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
 		val |= VSYNC_ACTIVE_LOW;
-	if (!(mode->flags & DRM_MODE_FLAG_PHSYNC))
+	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
 		val |= HSYNC_ACTIVE_LOW;
 
 	dsi_write(dsi, DSI_DPI_VCID, DPI_VID(dsi->channel));
-- 
2.11.0.197.gb556de5.dirty
