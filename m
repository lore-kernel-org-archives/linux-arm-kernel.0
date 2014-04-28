From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 28 Apr 2014 20:26:21 +0100
Subject: [PATCH 05/97] ARM: l2c: remove unnecessary UL-suffix to mask values
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Message-ID: <E1WerC1-0007VG-DU@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

They're u32, they're not unsigned long.  The UL suffix is not required
here.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-bcm/bcm_5301x.c     | 2 +-
 arch/arm/mach-highbank/highbank.c | 2 +-
 arch/arm/mach-imx/mach-vf610.c    | 2 +-
 arch/arm/mach-imx/system.c        | 2 +-
 arch/arm/mach-mvebu/board-v7.c    | 2 +-
 arch/arm/mach-rockchip/rockchip.c | 2 +-
 arch/arm/mach-socfpga/socfpga.c   | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-bcm/bcm_5301x.c b/arch/arm/mach-bcm/bcm_5301x.c
index edff69761e04..6bc9c31b1b0b 100644
--- a/arch/arm/mach-bcm/bcm_5301x.c
+++ b/arch/arm/mach-bcm/bcm_5301x.c
@@ -45,7 +45,7 @@ static void __init bcm5301x_init_early(void)
 
 static void __init bcm5301x_dt_init(void)
 {
-	l2x0_of_init(0, ~0UL);
+	l2x0_of_init(0, ~0);
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index c7de89b263dd..38e1dc3b4c6e 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -69,7 +69,7 @@ static void __init highbank_init_irq(void)
 	if (IS_ENABLED(CONFIG_CACHE_L2X0) &&
 	    of_find_compatible_node(NULL, NULL, "arm,pl310-cache")) {
 		highbank_smc1(0x102, 0x1);
-		l2x0_of_init(0, ~0UL);
+		l2x0_of_init(0, ~0);
 		outer_cache.disable = highbank_l2x0_disable;
 	}
 }
diff --git a/arch/arm/mach-imx/mach-vf610.c b/arch/arm/mach-imx/mach-vf610.c
index 2d8aef5a6efa..6288a9690e78 100644
--- a/arch/arm/mach-imx/mach-vf610.c
+++ b/arch/arm/mach-imx/mach-vf610.c
@@ -22,7 +22,7 @@ static void __init vf610_init_machine(void)
 
 static void __init vf610_init_irq(void)
 {
-	l2x0_of_init(0, ~0UL);
+	l2x0_of_init(0, ~0);
 	irqchip_init();
 }
 
diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
index 5e3027d3692f..c6571f1de9fd 100644
--- a/arch/arm/mach-imx/system.c
+++ b/arch/arm/mach-imx/system.c
@@ -145,6 +145,6 @@ void __init imx_init_l2cache(void)
 	of_node_put(np);
 
 out:
-	l2x0_of_init(0, ~0UL);
+	l2x0_of_init(0, ~0);
 }
 #endif
diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 333fca8fdc41..c6bd79f64744 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -60,7 +60,7 @@ static void __init mvebu_timer_and_clk_init(void)
 	coherency_init();
 	BUG_ON(mvebu_mbus_dt_init());
 #ifdef CONFIG_CACHE_L2X0
-	l2x0_of_init(0, ~0UL);
+	l2x0_of_init(0, ~0);
 #endif
 
 	if (of_machine_is_compatible("marvell,armada375"))
diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
index d211d6fa0d98..d252efe3747b 100644
--- a/arch/arm/mach-rockchip/rockchip.c
+++ b/arch/arm/mach-rockchip/rockchip.c
@@ -26,7 +26,7 @@
 
 static void __init rockchip_dt_init(void)
 {
-	l2x0_of_init(0, ~0UL);
+	l2x0_of_init(0, ~0);
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index d86231e11b34..9bbb8177f247 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -100,7 +100,7 @@ static void socfpga_cyclone5_restart(enum reboot_mode mode, const char *cmd)
 
 static void __init socfpga_cyclone5_init(void)
 {
-	l2x0_of_init(0, ~0UL);
+	l2x0_of_init(0, ~0);
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
1.8.3.1
