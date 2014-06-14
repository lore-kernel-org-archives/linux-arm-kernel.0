From: xerofoify@gmail.com (Nick)
Date: Sat, 14 Jun 2014 14:11:48 -0400
Subject: [PATCH] Frees gate after if statement in clk-sunxi.c
Message-ID: <1402769508-3821-1-git-send-email-xerofoify@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nick <xerofoify@gmail.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 4264834..6f4fc51 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -42,6 +42,7 @@ static void __init sun4i_osc_clk_setup(struct device_node *node)
 	u32 rate;
 
 	if (of_property_read_u32(node, "clock-frequency", &rate))
+		kree(gate);
 		return;
 
 	/* allocate fixed-rate and gate clock structs */
-- 
1.9.1
