From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 22 Dec 2016 18:25:00 +0100
Subject: [PATCH 5/6] ARM64: dts: marvell: Add pinctrl nodes for Armada 3700
In-Reply-To: <20161222172501.16121-1-gregory.clement@free-electrons.com>
References: <20161222172501.16121-1-gregory.clement@free-electrons.com>
Message-ID: <20161222172501.16121-6-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the nodes for the two pin controller present in the Armada 37xx SoCs.

Initially the node was named gpio1 using the same name that for the
register range in the datasheet. However renaming it pinctr_nb (nb for
North Bridge) makes more sens.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 30 +++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 926a4024c3dd..682ec009121c 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -157,16 +157,40 @@
 				#clock-cells = <1>;
 			};
 
-			gpio1: gpio at 13800 {
-				compatible = "marvell,mvebu-gpio-3700",
+			pinctrl_nb: pinctrl-nb at 13800 {
+				compatible = "marvell,armada3710-nb-pinctrl",
 				"syscon", "simple-mfd";
-				reg = <0x13800 0x500>;
+				reg = <0x13800 0x100>, <0x13C00 0x20>;
+				interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
 
 				xtalclk: xtal-clk {
 					compatible = "marvell,armada-3700-xtal-clock";
 					clock-output-names = "xtal";
 					#clock-cells = <0>;
 				};
+				};
+			};
+
+			pinctrl_sb: pinctrl-sb at 18800 {
+				compatible = "marvell,armada3710-sb-pinctrl",
+				"syscon", "simple-mfd";
+				reg = <0x18800 0x100>, <0x18C00 0x20>;
+				interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			eth0: ethernet at 30000 {
-- 
2.11.0
