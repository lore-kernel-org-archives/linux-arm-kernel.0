From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 20 Oct 2016 09:58:40 +0200
Subject: [PATCH 2/2] clk: mxs: don't register a clkdev for enet_out
In-Reply-To: <20161020075840.16406-1-u.kleine-koenig@pengutronix.de>
References: <20161020075840.16406-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20161020075840.16406-2-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The last user is gone in the previous commit. So this can be removed, too.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/clk/mxs/clk-imx28.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
index 6b572b759f9a..cf6b0ab9ac72 100644
--- a/drivers/clk/mxs/clk-imx28.c
+++ b/drivers/clk/mxs/clk-imx28.c
@@ -247,8 +247,6 @@ static void __init mx28_clocks_init(struct device_node *np)
 	clk_data.clk_num = ARRAY_SIZE(clks);
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 
-	clk_register_clkdev(clks[enet_out], NULL, "enet_out");
-
 	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
 		clk_prepare_enable(clks[clks_init_on[i]]);
 }
-- 
2.9.3
