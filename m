From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 12 Jul 2016 00:52:43 +0300
Subject: [PATCH 2/2] ARM: dts: r8a7792: remove ADSP clock
In-Reply-To: <1529351.Fac5N2tKoF@wasted.cogentembedded.com>
References: <1529351.Fac5N2tKoF@wasted.cogentembedded.com>
Message-ID: <6927311.Po2EPBmxEp@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon Horman told  me  that R8A7792 had ADSP clock (based on the most recent
R-Car gen2 manual) but when I  got that manual as well, this claim proved
to be false: R8A7792 is the only gen2 SoC that doesn't  have ADSP at all.
Remove that  clock  for good...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7792.dtsi            |    2 +-
 include/dt-bindings/clock/r8a7792-clock.h |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

Index: renesas/arch/arm/boot/dts/r8a7792.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792.dtsi
+++ renesas/arch/arm/boot/dts/r8a7792.dtsi
@@ -464,7 +464,7 @@
 			clocks = <&extal_clk>;
 			#clock-cells = <1>;
 			clock-output-names = "main", "pll0", "pll1", "pll3",
-					     "lb", "qspi", "z", "adsp";
+					     "lb", "qspi", "z";
 			#power-domain-cells = <0>;
 		};
 
Index: renesas/include/dt-bindings/clock/r8a7792-clock.h
===================================================================
--- renesas.orig/include/dt-bindings/clock/r8a7792-clock.h
+++ renesas/include/dt-bindings/clock/r8a7792-clock.h
@@ -18,7 +18,6 @@
 #define R8A7792_CLK_LB			4
 #define R8A7792_CLK_QSPI		5
 #define R8A7792_CLK_Z			6
-#define R8A7792_CLK_ADSP		7
 
 /* MSTP0 */
 #define R8A7792_CLK_MSIOF0		0
