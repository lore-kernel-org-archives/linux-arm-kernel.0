From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 14 Aug 2015 01:11:02 +0000
Subject: [PATCH 1/2] clk: atlas7: move variable-definition together
Message-ID: <1439514663-23979-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guo Zeng <Guo.Zeng@csr.com>

re-order the codes more reasonable by moving variable-definition
together.

Signed-off-by: Guo Zeng <Guo.Zeng@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/clk/sirf/clk-atlas7.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/sirf/clk-atlas7.c b/drivers/clk/sirf/clk-atlas7.c
index a98e21f..d34d1b3 100644
--- a/drivers/clk/sirf/clk-atlas7.c
+++ b/drivers/clk/sirf/clk-atlas7.c
@@ -206,18 +206,6 @@
 #define SIRFSOC_CLKC_LEAF_CLK_EN8_SET        0x0548
 
 
-static void __iomem *sirfsoc_clk_vbase;
-static struct clk_onecell_data clk_data;
-
-static const struct clk_div_table pll_div_table[] = {
-	{ .val = 0, .div = 1 },
-	{ .val = 1, .div = 2 },
-	{ .val = 2, .div = 4 },
-	{ .val = 3, .div = 8 },
-	{ .val = 4, .div = 16 },
-	{ .val = 5, .div = 32 },
-};
-
 struct clk_pll {
 	struct clk_hw hw;
 	u16 regofs;  /* register offset */
@@ -284,6 +272,18 @@ struct atlas7_reset_desc {
 	spinlock_t *lock;
 };
 
+static void __iomem *sirfsoc_clk_vbase;
+static struct clk_onecell_data clk_data;
+
+static const struct clk_div_table pll_div_table[] = {
+	{ .val = 0, .div = 1 },
+	{ .val = 1, .div = 2 },
+	{ .val = 2, .div = 4 },
+	{ .val = 3, .div = 8 },
+	{ .val = 4, .div = 16 },
+	{ .val = 5, .div = 32 },
+};
+
 static DEFINE_SPINLOCK(cpupll_ctrl1_lock);
 static DEFINE_SPINLOCK(mempll_ctrl1_lock);
 static DEFINE_SPINLOCK(sys0pll_ctrl1_lock);
-- 
1.9.1
