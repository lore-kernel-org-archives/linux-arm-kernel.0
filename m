From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 26 Jun 2014 23:55:39 +0800
Subject: [PATCH v4 1/6] clk: sunxi: register clock gates with clkdev
In-Reply-To: <1403798144-32188-1-git-send-email-wens@csie.org>
References: <1403798144-32188-1-git-send-email-wens@csie.org>
Message-ID: <1403798144-32188-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new important clock protect code requires the clocks be
registered with clkdev. This was missing for sunxi_gates
type clocks.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index fb2ce84..e43ed6a 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -899,6 +899,7 @@ static void __init sunxi_gates_clk_setup(struct device_node *node,
 						      reg + 4 * (i/32), i % 32,
 						      0, &clk_lock);
 		WARN_ON(IS_ERR(clk_data->clks[i]));
+		clk_register_clkdev(clk_data->clks[i], clk_name, NULL);
 
 		j++;
 	}
-- 
2.0.0
