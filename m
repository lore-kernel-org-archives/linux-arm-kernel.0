From: net147@gmail.com (Jonathan Liu)
Date: Tue,  9 Jan 2018 13:03:22 +1100
Subject: [PATCH v3 2/3] drm/sun4i: hdmi: Fix incorrect assignment in
 sun4i_tmds_determine_rate
In-Reply-To: <20180109020323.11852-1-net147@gmail.com>
References: <20180109020323.11852-1-net147@gmail.com>
Message-ID: <20180109020323.11852-3-net147@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

best_div is set to i which corresponds to rate halving when it should be
set to j which corresponds to the divider.

Fixes: 9c5681011a0c ("drm/sun4i: Add HDMI support")
Signed-off-by: Jonathan Liu <net147@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
index 4d235e5ea31c..88eeeaf34638 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
@@ -105,7 +105,7 @@ static int sun4i_tmds_determine_rate(struct clk_hw *hw,
 				if (!best_parent || abs(rate - rounded / i) <
 				    abs(rate - best_parent / best_div)) {
 					best_parent = rounded;
-					best_div = i;
+					best_div = j;
 				}
 			}
 		}
-- 
2.15.1
