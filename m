From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Jun 2014 22:52:45 +0800
Subject: [PATCH v2 08/20] ARM: sun6i: DT: Rename PLL6 to PLL6x2 and add
 fixed-factor-clock for PLL6
In-Reply-To: <1403016777-15121-1-git-send-email-wens@csie.org>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
Message-ID: <1403016777-15121-9-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PLL6 clock driver actually manages the PLL6x2 output of PLL6, so
rename the node accordingly, and add a halved fixed-factor-clock for
normal PLL6 output used by most modules.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index a9dfa12..12d558b 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -94,11 +94,20 @@
 			clock-output-names = "pll1";
 		};
 
-		pll6: clk at 01c20028 {
+		pll6x2: clk at 01c20028 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun6i-a31-pll6-clk";
 			reg = <0x01c20028 0x4>;
 			clocks = <&osc24M>;
+			clock-output-names = "pll6x2";
+		};
+
+		pll6: pll6_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clock-div = <2>;
+			clock-mult = <1>;
+			clocks = <&pll6x2>;
 			clock-output-names = "pll6";
 		};
 
-- 
2.0.0
