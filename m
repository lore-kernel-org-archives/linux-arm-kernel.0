From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 19 Aug 2014 00:51:50 +0800
Subject: [PATCH v2 1/2] ARM: dts: sun8i: Add i2c controller nodes
In-Reply-To: <1408380711-26308-1-git-send-email-wens@csie.org>
References: <1408380711-26308-1-git-send-email-wens@csie.org>
Message-ID: <1408380711-26308-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for the 3 i2c controllers found on A23 SoCs to the sun8i DTSI.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 9386d1f..2ec86d36 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -387,6 +387,39 @@
 			status = "disabled";
 		};
 
+		i2c0: i2c at 01c2ac00 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2ac00 0x400>;
+			interrupts = <0 6 4>;
+			clocks = <&apb2_gates 0>;
+			resets = <&apb2_rst 0>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c1: i2c at 01c2b000 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2b000 0x400>;
+			interrupts = <0 7 4>;
+			clocks = <&apb2_gates 1>;
+			resets = <&apb2_rst 1>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c2: i2c at 01c2b400 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2b400 0x400>;
+			interrupts = <0 8 4>;
+			clocks = <&apb2_gates 2>;
+			resets = <&apb2_rst 2>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		gic: interrupt-controller at 01c81000 {
 			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
 			reg = <0x01c81000 0x1000>,
-- 
2.1.0
