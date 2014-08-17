From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 17 Aug 2014 11:52:12 +0800
Subject: [PATCH 06/12] ARM: dts: sun8i: Add mmc clocks to the dtsi
In-Reply-To: <1408247538-16950-1-git-send-email-wens@csie.org>
References: <1408247538-16950-1-git-send-email-wens@csie.org>
Message-ID: <1408247538-16950-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MMC module clocks on sun8i are the same as those found on
previous Allwinner SoCs, module 0 clocks.

This patch adds the clocks nodes to the dtsi with existing drivers.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 25bae1f..2d4c1b4 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -179,6 +179,30 @@
 					"apb2_uart1", "apb2_uart2",
 					"apb2_uart3", "apb2_uart4";
 		};
+
+		mmc0_clk: clk at 01c20088 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod0-clk";
+			reg = <0x01c20088 0x4>;
+			clocks = <&osc24M>, <&pll6>;
+			clock-output-names = "mmc0";
+		};
+
+		mmc1_clk: clk at 01c2008c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod0-clk";
+			reg = <0x01c2008c 0x4>;
+			clocks = <&osc24M>, <&pll6>;
+			clock-output-names = "mmc1";
+		};
+
+		mmc2_clk: clk at 01c20090 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod0-clk";
+			reg = <0x01c20090 0x4>;
+			clocks = <&osc24M>, <&pll6>;
+			clock-output-names = "mmc2";
+		};
 	};
 
 	soc at 01c00000 {
-- 
2.1.0
