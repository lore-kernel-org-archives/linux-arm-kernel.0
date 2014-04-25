From: sourav.poddar@ti.com (Sourav Poddar)
Date: Fri, 25 Apr 2014 14:25:25 +0530
Subject: [PATCH] arm: dts: am33xx-clock: Fix ehrpwm tbclk data.
Message-ID: <1398416125-7139-1-git-send-email-sourav.poddar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tbclk does not need to be a composite clock, we can simply
use gate clock for this purpose.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 arch/arm/boot/dts/am33xx-clocks.dtsi |   42 ++++++++++------------------------
 1 file changed, 12 insertions(+), 30 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx-clocks.dtsi b/arch/arm/boot/dts/am33xx-clocks.dtsi
index 9ccfe50..a45d27f 100644
--- a/arch/arm/boot/dts/am33xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am33xx-clocks.dtsi
@@ -96,46 +96,28 @@
 		clock-div = <1>;
 	};
 
-	ehrpwm0_gate_tbclk: ehrpwm0_gate_tbclk {
+	ehrpwm0_tbclk: ehrpwm0_tbclk at 44e10664 {
 		#clock-cells = <0>;
-		compatible = "ti,composite-no-wait-gate-clock";
+		compatible = "gate-clock";
 		clocks = <&dpll_per_m2_ck>;
-		ti,bit-shift = <0>;
-		reg = <0x0664>;
+		bit-shift = <0>;
+		reg = <0x44e10664 0x4>;
 	};
 
-	ehrpwm0_tbclk: ehrpwm0_tbclk {
+	ehrpwm1_tbclk: ehrpwm1_tbclk at 44e10664 {
 		#clock-cells = <0>;
-		compatible = "ti,composite-clock";
-		clocks = <&ehrpwm0_gate_tbclk>;
-	};
-
-	ehrpwm1_gate_tbclk: ehrpwm1_gate_tbclk {
-		#clock-cells = <0>;
-		compatible = "ti,composite-no-wait-gate-clock";
+		compatible = "gate-clock";
 		clocks = <&dpll_per_m2_ck>;
-		ti,bit-shift = <1>;
-		reg = <0x0664>;
-	};
-
-	ehrpwm1_tbclk: ehrpwm1_tbclk {
-		#clock-cells = <0>;
-		compatible = "ti,composite-clock";
-		clocks = <&ehrpwm1_gate_tbclk>;
+		bit-shift = <1>;
+		reg = <0x44e10664 0x4>;
 	};
 
-	ehrpwm2_gate_tbclk: ehrpwm2_gate_tbclk {
+	ehrpwm2_tbclk: ehrpwm2_tbclk at 44e10664 {
 		#clock-cells = <0>;
-		compatible = "ti,composite-no-wait-gate-clock";
+		compatible = "gate-clock";
 		clocks = <&dpll_per_m2_ck>;
-		ti,bit-shift = <2>;
-		reg = <0x0664>;
-	};
-
-	ehrpwm2_tbclk: ehrpwm2_tbclk {
-		#clock-cells = <0>;
-		compatible = "ti,composite-clock";
-		clocks = <&ehrpwm2_gate_tbclk>;
+		bit-shift = <2>;
+		reg = <0x44e10664 0x4>;
 	};
 };
 &prcm_clocks {
-- 
1.7.9.5
