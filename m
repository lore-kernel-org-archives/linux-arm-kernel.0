From: john@metanate.com (John Keeping)
Date: Fri, 24 Feb 2017 12:55:02 +0000
Subject: [PATCH v4 19/23] drm/rockchip: dw-mipi-dsi: use positive check for
 N{H, V}SYNC
In-Reply-To: <20170224125506.21533-1-john@metanate.com>
References: <20170224125506.21533-1-john@metanate.com>
Message-ID: <20170224125506.21533-20-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This matches other drivers.

Signed-off-by: John Keeping <john@metanate.com>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
---
v4:
- Add Sean's Reviewed-by
Unchanged in v3
Unchanged in v2
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index ccf818d5c7ac..60dfb5666a25 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -791,9 +791,9 @@ static void dw_mipi_dsi_dpi_config(struct dw_mipi_dsi *dsi,
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
2.12.0.rc0.230.gf625d4cdb9.dirty
