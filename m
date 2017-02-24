From: john@metanate.com (John Keeping)
Date: Fri, 24 Feb 2017 12:54:50 +0000
Subject: [PATCH v4 07/23] drm/rockchip: dw-mipi-dsi: include bad value in
 error message
In-Reply-To: <20170224125506.21533-1-john@metanate.com>
References: <20170224125506.21533-1-john@metanate.com>
Message-ID: <20170224125506.21533-8-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As an aid to debugging.

Signed-off-by: John Keeping <john@metanate.com>
Reviewed-by: Chris Zhong <zyw@rock-chips.com>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
---
v4:
- Add Sean's Reviewed-by
v3:
- Add Chris' Reviewed-by
Unchanged in v2
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index f55010312f25..374b18c550fd 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -646,7 +646,8 @@ static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
 		ret = dw_mipi_dsi_dcs_long_write(dsi, msg);
 		break;
 	default:
-		dev_err(dsi->dev, "unsupported message type\n");
+		dev_err(dsi->dev, "unsupported message type 0x%02x\n",
+			msg->type);
 		ret = -EINVAL;
 	}
 
-- 
2.12.0.rc0.230.gf625d4cdb9.dirty
