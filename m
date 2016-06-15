From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jun 2016 17:55:23 +0200
Subject: [PATCH] clk: sunxi: remove unused variable
Message-ID: <20160615155537.3342366-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only use of the local num_parents variable was remove,
so we now get a warning:

drivers/clk/sunxi/clk-sun4i-tcon-ch1.c: In function 'tcon_ch1_get_parent':
drivers/clk/sunxi/clk-sun4i-tcon-ch1.c:82:6: error: unused variable 'num_parents' [-Werror=unused-variable]

This removes the variable.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 4de2d58bc973 ("clk: sunxi: tcon-ch1: Do not return a negative error in get_parent")
---
 drivers/clk/sunxi/clk-sun4i-tcon-ch1.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-sun4i-tcon-ch1.c b/drivers/clk/sunxi/clk-sun4i-tcon-ch1.c
index 248585238b1c..b6d29d1bedca 100644
--- a/drivers/clk/sunxi/clk-sun4i-tcon-ch1.c
+++ b/drivers/clk/sunxi/clk-sun4i-tcon-ch1.c
@@ -79,7 +79,6 @@ static int tcon_ch1_is_enabled(struct clk_hw *hw)
 static u8 tcon_ch1_get_parent(struct clk_hw *hw)
 {
 	struct tcon_ch1_clk *tclk = hw_to_tclk(hw);
-	int num_parents = clk_hw_get_num_parents(hw);
 	u32 reg;
 
 	reg = readl(tclk->reg) >> TCON_CH1_SCLK2_MUX_SHIFT;
-- 
2.9.0
