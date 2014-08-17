From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 17 Aug 2014 11:52:14 +0800
Subject: [PATCH 08/12] ARM: dts: sun8i: Add mmc controller nodes
In-Reply-To: <1408247538-16950-1-git-send-email-wens@csie.org>
References: <1408247538-16950-1-git-send-email-wens@csie.org>
Message-ID: <1408247538-16950-9-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for the 3 mmc controllers found on A23 SoCs to the sun8i DTSI.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 348fb07..62144e2 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -211,6 +211,39 @@
 		#size-cells = <1>;
 		ranges;
 
+		mmc0: mmc at 01c0f000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c0f000 0x1000>;
+			clocks = <&ahb1_gates 8>, <&mmc0_clk>;
+			clock-names = "ahb", "mmc";
+			resets = <&ahb1_rst 8>;
+			reset-names = "ahb";
+			interrupts = <0 60 4>;
+			status = "disabled";
+		};
+
+		mmc1: mmc at 01c10000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c10000 0x1000>;
+			clocks = <&ahb1_gates 9>, <&mmc1_clk>;
+			clock-names = "ahb", "mmc";
+			resets = <&ahb1_rst 9>;
+			reset-names = "ahb";
+			interrupts = <0 61 4>;
+			status = "disabled";
+		};
+
+		mmc2: mmc at 01c11000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c11000 0x1000>;
+			clocks = <&ahb1_gates 10>, <&mmc2_clk>;
+			clock-names = "ahb", "mmc";
+			resets = <&ahb1_rst 10>;
+			reset-names = "ahb";
+			interrupts = <0 62 4>;
+			status = "disabled";
+		};
+
 		pio: pinctrl at 01c20800 {
 			compatible = "allwinner,sun8i-a23-pinctrl";
 			reg = <0x01c20800 0x400>;
-- 
2.1.0
