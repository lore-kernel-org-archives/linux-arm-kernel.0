From: john@metanate.com (John Keeping)
Date: Sun, 29 Jan 2017 13:24:39 +0000
Subject: [PATCH v3 19/24] drm/rockchip: dw-mipi-dsi: use positive check for
 N{H, V}SYNC
In-Reply-To: <20170129132444.25251-1-john@metanate.com>
References: <20170129132444.25251-1-john@metanate.com>
Message-ID: <20170129132444.25251-20-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This matches other drivers.

Signed-off-by: John Keeping <john@metanate.com>
---
Unchanged in v3
Unchanged in v2

 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index be395c3c5c06..f5b15377ef85 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -774,9 +774,9 @@ static void dw_mipi_dsi_dpi_config(struct dw_mipi_dsi *dsi,
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
