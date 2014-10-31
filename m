From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 31 Oct 2014 11:05:46 +0800
Subject: [PATCH v2 1/6] ARM: dts: sun9i: Add i2c controller nodes to a80 dtsi
In-Reply-To: <1414724751-25580-1-git-send-email-wens@csie.org>
References: <1414724751-25580-1-git-send-email-wens@csie.org>
Message-ID: <1414724751-25580-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A80 has 5 i2c controllers in the main processor block.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 55 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index da680cf..3ec727d 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -426,6 +426,61 @@
 			status = "disabled";
 		};
 
+		i2c0: i2c at 07002800 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x07002800 0x400>;
+			interrupts = <0 6 4>;
+			clocks = <&apb1_gates 0>;
+			resets = <&apb1_resets 0>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c1: i2c at 07002c00 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x07002c00 0x400>;
+			interrupts = <0 7 4>;
+			clocks = <&apb1_gates 1>;
+			resets = <&apb1_resets 1>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c2: i2c at 07003000 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x07003000 0x400>;
+			interrupts = <0 8 4>;
+			clocks = <&apb1_gates 2>;
+			resets = <&apb1_resets 2>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c3: i2c at 07003400 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x07003400 0x400>;
+			interrupts = <0 9 4>;
+			clocks = <&apb1_gates 3>;
+			resets = <&apb1_resets 3>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c4: i2c at 07003800 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x07003800 0x400>;
+			interrupts = <0 10 4>;
+			clocks = <&apb1_gates 4>;
+			resets = <&apb1_resets 4>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		r_wdt: watchdog at 08001000 {
 			compatible = "allwinner,sun6i-a31-wdt";
 			reg = <0x08001000 0x20>;
-- 
2.1.1
