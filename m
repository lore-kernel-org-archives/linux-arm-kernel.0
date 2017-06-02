From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  2 Jun 2017 18:10:15 +0800
Subject: [PATCH 10/19] drm/sun4i: hdmi: Rename internal DDC clock to avoid
 name collision
In-Reply-To: <20170602101024.18940-1-wens@csie.org>
References: <20170602101024.18940-1-wens@csie.org>
Message-ID: <20170602101024.18940-11-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DDC parent clock on the A31 SoC is also conveniently named
"hdmi-ddc", which results in a name collision when the hdmi driver
registers its internal DDC divider clock.

Rename the internal clock to "hdmi-ddc-divider".

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
index e1071838f487..9a6b6243e977 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
@@ -125,7 +125,7 @@ static int _sun4i_ddc_create(struct sun4i_hdmi *hdmi, struct clk *parent,
 	if (!ddc)
 		return -ENOMEM;
 
-	init.name = "hdmi-ddc";
+	init.name = "hdmi-ddc-divider";
 	init.ops = &sun4i_ddc_ops;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
-- 
2.11.0
