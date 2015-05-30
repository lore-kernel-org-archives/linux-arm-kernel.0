From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 30 May 2015 16:55:01 +0200
Subject: [PATCH v2 1/6] ARM: sunxi: Add Machine support for A33
In-Reply-To: <1432997706-20172-1-git-send-email-hdegoede@redhat.com>
References: <1432997706-20172-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1432997706-20172-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vishnu Patekar <vishnupatekar0510@gmail.com>

Add machine support for the Allwinner A33 quad core cortex-a7 based SoC,
which is similar to the A23 SoC.

Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Do not rename the allwinner,sun8i-a23 compatible to allwinner,sun8i
 instead add a new allwinner,sun8i-a33 compatible
-Squash in changes to use sun6i_init_clocks for A33
-Do *not* rename the cpu method to "allwinner,sun8i"
---
 Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
 arch/arm/mach-sunxi/sunxi.c                     | 1 +
 drivers/clk/sunxi/clk-sunxi.c                   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
index 3cb4b94..67da205 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.txt
+++ b/Documentation/devicetree/bindings/arm/sunxi.txt
@@ -9,5 +9,6 @@ using one of the following compatible strings:
   allwinner,sun6i-a31
   allwinner,sun7i-a20
   allwinner,sun8i-a23
+  allwinner,sun8i-a33
   allwinner,sun8i-h3
   allwinner,sun9i-a80
diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index 8270902..65bab28 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -67,6 +67,7 @@ MACHINE_END
 
 static const char * const sun8i_board_dt_compat[] = {
 	"allwinner,sun8i-a23",
+	"allwinner,sun8i-a33",
 	"allwinner,sun8i-h3",
 	NULL,
 };
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 9a82f17..abf7b37 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1391,6 +1391,7 @@ static void __init sun6i_init_clocks(struct device_node *node)
 CLK_OF_DECLARE(sun6i_a31_clk_init, "allwinner,sun6i-a31", sun6i_init_clocks);
 CLK_OF_DECLARE(sun6i_a31s_clk_init, "allwinner,sun6i-a31s", sun6i_init_clocks);
 CLK_OF_DECLARE(sun8i_a23_clk_init, "allwinner,sun8i-a23", sun6i_init_clocks);
+CLK_OF_DECLARE(sun8i_a33_clk_init, "allwinner,sun8i-a33", sun6i_init_clocks);
 
 static void __init sun9i_init_clocks(struct device_node *node)
 {
-- 
2.4.1
