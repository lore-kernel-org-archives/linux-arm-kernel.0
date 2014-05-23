From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 23 May 2014 15:51:15 +0800
Subject: [PATCH 12/22] ARM: sun6i: DT: Add PLL6 pre-divider clock for AHB1 mux
 input
In-Reply-To: <1400831485-28576-1-git-send-email-wens@csie.org>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
Message-ID: <1400831485-28576-13-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the A31, the PLL6 input to the AHB1 clock has a 2 bit wide
pre-divider. This was verified from the A23 user manual and
A31/A23 SDK sources.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index d9643fa..d8808fe 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -125,11 +125,19 @@
 			clock-output-names = "axi";
 		};
 
+		ahb1_pll6: ahb1_pll6_clk at 01c20054 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun6i-a31-ahb1-pll6-clk";
+			reg = <0x01c20054 0x4>;
+			clocks = <&pll6 0>;
+			clock-output-names = "ahb1_pll6";
+		};
+
 		ahb1_mux: ahb1_mux at 01c20054 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun6i-a31-ahb1-mux-clk";
 			reg = <0x01c20054 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6 0>;
+			clocks = <&osc32k>, <&osc24M>, <&axi>, <&ahb1_pll6>;
 			clock-output-names = "ahb1_mux";
 		};
 
-- 
2.0.0.rc2
