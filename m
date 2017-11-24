From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Fri, 24 Nov 2017 12:25:33 +0530
Subject: [PATCH 6/6] clk: h8300: pr_err() strings should end with newlines
In-Reply-To: <cover.1511505932.git.arvind.yadav.cs@gmail.com>
References: <cover.1511505932.git.arvind.yadav.cs@gmail.com>
Message-ID: <5fe05a034e646f03e6129c7782e38e37856f80a1.1511505932.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pr_err() messages should end with a new-line to avoid other messages
being concatenated.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/clk/h8300/clk-div.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/h8300/clk-div.c b/drivers/clk/h8300/clk-div.c
index 4ae6244..d413ade 100644
--- a/drivers/clk/h8300/clk-div.c
+++ b/drivers/clk/h8300/clk-div.c
@@ -24,13 +24,13 @@ static void __init h8300_div_clk_setup(struct device_node *node)
 
 	num_parents = of_clk_get_parent_count(node);
 	if (!num_parents) {
-		pr_err("%s: no parent found", clk_name);
+		pr_err("%s: no parent found\n", clk_name);
 		return;
 	}
 
 	divcr = of_iomap(node, 0);
 	if (divcr == NULL) {
-		pr_err("%s: failed to map divide register", clk_name);
+		pr_err("%s: failed to map divide register\n", clk_name);
 		goto error;
 	}
 	offset = (unsigned long)divcr & 3;
-- 
1.9.1
