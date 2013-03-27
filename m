From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Wed, 27 Mar 2013 18:20:43 -0300
Subject: [PATCH v2 7/7] clk: sunxi: drop an unnecesary kmalloc
In-Reply-To: <1364419243-18446-1-git-send-email-emilio@elopez.com.ar>
References: <1363962042-29536-1-git-send-email-emilio@elopez.com.ar>
 <1364419243-18446-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1364419243-18446-8-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_register will copy this information, so we can just use a normal
array and do one less dynamic allocation.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---

Changes from v1:
  - this patch was not present on v1

 drivers/clk/sunxi/clk-sunxi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index daa51ab..0bb0eb4 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -232,7 +232,7 @@ static void __init sunxi_mux_clk_setup(struct device_node *node,
 {
 	struct clk *clk;
 	const char *clk_name = node->name;
-	const char **parents = kmalloc(sizeof(char *) * 5, GFP_KERNEL);
+	const char *parents[5];
 	void *reg;
 	int i = 0;
 
-- 
1.8.2
