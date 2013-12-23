From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 23 Dec 2013 00:32:33 -0300
Subject: [PATCH v3 02/13] clk: sunxi: clean the magic number of mux parents
In-Reply-To: <1387769564-12894-1-git-send-email-emilio@elopez.com.ar>
References: <1387769564-12894-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1387769564-12894-3-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was pointed out during the review of the factor patches. Let's
indicate what does that magic 5 mean.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 drivers/clk/sunxi/clk-sunxi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index b823613..ce42c92 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -414,13 +414,14 @@ static void __init sunxi_mux_clk_setup(struct device_node *node,
 {
 	struct clk *clk;
 	const char *clk_name = node->name;
-	const char *parents[5];
+	const char *parents[SUNXI_MAX_PARENTS];
 	void *reg;
 	int i = 0;
 
 	reg = of_iomap(node, 0);
 
-	while (i < 5 && (parents[i] = of_clk_get_parent_name(node, i)) != NULL)
+	while (i < SUNXI_MAX_PARENTS &&
+	       (parents[i] = of_clk_get_parent_name(node, i)) != NULL)
 		i++;
 
 	clk = clk_register_mux(NULL, clk_name, parents, i,
-- 
1.8.5.2
