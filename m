From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 23 May 2014 15:51:05 +0800
Subject: [PATCH 02/22] clk: sunxi: register clock gates with clkdev
In-Reply-To: <1400831485-28576-1-git-send-email-wens@csie.org>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
Message-ID: <1400831485-28576-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new important clock protect code requires the clocks be
registered with clkdev. This was missing for sunxi_gates
type clocks.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 96ba00c..e0e24d5 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -899,6 +899,7 @@ static void __init sunxi_gates_clk_setup(struct device_node *node,
 						      reg + 4 * (i/32), i % 32,
 						      0, &clk_lock);
 		WARN_ON(IS_ERR(clk_data->clks[i]));
+		clk_register_clkdev(clks[i], clk_name, NULL);
 
 		j++;
 	}
-- 
2.0.0.rc2
