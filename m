From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 21 Mar 2012 20:01:21 +0000
Subject: [PATCH 3/4] clk: Provide dummy clk_unregister()
In-Reply-To: <1332360082-25092-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1332360082-25092-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1332360082-25092-3-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While there's no actual implementation behind it having the call to use
in drivers makes them feel neater from a driver author point of view. An
actual implementation can wait for someone who needs to use the function
in a real system.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/clk/clk.c            |   12 ++++++++++++
 include/linux/clk-provider.h |    1 +
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 33ef0df..31419ca 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1344,6 +1344,18 @@ struct clk *clk_register(struct device *dev, const char *name,
 }
 EXPORT_SYMBOL_GPL(clk_register);
 
+/**
+ * clk_unregister - unregister a currently registered clock
+ * @clk: clock to unregister
+ *
+ * Currently unimplemented.
+ */
+int clk_unregister(struct clk *clk)
+{
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(clk_unregister);
+
 /***        clk rate change notifiers        ***/
 
 /**
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 340acbc..57c0bd1 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -275,6 +275,7 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
 struct clk *clk_register(struct device *dev, const char *name,
 		const struct clk_ops *ops, struct clk_hw *hw,
 		const char **parent_names, u8 num_parents, unsigned long flags);
+int clk_unregister(struct clk *clk);
 
 /* helper functions */
 const char *__clk_get_name(struct clk *clk);
-- 
1.7.9.1
