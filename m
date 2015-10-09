From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  9 Oct 2015 09:42:53 +0100
Subject: [PATCH v3 1/5] ARM: sunxi: Add R8 support
In-Reply-To: <1444380177-15302-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1444380177-15302-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1444380177-15302-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The R8 is a new Allwinner SoC based on the A13. While both are very
similar, there's still a few differences. Introduce a new compatible to
deal with them.

In order to have a consistent naming, instead of mentionning the allwinner
A series as the machine name, switch to sun4i/sun5i like what is done for
the other families.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
---
 Documentation/arm/sunxi/README                  | 2 +-
 Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
 arch/arm/mach-sunxi/sunxi.c                     | 3 ++-
 drivers/clk/sunxi/clk-sunxi.c                   | 1 +
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm/sunxi/README b/Documentation/arm/sunxi/README
index 5e38e1582f95..430d279a8df3 100644
--- a/Documentation/arm/sunxi/README
+++ b/Documentation/arm/sunxi/README
@@ -25,7 +25,7 @@ SunXi family
         + Datasheet
           http://dl.linux-sunxi.org/A10s/A10s%20Datasheet%20-%20v1.20%20%282012-03-27%29.pdf
 
-      - Allwinner A13 (sun5i)
+      - Allwinner A13 / R8 (sun5i)
         + Datasheet
 	  http://dl.linux-sunxi.org/A13/A13%20Datasheet%20-%20v1.12%20%282012-03-29%29.pdf
         + User Manual
diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
index 67da20539540..bb9b0faa919d 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.txt
+++ b/Documentation/devicetree/bindings/arm/sunxi.txt
@@ -6,6 +6,7 @@ using one of the following compatible strings:
   allwinner,sun4i-a10
   allwinner,sun5i-a10s
   allwinner,sun5i-a13
+  allwinner,sun5i-r8
   allwinner,sun6i-a31
   allwinner,sun7i-a20
   allwinner,sun8i-a23
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
2.5.3
