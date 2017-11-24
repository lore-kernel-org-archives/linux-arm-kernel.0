From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Fri, 24 Nov 2017 12:25:32 +0530
Subject: [PATCH 5/6] clk: h8s2678: pr_err() strings should end with newlines
In-Reply-To: <cover.1511505932.git.arvind.yadav.cs@gmail.com>
References: <cover.1511505932.git.arvind.yadav.cs@gmail.com>
Message-ID: <1f71746f971b6969882e2d7827334b416178d898.1511505932.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pr_err() messages should end with a new-line to avoid other messages
being concatenated.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/clk/h8300/clk-h8s2678.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/h8300/clk-h8s2678.c b/drivers/clk/h8300/clk-h8s2678.c
index fc24b0b..b68045d 100644
--- a/drivers/clk/h8300/clk-h8s2678.c
+++ b/drivers/clk/h8300/clk-h8s2678.c
@@ -93,7 +93,7 @@ static void __init h8s2678_pll_clk_setup(struct device_node *node)
 
 	num_parents = of_clk_get_parent_count(node);
 	if (!num_parents) {
-		pr_err("%s: no parent found", clk_name);
+		pr_err("%s: no parent found\n", clk_name);
 		return;
 	}
 
@@ -104,13 +104,13 @@ static void __init h8s2678_pll_clk_setup(struct device_node *node)
 
 	pll_clock->sckcr = of_iomap(node, 0);
 	if (pll_clock->sckcr == NULL) {
-		pr_err("%s: failed to map divide register", clk_name);
+		pr_err("%s: failed to map divide register\n", clk_name);
 		goto free_clock;
 	}
 
 	pll_clock->pllcr = of_iomap(node, 1);
 	if (pll_clock->pllcr == NULL) {
-		pr_err("%s: failed to map multiply register", clk_name);
+		pr_err("%s: failed to map multiply register\n", clk_name);
 		goto unmap_sckcr;
 	}
 
-- 
1.9.1
