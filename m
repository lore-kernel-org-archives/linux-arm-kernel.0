From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Sep 2015 10:48:46 +0200
Subject: [PATCH 1/5] ARM: sunxi: Add R8 support
In-Reply-To: <1442566130-3497-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1442566130-3497-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1442566130-3497-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The R8 is a new Allwinner SoC based on the A13. While both are very
similar, there's still a few differences. Introduce a new compatible to
deal with them.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/sunxi.c   | 3 ++-
 drivers/clk/sunxi/clk-sunxi.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index 65bab2876343..8583a9ca86bd 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -26,10 +26,11 @@ static const char * const sunxi_board_dt_compat[] = {
 	"allwinner,sun4i-a10",
 	"allwinner,sun5i-a10s",
 	"allwinner,sun5i-a13",
+	"allwinner,sun5i-r8",
 	NULL,
 };
 
-DT_MACHINE_START(SUNXI_DT, "Allwinner A1X (Device Tree)")
+DT_MACHINE_START(SUNXI_DT, "Allwinner sun4i/sun5i Families")
 	.dt_compat	= sunxi_board_dt_compat,
 	.init_late	= sunxi_dt_cpufreq_init,
 MACHINE_END
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 413070d07b3f..9c79af0c03b2 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1196,6 +1196,7 @@ static void __init sun5i_init_clocks(struct device_node *node)
 }
 CLK_OF_DECLARE(sun5i_a10s_clk_init, "allwinner,sun5i-a10s", sun5i_init_clocks);
 CLK_OF_DECLARE(sun5i_a13_clk_init, "allwinner,sun5i-a13", sun5i_init_clocks);
+CLK_OF_DECLARE(sun5i_r8_clk_init, "allwinner,sun5i-r8", sun5i_init_clocks);
 CLK_OF_DECLARE(sun7i_a20_clk_init, "allwinner,sun7i-a20", sun5i_init_clocks);
 
 static const char *sun6i_critical_clocks[] __initdata = {
-- 
2.5.1
