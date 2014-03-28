From: d-gerlach@ti.com (Dave Gerlach)
Date: Fri, 28 Mar 2014 15:54:31 -0500
Subject: [PATCH] ARM: dts: am43xx-clocks: use ti,
 fixed-factor-clock for dpll_per_clkdcoldo
Message-ID: <1396040071-17900-1-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the ti,fixed-factor-clock version so that autoidle for
dpll_per_clkdcoldo is properly controlled after power management code
is introduced. Without this the clock may be held active even when
it is gated.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am43xx-clocks.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
index 142009c..1d9b6bb 100644
--- a/arch/arm/boot/dts/am43xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
@@ -609,10 +609,13 @@
 
 	dpll_per_clkdcoldo: dpll_per_clkdcoldo {
 		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
+		compatible = "ti,fixed-factor-clock";
 		clocks = <&dpll_per_ck>;
-		clock-mult = <1>;
-		clock-div = <1>;
+		ti,clock-mult = <1>;
+		ti,clock-div = <1>;
+		ti,autoidle-shift = <8>;
+		reg = <0x2e14>;
+		ti,invert-autoidle-bit;
 	};
 
 	dll_aging_clk_div: dll_aging_clk_div {
-- 
1.9.0
