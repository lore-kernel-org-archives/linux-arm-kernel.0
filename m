From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  9 Jan 2014 18:20:01 +0100
Subject: [PATCH 3/5] ARM: sun6i: Enable the I2C controllers
In-Reply-To: <1389288003-23187-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1389288003-23187-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1389288003-23187-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 has 4 I2C controllers that are the same than the one in the
other Allwinner SoCs, except for the fact that they are asserted in
reset by the reset unit.

Add these i2c controllers to the DTSI.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 5256ad9..7dac496 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -312,6 +312,46 @@
 			status = "disabled";
 		};
 
+		i2c0: i2c at 01c2ac00 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2ac00 0x400>;
+			interrupts = <0 6 4>;
+			clocks = <&apb2_gates 0>;
+			clock-frequency = <100000>;
+			resets = <&apb2_rst 0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c at 01c2b000 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2b000 0x400>;
+			interrupts = <0 7 4>;
+			clocks = <&apb2_gates 1>;
+			clock-frequency = <100000>;
+			resets = <&apb2_rst 1>;
+			status = "disabled";
+		};
+
+		i2c2: i2c at 01c2b400 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2b400 0x400>;
+			interrupts = <0 8 4>;
+			clocks = <&apb2_gates 2>;
+			clock-frequency = <100000>;
+			resets = <&apb2_rst 2>;
+			status = "disabled";
+		};
+
+		i2c3: i2c at 01c2b800 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2b800 0x400>;
+			interrupts = <0 9 4>;
+			clocks = <&apb2_gates 3>;
+			clock-frequency = <100000>;
+			resets = <&apb2_rst 3>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller at 01c81000 {
 			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
 			reg = <0x01c81000 0x1000>,
-- 
1.8.4.2
