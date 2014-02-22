From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 22 Feb 2014 22:35:57 +0100
Subject: [PATCH 5/7] ARM: dt: sun5i: Add A13 SPI controller nodes
In-Reply-To: <1393104959-12831-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1393104959-12831-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1393104959-12831-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A13 has 3 SPI controllers compatible with the one found in the A10. Add
them in the DT.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a13.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 24cd86cb..7102d12 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -298,6 +298,39 @@
 		#size-cells = <1>;
 		ranges;
 
+		spi0: spi at 01c05000 {
+			compatible = "allwinner,sun4i-a10-spi";
+			reg = <0x01c05000 0x1000>;
+			interrupts = <10>;
+			clocks = <&ahb_gates 20>, <&spi0_clk>;
+			clock-names = "ahb", "mod";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		spi1: spi at 01c06000 {
+			compatible = "allwinner,sun4i-a10-spi";
+			reg = <0x01c06000 0x1000>;
+			interrupts = <11>;
+			clocks = <&ahb_gates 21>, <&spi1_clk>;
+			clock-names = "ahb", "mod";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		spi2: spi at 01c17000 {
+			compatible = "allwinner,sun4i-a10-spi";
+			reg = <0x01c17000 0x1000>;
+			interrupts = <12>;
+			clocks = <&ahb_gates 22>, <&spi2_clk>;
+			clock-names = "ahb", "mod";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		intc: interrupt-controller at 01c20400 {
 			compatible = "allwinner,sun4i-ic";
 			reg = <0x01c20400 0x400>;
-- 
1.9.0
