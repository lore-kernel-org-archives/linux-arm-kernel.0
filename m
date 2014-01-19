From: sj38.park@gmail.com (SeongJae Park)
Date: Sun, 19 Jan 2014 14:55:07 +0900
Subject: [PATCH] clk: export __clk_get_hw for re-use in others
Message-ID: <1390110907-29918-1-git-send-email-sj38.park@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following build comes while modprobe process:
> ERROR: "__clk_get_hw" [drivers/clk/clk-max77686.ko] undefined!
> make[2]: *** [__modpost] Error 1
> make[1]: *** [modules] Error 2

Export the symbol to fix it and for other part's usecase.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
---
 drivers/clk/clk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 2b38dc9..3883fba 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -575,6 +575,7 @@ struct clk_hw *__clk_get_hw(struct clk *clk)
 {
 	return !clk ? NULL : clk->hw;
 }
+EXPORT_SYMBOL_GPL(__clk_get_hw);
 
 u8 __clk_get_num_parents(struct clk *clk)
 {
-- 
1.8.3.2
