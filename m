From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 7 Nov 2013 16:59:33 +0800
Subject: [PATCH] clk: mvebu: staticize of_cpu_clk_setup
Message-ID: <1383814773-5231-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This symbol is used only in this file. The patch fix the following
sparse warning:
warning: symbol 'of_cpu_clk_setup' was not declared. Should it be static?

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/clk/mvebu/clk-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mvebu/clk-cpu.c b/drivers/clk/mvebu/clk-cpu.c
index 1466865..8ebf757 100644
--- a/drivers/clk/mvebu/clk-cpu.c
+++ b/drivers/clk/mvebu/clk-cpu.c
@@ -101,7 +101,7 @@ static const struct clk_ops cpu_ops = {
 	.set_rate = clk_cpu_set_rate,
 };
 
-void __init of_cpu_clk_setup(struct device_node *node)
+static void __init of_cpu_clk_setup(struct device_node *node)
 {
 	struct cpu_clk *cpuclk;
 	void __iomem *clock_complex_base = of_iomap(node, 0);
-- 
1.8.4.2
