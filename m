From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 17:52:41 +0100
Subject: [PATCH 5/7] clk: mvebu: rename *-core-clocks to *-core-clock
In-Reply-To: <1353343963-23034-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353343963-23034-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353343963-23034-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the existing clock drivers have a compatible string that ends
with "-clock", so change the compatible strings of the mvebu
clk-core.c driver to not have the final 's' in '*-core-clocks'.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/clock/mvebu-core-clock.txt |   12 ++++++------
 arch/arm/boot/dts/armada-370.dtsi                  |    2 +-
 arch/arm/boot/dts/armada-xp.dtsi                   |    2 +-
 arch/arm/boot/dts/dove.dtsi                        |    2 +-
 arch/arm/boot/dts/kirkwood.dtsi                    |    2 +-
 drivers/clk/mvebu/clk-core.c                       |   10 +++++-----
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
index ffb3d69..1e66294 100644
--- a/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
+++ b/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
@@ -19,11 +19,11 @@ The following is a list of provided IDs and clock names on Kirkwood and Dove:
 
 Required properties:
 - compatible : shall be one of the following:
-	"marvell,armada-370-core-clocks" - For Armada 370 SoC core clocks
-	"marvell,armada-xp-core-clocks" - For Armada XP SoC core clocks
-	"marvell,dove-core-clocks" - for Dove SoC core clocks
-	"marvell,kirkwood-core-clocks" - for Kirkwood SoC (except mv88f6180)
-	"marvell,mv88f6180-core-clocks" - for Kirkwood MV88f6180 SoC
+	"marvell,armada-370-core-clock" - For Armada 370 SoC core clocks
+	"marvell,armada-xp-core-clock" - For Armada XP SoC core clocks
+	"marvell,dove-core-clock" - for Dove SoC core clocks
+	"marvell,kirkwood-core-clock" - for Kirkwood SoC (except mv88f6180)
+	"marvell,mv88f6180-core-clock" - for Kirkwood MV88f6180 SoC
 - reg : shall be the register address of the Sample-At-Reset (SAR) register
 - #clock-cells : from common clock binding; shall be set to 1
 
@@ -34,7 +34,7 @@ Optional properties:
 Example:
 
 core_clk: core-clocks at d0214 {
-	compatible = "marvell,dove-core-clocks";
+	compatible = "marvell,dove-core-clock";
 	reg = <0xd0214 0x4>;
 	#clock-cells = <1>;
 };
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index d4fac86..1ed9e5c 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -83,7 +83,7 @@
 		};
 
 		coreclk: mvebu-sar at d0018230 {
-			compatible = "marvell,armada-370-core-clocks";
+			compatible = "marvell,armada-370-core-clock";
 			reg = <0xd0018230 0x08>;
 			#clock-cells = <1>;
 		};
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index a3824ac..d05515c 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -55,7 +55,7 @@
 		};
 
 		coreclk: mvebu-sar at d0018230 {
-			compatible = "marvell,armada-xp-core-clocks";
+			compatible = "marvell,armada-xp-core-clock";
 			reg = <0xd0018230 0x08>;
 			#clock-cells = <1>;
 		};
diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 8c8ab621..b524ee3 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -32,7 +32,7 @@
 		};
 
 		core_clk: core-clocks at d0214 {
-			compatible = "marvell,dove-core-clocks";
+			compatible = "marvell,dove-core-clock";
 			reg = <0xd0214 0x4>;
 			#clock-cells = <1>;
 		};
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 46bfa3c..0e94750 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -24,7 +24,7 @@
 		#size-cells = <1>;
 
 		core_clk: core-clocks at 10030 {
-                	compatible = "marvell,kirkwood-core-clocks";
+			compatible = "marvell,kirkwood-core-clock";
 			reg = <0x10030 0x4>;
 	        	#clock-cells = <1>;
 		};
diff --git a/drivers/clk/mvebu/clk-core.c b/drivers/clk/mvebu/clk-core.c
index 7e715ae..69056a7 100644
--- a/drivers/clk/mvebu/clk-core.c
+++ b/drivers/clk/mvebu/clk-core.c
@@ -634,28 +634,28 @@ static const struct core_clocks mv88f6180_core_clocks = {
 static const __initdata struct of_device_id clk_core_match[] = {
 #ifdef CONFIG_MACH_ARMADA_370_XP
 	{
-		.compatible = "marvell,armada-370-core-clocks",
+		.compatible = "marvell,armada-370-core-clock",
 		.data = &armada_370_core_clocks,
 	},
 	{
-		.compatible = "marvell,armada-xp-core-clocks",
+		.compatible = "marvell,armada-xp-core-clock",
 		.data = &armada_xp_core_clocks,
 	},
 #endif
 #ifdef CONFIG_ARCH_DOVE
 	{
-		.compatible = "marvell,dove-core-clocks",
+		.compatible = "marvell,dove-core-clock",
 		.data = &dove_core_clocks,
 	},
 #endif
 
 #ifdef CONFIG_ARCH_KIRKWOOD
 	{
-		.compatible = "marvell,kirkwood-core-clocks",
+		.compatible = "marvell,kirkwood-core-clock",
 		.data = &kirkwood_core_clocks,
 	},
 	{
-		.compatible = "marvell,mv88f6180-core-clocks",
+		.compatible = "marvell,mv88f6180-core-clock",
 		.data = &mv88f6180_core_clocks,
 	},
 #endif
-- 
1.7.9.5
