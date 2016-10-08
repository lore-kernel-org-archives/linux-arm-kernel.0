From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat,  8 Oct 2016 16:59:38 +0800
Subject: [PATCH] clk: core: add __init decoration for CLK_OF_DECLARE_DRIVER
 function
Message-ID: <1475917178-15488-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new introduced macro CLK_OF_DECLARE_DRIVER is usually used to
declare clock driver init functions, which are mostly decorated with
__init.  Add __init decoration for CLK_OF_DECLARE_DRIVER function to
avoid causing section mismatch warnings on client clock drivers.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 include/linux/clk-provider.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index af596381fa0f..a428aec36ace 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -785,7 +785,7 @@ struct clk_hw_onecell_data {
  * routines, one at of_clk_init(), and one at platform device probe
  */
 #define CLK_OF_DECLARE_DRIVER(name, compat, fn) \
-	static void name##_of_clk_init_driver(struct device_node *np)	\
+	static void __init name##_of_clk_init_driver(struct device_node *np) \
 	{								\
 		of_node_clear_flag(np, OF_POPULATED);			\
 		fn(np);							\
-- 
1.9.1
