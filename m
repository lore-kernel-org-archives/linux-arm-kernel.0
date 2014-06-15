From: xerofoify@gmail.com (Nick)
Date: Sat, 14 Jun 2014 21:15:44 -0400
Subject: [PATCHV2]Fixes memory leak in clk-sunxi.c
Message-ID: <1402794944-3357-1-git-send-email-xerofoify@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nick <xerofoify@gmail.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 6f4fc51..c2ce538 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -41,10 +41,10 @@ static void __init sun4i_osc_clk_setup(struct device_node *node)
 	const char *clk_name = node->name;
 	u32 rate;
 
-	if (of_property_read_u32(node, "clock-frequency", &rate))
+	if (of_property_read_u32(node, "clock-frequency", &rate)) {
 		kree(gate);
 		return;
-
+	}
 	/* allocate fixed-rate and gate clock structs */
 	fixed = kzalloc(sizeof(struct clk_fixed_rate), GFP_KERNEL);
 	if (!fixed)
-- 
1.9.1
