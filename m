From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 23 Oct 2012 12:28:10 -0600
Subject: [PATCH 1/3] ARM: timer: fix checkpatch warnings
Message-ID: <1351016892-21211-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This prevents checkpatch complaining when this file is moved in a later
patch.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/timer.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
index e5deb54..026bad4 100644
--- a/arch/arm/mach-tegra/timer.c
+++ b/arch/arm/mach-tegra/timer.c
@@ -185,8 +185,7 @@ static void __init tegra_init_timer(void)
 
 	clk = clk_get_sys("timer", NULL);
 	if (IS_ERR(clk)) {
-		pr_warn("Unable to get timer clock."
-			" Assuming 12Mhz input clock.\n");
+		pr_warn("Unable to get timer clock. Assuming 12Mhz input clock.\n");
 		rate = 12000000;
 	} else {
 		clk_prepare_enable(clk);
@@ -226,13 +225,13 @@ static void __init tegra_init_timer(void)
 
 	if (clocksource_mmio_init(timer_reg_base + TIMERUS_CNTR_1US,
 		"timer_us", 1000000, 300, 32, clocksource_mmio_readl_up)) {
-		printk(KERN_ERR "Failed to register clocksource\n");
+		pr_err("Failed to register clocksource\n");
 		BUG();
 	}
 
 	ret = setup_irq(tegra_timer_irq.irq, &tegra_timer_irq);
 	if (ret) {
-		printk(KERN_ERR "Failed to register timer IRQ: %d\n", ret);
+		pr_err("Failed to register timer IRQ: %d\n", ret);
 		BUG();
 	}
 
-- 
1.7.0.4
