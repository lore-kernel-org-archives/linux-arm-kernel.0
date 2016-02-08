From: arnd@arndb.de (Arnd Bergmann)
Date: Mon,  8 Feb 2016 15:39:09 +0100
Subject: [PATCH] clk: socfpga: fix __init annotation
Message-ID: <1454942356-2783135-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clang found a bug with the __socfpga_pll_init definition:

drivers/clk/socfpga/clk-pll-a10.c:77:15: error: '__section__' attribute only applies to functions and
      global variables

This moves the __init annotation to the right place so the function
actually gets discarded.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/socfpga/clk-pll-a10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/socfpga/clk-pll-a10.c b/drivers/clk/socfpga/clk-pll-a10.c
index 402d630bd531..35fabe1a32c3 100644
--- a/drivers/clk/socfpga/clk-pll-a10.c
+++ b/drivers/clk/socfpga/clk-pll-a10.c
@@ -74,7 +74,7 @@ static struct clk_ops clk_pll_ops = {
 	.get_parent = clk_pll_get_parent,
 };
 
-static struct __init clk * __socfpga_pll_init(struct device_node *node,
+static struct clk * __init __socfpga_pll_init(struct device_node *node,
 	const struct clk_ops *ops)
 {
 	u32 reg;
-- 
2.7.0
