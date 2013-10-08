From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue,  8 Oct 2013 16:47:45 +0530
Subject: [PATCH 07/10] clk: mvebu: Staticize of_cpu_clk_setup
In-Reply-To: <1381231068-6053-1-git-send-email-sachin.kamat@linaro.org>
References: <1381231068-6053-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1381231068-6053-7-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'of_cpu_clk_setup' is used only in this file. Make it static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/clk/mvebu/clk-cpu.c |    2 +-
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
1.7.9.5
