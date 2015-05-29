From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 29 May 2015 11:25:47 +0200
Subject: [PATCH 3/5] clk: ti: Use of_clk_get_parent_count() instead of open
 coding
In-Reply-To: <1432891549-23295-1-git-send-email-geert+renesas@glider.be>
References: <1432891549-23295-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1432891549-23295-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/ti/clockdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdomain.c
index 35fe1085480cf33d..b82ef07f34034105 100644
--- a/drivers/clk/ti/clockdomain.c
+++ b/drivers/clk/ti/clockdomain.c
@@ -32,7 +32,7 @@ static void __init of_ti_clockdomain_setup(struct device_node *node)
 	int i;
 	int num_clks;
 
-	num_clks = of_count_phandle_with_args(node, "clocks", "#clock-cells");
+	num_clks = of_clk_get_parent_count(node);
 
 	for (i = 0; i < num_clks; i++) {
 		clk = of_clk_get(node, i);
-- 
1.9.1
