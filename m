From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Fri, 22 Mar 2013 11:20:42 -0300
Subject: [PATCH 6/6] clk: sunxi: drop CLK_IGNORE_UNUSED
In-Reply-To: <1363962042-29536-1-git-send-email-emilio@elopez.com.ar>
References: <1363962042-29536-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1363962042-29536-7-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This flag was in place to prevent important clocks from getting gated
while they had no users. Now that the UART driver supports clocks
properly, we can drop this.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 drivers/clk/sunxi/clk-sunxi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 30d71f4..44c32fc 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -41,8 +41,8 @@ static void __init sunxi_osc_clk_setup(struct device_node *node)
 
 	parent = of_clk_get_parent_name(node, 0);
 
-	clk = clk_register_gate(NULL, clk_name, parent, CLK_IGNORE_UNUSED,
-				reg, SUNXI_OSC24M_GATE, 0, &clk_lock);
+	clk = clk_register_gate(NULL, clk_name, parent, 0, reg,
+				SUNXI_OSC24M_GATE, 0, &clk_lock);
 
 	if (clk) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
@@ -198,8 +198,8 @@ static void __init sunxi_factors_clk_setup(struct device_node *node,
 
 	parent = of_clk_get_parent_name(node, 0);
 
-	clk = clk_register_factors(NULL, clk_name, parent, CLK_IGNORE_UNUSED,
-				   reg, data->table, data->getter, &clk_lock);
+	clk = clk_register_factors(NULL, clk_name, parent, 0, reg,
+				   data->table, data->getter, &clk_lock);
 
 	if (clk) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-- 
1.8.2
