From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Tue, 24 Apr 2018 17:55:02 +0200
Subject: [PATCH v5 1/2] ARM: dts: sun8i: a23/a33: declare NAND pins
In-Reply-To: <20180424155503.19518-1-miquel.raynal@bootlin.com>
References: <20180424155503.19518-1-miquel.raynal@bootlin.com>
Message-ID: <20180424155503.19518-2-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declare NAND pins (bus, chip select and ready/busy) for a23/a33 SoCs.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 971f9be699a7..44f3cad3de75 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -198,6 +198,8 @@
 			clock-names = "ahb", "mod";
 			resets = <&ccu RST_BUS_NAND>;
 			reset-names = "ahb";
+			pinctrl-names = "default";
+			pinctrl-0 = <&nand_pins &nand_pins_cs0 &nand_pins_rb0>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -315,6 +317,37 @@
 				bias-pull-up;
 			};
 
+			nand_pins: nand-pins {
+				pins = "PC0", "PC1", "PC2", "PC5",
+				       "PC8", "PC9", "PC10", "PC11",
+				       "PC12", "PC13", "PC14", "PC15";
+				function = "nand0";
+			};
+
+			nand_pins_cs0: nand-pins-cs0 {
+				pins = "PC4";
+				function = "nand0";
+				bias-pull-up;
+			};
+
+			nand_pins_cs1: nand-pins-cs1 {
+				pins = "PC3";
+				function = "nand0";
+				bias-pull-up;
+			};
+
+			nand_pins_rb0: nand-pins-rb0 {
+				pins = "PC6";
+				function = "nand0";
+				bias-pull-up;
+			};
+
+			nand_pins_rb1: nand-pins-rb1 {
+				pins = "PC7";
+				function = "nand0";
+				bias-pull-up;
+			};
+
 			pwm0_pins: pwm0 {
 				pins = "PH0";
 				function = "pwm0";
-- 
2.14.1
