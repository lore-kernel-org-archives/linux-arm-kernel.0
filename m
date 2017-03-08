From: zyw@rock-chips.com (Chris Zhong)
Date: Wed,  8 Mar 2017 10:27:57 +0800
Subject: [PATCH 3/3] drm/rockchip: cdn-dp: add more log for video config
In-Reply-To: <1488940077-22297-1-git-send-email-zyw@rock-chips.com>
References: <1488940077-22297-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1488940077-22297-4-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to analyze some video config failed, add some useful
printouts.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 drivers/gpu/drm/rockchip/cdn-dp-reg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
index 963d8ab..b14d211 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
@@ -671,6 +671,10 @@ int cdn_dp_config_video(struct cdn_dp_device *dp)
 		rem = do_div(symbol, 1000);
 		if (tu_size_reg > 64) {
 			ret = -EINVAL;
+			DRM_DEV_ERROR(dp->dev,
+				      "tu error, clk:%d, lanes:%d, rate:%d\n",
+				      mode->clock, dp->link.num_lanes,
+				      link_rate);
 			goto err_config_video;
 		}
 	} while ((symbol <= 1) || (tu_size_reg - symbol < 4) ||
-- 
2.6.3
