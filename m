From: john@metanate.com (John Keeping)
Date: Mon, 19 Sep 2016 18:17:39 +0100
Subject: [PATCH 21/26] drm/rockchip: dw-mipi-dsi: use positive check for N{H,
 V}SYNC
In-Reply-To: <20160919171747.28512-1-john@metanate.com>
References: <20160919171747.28512-1-john@metanate.com>
Message-ID: <20160919171747.28512-30-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This matches other drivers.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index ae7c330cb7ac..2b26a54972da 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -772,9 +772,9 @@ static void dw_mipi_dsi_dpi_config(struct dw_mipi_dsi *dsi)
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
2.10.0.278.g4f427b1.dirty
