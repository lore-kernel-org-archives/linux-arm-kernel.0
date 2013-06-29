From: pmeerw@pmeerw.net (Peter Meerwald)
Date: Sat, 29 Jun 2013 15:14:19 +0200
Subject: [PATCH] clk: fix typos
Message-ID: <1372511659-26936-1-git-send-email-pmeerw@pmeerw.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/clk/Kconfig |  2 +-
 drivers/clk/clk.c   | 15 ++++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 0357ac4..1ba18f9 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -27,7 +27,7 @@ config COMMON_CLK_DEBUG
 	bool "DebugFS representation of clock tree"
 	select DEBUG_FS
 	---help---
-	  Creates a directory hierchy in debugfs for visualizing the clk
+	  Creates a directory hierarchy in debugfs for visualizing the clk
 	  tree structure.  Each directory contains read-only members
 	  that export information specific to that clk node: clk_rate,
 	  clk_flags, clk_prepare_count, clk_enable_count &
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 1144e8c..d6b45b6 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -702,7 +702,7 @@ void __clk_unprepare(struct clk *clk)
 
 /**
  * clk_unprepare - undo preparation of a clock source
- * @clk: the clk being unprepare
+ * @clk: the clk being unprepared
  *
  * clk_unprepare may sleep, which differentiates it from clk_disable.  In a
  * simple case, clk_unprepare can be used instead of clk_disable to gate a clk
@@ -869,6 +869,7 @@ EXPORT_SYMBOL_GPL(clk_enable);
 /**
  * __clk_round_rate - round the given rate for a clk
  * @clk: round the rate of this clock
+ * @rate: the rate which is to be rounded
  *
  * Caller must hold prepare_lock.  Useful for clk_ops such as .set_rate
  */
@@ -956,7 +957,7 @@ static int __clk_notify(struct clk *clk, unsigned long msg,
  *
  * Walks the subtree of clks starting with clk and recalculates rates as it
  * goes.  Note that if a clk does not implement the .recalc_rate callback then
- * it is assumed that the clock will take on the rate of it's parent.
+ * it is assumed that the clock will take on the rate of its parent.
  *
  * clk_recalc_rates also propagates the POST_RATE_CHANGE notification,
  * if necessary.
@@ -1026,7 +1027,7 @@ EXPORT_SYMBOL_GPL(clk_get_rate);
  * pre-rate change notifications and returns early if no clks in the
  * subtree have subscribed to the notifications.  Note that if a clk does not
  * implement the .recalc_rate callback then it is assumed that the clock will
- * take on the rate of it's parent.
+ * take on the rate of its parent.
  *
  * Caller must hold prepare_lock.
  */
@@ -1198,7 +1199,7 @@ static void clk_change_rate(struct clk *clk)
  * outcome of clk's .round_rate implementation.  If *parent_rate is unchanged
  * after calling .round_rate then upstream parent propagation is ignored.  If
  * *parent_rate comes back with a new rate for clk's parent then we propagate
- * up to clk's parent and set it's rate.  Upward propagation will continue
+ * up to clk's parent and set its rate.  Upward propagation will continue
  * until either a clk does not support the CLK_SET_RATE_PARENT flag or
  * .round_rate stops requesting changes to clk's parent_rate.
  *
@@ -1449,7 +1450,7 @@ static int __clk_set_parent(struct clk *clk, struct clk *parent, u8 p_index)
  * @clk: the mux clk whose input we are switching
  * @parent: the new input to clk
  *
- * Re-parent clk to use parent as it's new input source.  If clk has the
+ * Re-parent clk to use parent as its new input source.  If clk has the
  * CLK_SET_PARENT_GATE flag set then clk must be gated for this
  * operation to succeed.  After successfully changing clk's parent
  * clk_set_parent will update the clk topology, sysfs topology and
@@ -1650,7 +1651,7 @@ int __clk_init(struct device *dev, struct clk *clk)
 	 * The .init callback is not used by any of the basic clock types, but
 	 * exists for weird hardware that must perform initialization magic.
 	 * Please consider other ways of solving initialization problems before
-	 * using this callback, as it's use is discouraged.
+	 * using this callback, as its use is discouraged.
 	 */
 	if (clk->ops->init)
 		clk->ops->init(clk->hw);
@@ -1677,7 +1678,7 @@ out:
  * very large numbers of clocks that need to be statically initialized.  It is
  * a layering violation to include clk-private.h from any code which implements
  * a clock's .ops; as such any statically initialized clock data MUST be in a
- * separate C file from the logic that implements it's operations.  Returns 0
+ * separate C file from the logic that implements its operations.  Returns 0
  * on success, otherwise an error code.
  */
 struct clk *__clk_register(struct device *dev, struct clk_hw *hw)
-- 
1.8.3.1
