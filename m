From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 17 Jan 2014 19:47:17 -0800
Subject: [PATCH] clk: Export more clk-provider functions
Message-ID: <1390016837-24837-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow drivers to be compiled as modules by exporting more clock
provider functions.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/clk.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 0b27b543dacf..2e83cf643db0 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -547,16 +547,19 @@ struct clk_hw *__clk_get_hw(struct clk *clk)
 {
 	return !clk ? NULL : clk->hw;
 }
+EXPORT_SYMBOL_GPL(__clk_get_hw);
 
 u8 __clk_get_num_parents(struct clk *clk)
 {
 	return !clk ? 0 : clk->num_parents;
 }
+EXPORT_SYMBOL_GPL(__clk_get_num_parents);
 
 struct clk *__clk_get_parent(struct clk *clk)
 {
 	return !clk ? NULL : clk->parent;
 }
+EXPORT_SYMBOL_GPL(__clk_get_parent);
 
 struct clk *clk_get_parent_by_index(struct clk *clk, u8 index)
 {
@@ -570,6 +573,7 @@ struct clk *clk_get_parent_by_index(struct clk *clk, u8 index)
 	else
 		return clk->parents[index];
 }
+EXPORT_SYMBOL_GPL(clk_get_parent_by_index);
 
 unsigned int __clk_get_enable_count(struct clk *clk)
 {
@@ -601,6 +605,7 @@ unsigned long __clk_get_rate(struct clk *clk)
 out:
 	return ret;
 }
+EXPORT_SYMBOL_GPL(__clk_get_rate);
 
 unsigned long __clk_get_flags(struct clk *clk)
 {
@@ -649,6 +654,7 @@ bool __clk_is_enabled(struct clk *clk)
 out:
 	return !!ret;
 }
+EXPORT_SYMBOL_GPL(__clk_is_enabled);
 
 static struct clk *__clk_lookup_subtree(const char *name, struct clk *clk)
 {
@@ -740,6 +746,7 @@ out:
 
 	return best;
 }
+EXPORT_SYMBOL_GPL(__clk_mux_determine_rate);
 
 /***        clk api        ***/
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
