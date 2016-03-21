From: codekipper@gmail.com (codekipper at gmail.com)
Date: Mon, 21 Mar 2016 17:10:38 +0100
Subject: [linux-sunxi][PATCH v2 1/5] clk: sunxi: mod1 clock should modify it's
 parent
In-Reply-To: <1458576642-4078-1-git-send-email-codekipper@gmail.com>
References: <1458576642-4078-1-git-send-email-codekipper@gmail.com>
Message-ID: <1458576642-4078-2-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrea Venturi <ennesimamail.av@gmail.com>

add CLK_SET_RATE_PARENT to modify the rate on clk upstream

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 drivers/clk/sunxi/clk-a10-mod1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-a10-mod1.c b/drivers/clk/sunxi/clk-a10-mod1.c
index e9d870d..e2819fa 100644
--- a/drivers/clk/sunxi/clk-a10-mod1.c
+++ b/drivers/clk/sunxi/clk-a10-mod1.c
@@ -62,7 +62,7 @@ static void __init sun4i_mod1_clk_setup(struct device_node *node)
 	clk = clk_register_composite(NULL, clk_name, parents, i,
 				     &mux->hw, &clk_mux_ops,
 				     NULL, NULL,
-				     &gate->hw, &clk_gate_ops, 0);
+				     &gate->hw, &clk_gate_ops, CLK_SET_RATE_PARENT);
 	if (IS_ERR(clk))
 		goto err_free_gate;
 
-- 
2.7.4
