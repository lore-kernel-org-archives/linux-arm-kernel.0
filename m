From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 17 Oct 2016 00:25:55 +0900
Subject: [PATCH] clk: uniphier: fix type of variable passed to regmap_read()
Message-ID: <1476631555-2059-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 3rd argument of regmap_read() takes a pointer to unsigned int.
This driver is saved just because u32 happens to be typedef'ed as
unsigned int, but we should not rely on that fact.  Change the
variable type just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/clk/uniphier/clk-uniphier-mux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/uniphier/clk-uniphier-mux.c b/drivers/clk/uniphier/clk-uniphier-mux.c
index 15a2f2c..2c243a8 100644
--- a/drivers/clk/uniphier/clk-uniphier-mux.c
+++ b/drivers/clk/uniphier/clk-uniphier-mux.c
@@ -42,7 +42,7 @@ static u8 uniphier_clk_mux_get_parent(struct clk_hw *hw)
 	struct uniphier_clk_mux *mux = to_uniphier_clk_mux(hw);
 	int num_parents = clk_hw_get_num_parents(hw);
 	int ret;
-	u32 val;
+	unsigned int val;
 	u8 i;
 
 	ret = regmap_read(mux->regmap, mux->reg, &val);
-- 
1.9.1
