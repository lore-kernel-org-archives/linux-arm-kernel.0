From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 10 Jul 2011 21:06:36 +0900
Subject: [PATCH 2/2] clk: Provide a dummy clk_unregister()
In-Reply-To: <1310299596-26137-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1310299596-26137-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1310299596-26137-2-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even though unregistration is not actually supported by the clk API it is
still useful to provide a clk_unregister() so that drivers can implement
their unregistration code. This saves having to go back later and update
them once unregistration is possible.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/clk.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index 2ca4f66..df5c64f 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -149,6 +149,21 @@ extern struct clk_hw_ops clk_gate_ops;
 struct clk *clk_register(struct clk_hw_ops *ops, struct clk_hw *hw,
 			 const char *name);
 
+/**
+ * clk_unregister - remove a clock
+ *
+ * @clk: clock to unregister
+ *
+ * Remove a clock from the clk subsystem.  This is currently not
+ * implemented but is provided to allow unregistration code to be
+ * written in drivers ready for use when an implementation is
+ * provided.
+ */
+static inline int clk_unregister(struct clk *clk)
+{
+	return -ENOTSUPP;
+}
+
 #else /* !CONFIG_GENERIC_CLK */
 
 /*
-- 
1.7.5.4
