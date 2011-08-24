From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 24 Aug 2011 14:15:55 +0100
Subject: [PATCH 07/11] clk: Constify struct clk_hw_ops
In-Reply-To: <1314191759-16941-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20110824131324.GB16520@opensource.wolfsonmicro.com>
	<1314191759-16941-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1314191759-16941-7-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/clk/clk.c   |    4 ++--
 include/linux/clk.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 3a4d70e..1df6e23 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -16,7 +16,7 @@
 
 struct clk {
 	const char		*name;
-	struct clk_hw_ops	*ops;
+	const struct clk_hw_ops	*ops;
 	struct clk_hw		*hw;
 	unsigned int		enable_count;
 	unsigned int		prepare_count;
@@ -252,7 +252,7 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 }
 EXPORT_SYMBOL_GPL(clk_set_parent);
 
-struct clk *clk_register(struct clk_hw_ops *ops, struct clk_hw *hw,
+struct clk *clk_register(const struct clk_hw_ops *ops, struct clk_hw *hw,
 		const char *name)
 {
 	struct clk *clk;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index df5c64f..fb5e435 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -146,7 +146,7 @@ extern struct clk_hw_ops clk_gate_ops;
  * Register a new clock with the clk subsytem.  Returns either a
  * struct clk for the new clock or a NULL pointer.
  */
-struct clk *clk_register(struct clk_hw_ops *ops, struct clk_hw *hw,
+struct clk *clk_register(const struct clk_hw_ops *ops, struct clk_hw *hw,
 			 const char *name);
 
 /**
-- 
1.7.5.4
