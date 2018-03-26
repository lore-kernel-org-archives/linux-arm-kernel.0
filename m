From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Mon, 26 Mar 2018 23:28:19 +0200
Subject: [PATCH v2 1/2] arm: dts: sun8i: a23/a33: declare NAND pins
In-Reply-To: <20180326212820.20637-1-miquel.raynal@bootlin.com>
References: <20180326212820.20637-1-miquel.raynal@bootlin.com>
Message-ID: <20180326212820.20637-2-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declare NAND pins (bus, chip select and ready/busy) for a23/a33 SoCs.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 971f9be699a7..0308e8b21ea5 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -315,6 +315,33 @@
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
+			};
+
+			nand_pins_cs1: nand-pins-cs1 {
+				pins = "PC3";
+				function = "nand0";
+			};
+
+			nand_pins_rb0: nand-pins-rb0 {
+				pins = "PC6";
+				function = "nand0";
+			};
+
+			nand_pins_rb1: nand-pins-rb1 {
+				pins = "PC7";
+				function = "nand0";
+			};
+
 			pwm0_pins: pwm0 {
 				pins = "PH0";
 				function = "pwm0";
-- 
2.14.1
