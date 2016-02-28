From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Sun, 28 Feb 2016 23:18:50 +0800
Subject: [PATCH v2 05/13] ARM: dts: sun8i-a83t: add mmc clock nodes
In-Reply-To: <1456672738-4993-1-git-send-email-vishnupatekar0510@gmail.com>
References: <1456672738-4993-1-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <1456672738-4993-6-git-send-email-vishnupatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mmc clocks are compatible with that of earlier sun8i socs.
This adds mmc0, mmc1, and mmc2 clock nodes for A83T.

Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index fa7ded5..d2a9435 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -237,6 +237,36 @@
 					     "bus_uart2", "bus_uart3",
 					     "bus_uart4";
 		};
+
+		mmc0_clk: clk at 01c20088 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
+			reg = <0x01c20088 0x4>;
+			clocks = <&osc24M>, <&pll6>;
+			clock-output-names = "mmc0",
+					     "mmc0_output",
+					     "mmc0_sample";
+		};
+
+		mmc1_clk: clk at 01c2008c {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
+			reg = <0x01c2008c 0x4>;
+			clocks = <&osc24M>, <&pll6>;
+			clock-output-names = "mmc1",
+					     "mmc1_output",
+					     "mmc1_sample";
+		};
+
+		mmc2_clk: clk at 01c20090 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-mmc-clk";
+			reg = <0x01c20090 0x4>;
+			clocks = <&osc24M>, <&pll6>;
+			clock-output-names = "mmc2",
+					     "mmc2_output",
+					     "mmc2_sample";
+		};
 	};
 
 	soc {
-- 
1.9.1
