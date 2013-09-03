From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue,  3 Sep 2013 09:43:51 +0200
Subject: [PATCH] clk: Move symbol export to proper location
Message-ID: <1378194231-26828-1-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The __clk_get_flags() symbol is exported immediately following the
clk_unprepare_unused_subtree() function. This is unusual, since a symbol
export typically follows body of the function that it exports.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/clk/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 2db08c0..b49c9ee 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -458,7 +458,6 @@ static void clk_unprepare_unused_subtree(struct clk *clk)
 			clk->ops->unprepare(clk->hw);
 	}
 }
-EXPORT_SYMBOL_GPL(__clk_get_flags);
 
 /* caller must hold prepare_lock */
 static void clk_disable_unused_subtree(struct clk *clk)
@@ -607,6 +606,7 @@ unsigned long __clk_get_flags(struct clk *clk)
 {
 	return !clk ? 0 : clk->flags;
 }
+EXPORT_SYMBOL_GPL(__clk_get_flags);
 
 bool __clk_is_prepared(struct clk *clk)
 {
-- 
1.8.4
