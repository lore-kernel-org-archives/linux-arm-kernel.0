From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 10 Jul 2011 21:06:35 +0900
Subject: [PATCH 1/2] clk: Prototype and document clk_register()
Message-ID: <1310299596-26137-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows the compiler to ensure drivers are using the correct prototype.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/clk.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index 7c26135..2ca4f66 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -136,6 +136,18 @@ extern struct clk_hw_ops clk_gate_ops;
 
 #endif /* CONFIG_GENERIC_CLK_GATE */
 
+/**
+ * clk_register - register and initialize a new clock
+ *
+ * @ops: ops for the new clock
+ * @hw: struct clk_hw to be passed to the ops of the new clock
+ * @name: name to use for the new clock
+ *
+ * Register a new clock with the clk subsytem.  Returns either a
+ * struct clk for the new clock or a NULL pointer.
+ */
+struct clk *clk_register(struct clk_hw_ops *ops, struct clk_hw *hw,
+			 const char *name);
 
 #else /* !CONFIG_GENERIC_CLK */
 
-- 
1.7.5.4
