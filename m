From: net147@gmail.com (Jonathan Liu)
Date: Tue, 26 Dec 2017 22:12:25 +1100
Subject: [PATCH v2 1/3] drm/sun4i: hdmi: Check for unset best_parent in
 sun4i_tmds_determine_rate
In-Reply-To: <20171226111227.4526-1-net147@gmail.com>
References: <20171226111227.4526-1-net147@gmail.com>
Message-ID: <20171226111227.4526-2-net147@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should check if the best match has been set before comparing it.

Fixes: 9c5681011a0c ("drm/sun4i: Add HDMI support")
Signed-off-by: Jonathan Liu <net147@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
index dc332ea56f6c..4d235e5ea31c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
@@ -102,7 +102,7 @@ static int sun4i_tmds_determine_rate(struct clk_hw *hw,
 					goto out;
 				}
 
-				if (abs(rate - rounded / i) <
+				if (!best_parent || abs(rate - rounded / i) <
 				    abs(rate - best_parent / best_div)) {
 					best_parent = rounded;
 					best_div = i;
-- 
2.15.0
