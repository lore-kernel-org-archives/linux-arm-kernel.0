From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 19 Apr 2016 18:05:04 -0700
Subject: [PATCH] ASoC: ak4642: Remove CLK_IS_ROOT
Message-ID: <1461114304-10495-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
CLK_IS_ROOT", 2016-02-02) so remove it.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 sound/soc/codecs/ak4642.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index cda27c22812a..1ee8506c06c7 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -608,9 +608,7 @@ static struct clk *ak4642_of_parse_mcko(struct device *dev)
 
 	of_property_read_string(np, "clock-output-names", &clk_name);
 
-	clk = clk_register_fixed_rate(dev, clk_name, parent_clk_name,
-				      (parent_clk_name) ? 0 : CLK_IS_ROOT,
-				      rate);
+	clk = clk_register_fixed_rate(dev, clk_name, parent_clk_name, 0, rate);
 	if (!IS_ERR(clk))
 		of_clk_add_provider(np, of_clk_src_simple_get, clk);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
