From: zyw@rock-chips.com (Chris Zhong)
Date: Mon, 20 Feb 2017 16:02:22 +0800
Subject: [RESEND PATCH v7 6/7] drm/rockchip/dsi: fix insufficient bandwidth of
 some panel
In-Reply-To: <1487577744-2855-1-git-send-email-zyw@rock-chips.com>
References: <1487577744-2855-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1487577744-2855-7-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set the lanes bps to 1 / 0.9 times of pclk, the margin is not enough
for some panel, it will cause the screen display is not normal, so
increases the badnwidth to 1 / 0.8.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None

 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index c2d7674..a653384 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -532,8 +532,8 @@ static int dw_mipi_dsi_get_lane_bps(struct dw_mipi_dsi *dsi,
 
 	mpclk = DIV_ROUND_UP(mode->clock, MSEC_PER_SEC);
 	if (mpclk) {
-		/* take 1 / 0.9, since mbps must big than bandwidth of RGB */
-		tmp = mpclk * (bpp / dsi->lanes) * 10 / 9;
+		/* take 1 / 0.8, since mbps must big than bandwidth of RGB */
+		tmp = mpclk * (bpp / dsi->lanes) * 10 / 8;
 		if (tmp < max_mbps)
 			target_mbps = tmp;
 		else
-- 
2.6.3
