From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  3 Apr 2017 11:54:03 +0200
Subject: [PATCH] ARM: dts: r8a7794: Add Z2 clock
Message-ID: <1491213243-7448-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the Z2 clock (Cortex-A7 CPU core clock), which uses a fixed divider,
and link the first CPU node to it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 2f6e94fd408cc858..a19b884fb25897fc 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -43,6 +43,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0>;
 			clock-frequency = <1000000000>;
+			clocks = <&z2_clk>;
 			power-domains = <&sysc R8A7794_PD_CA7_CPU0>;
 			next-level-cache = <&L2_CA7>;
 		};
@@ -1064,6 +1065,13 @@
 			clock-div = <2>;
 			clock-mult = <1>;
 		};
+		z2_clk: z2 {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7794_CLK_PLL0>;
+			#clock-cells = <0>;
+			clock-div = <1>;
+			clock-mult = <1>;
+		};
 		zg_clk: zg {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
-- 
2.7.4
