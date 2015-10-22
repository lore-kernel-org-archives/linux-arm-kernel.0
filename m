From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Fri, 23 Oct 2015 07:46:15 +0800
Subject: [PATCH v2 1/3] ARM: sunxi: Introduce Allwinner for A83T support
In-Reply-To: <1445557577-27383-1-git-send-email-vishnupatekar0510@gmail.com>
References: <1445557577-27383-1-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <1445557577-27383-2-git-send-email-vishnupatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A83T is octa-core cortex-a7 based SoC.
It's clock control unit and prcm, pinmux are different from previous sun8i
series.
Its processor cores are arragned in two clusters 4 cores each,
similar to A80.

Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
---
 Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
 arch/arm/mach-sunxi/sunxi.c                     | 1 +
 drivers/clk/sunxi/clk-sunxi.c                   | 6 ++++++
 3 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
index bb9b0faa..7e79fcc 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.txt
+++ b/Documentation/devicetree/bindings/arm/sunxi.txt
@@ -11,5 +11,6 @@ using one of the following compatible strings:
   allwinner,sun7i-a20
   allwinner,sun8i-a23
   allwinner,sun8i-a33
+  allwinner,sun8i-a83t
   allwinner,sun8i-h3
   allwinner,sun9i-a80
diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index 8583a9c..d64e92d 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -69,6 +69,7 @@ MACHINE_END
 static const char * const sun8i_board_dt_compat[] = {
 	"allwinner,sun8i-a23",
 	"allwinner,sun8i-a33",
+	"allwinner,sun8i-a83t",
 	"allwinner,sun8i-h3",
 	NULL,
 };
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 9c79af0c..1632201 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1213,6 +1213,12 @@ CLK_OF_DECLARE(sun6i_a31s_clk_init, "allwinner,sun6i-a31s", sun6i_init_clocks);
 CLK_OF_DECLARE(sun8i_a23_clk_init, "allwinner,sun8i-a23", sun6i_init_clocks);
 CLK_OF_DECLARE(sun8i_a33_clk_init, "allwinner,sun8i-a33", sun6i_init_clocks);
 
+static void __init sun8i_a83t_init_clocks(struct device_node *node)
+{
+	sunxi_init_clocks(NULL, 0);
+}
+CLK_OF_DECLARE(sun8i_a83t_clk_init, "allwinner,sun8i-a83t", sun8i_a83t_init_clocks);
+
 static void __init sun9i_init_clocks(struct device_node *node)
 {
 	sunxi_init_clocks(NULL, 0);
-- 
1.9.1
