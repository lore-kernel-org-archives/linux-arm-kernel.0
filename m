From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 30 Oct 2016 00:31:27 +0300
Subject: [PATCH] ARM: dts: r8a7794: remove Z clock
In-Reply-To: <1529351.Fac5N2tKoF@wasted.cogentembedded.com>
References: <1529351.Fac5N2tKoF@wasted.cogentembedded.com>
Message-ID: <2289596.xFBEUD1OgK@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R8A7794 doesn't have Cortex-A15 CPUs, thus there's no Z clock...

Fixes: 0dce5454d5c2 ("ARM: shmobile: Initial r8a7794 SoC device tree")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'master' branch of Simon Horman's 'renesas.git' repo.

 arch/arm/boot/dts/r8a7794.dtsi            |    3 +--
 include/dt-bindings/clock/r8a7794-clock.h |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
+++ renesas/arch/arm/boot/dts/r8a7794.dtsi
@@ -1025,8 +1025,7 @@
 			clocks = <&extal_clk &usb_extal_clk>;
 			#clock-cells = <1>;
 			clock-output-names = "main", "pll0", "pll1", "pll3",
-					     "lb", "qspi", "sdh", "sd0", "z",
-					     "rcan";
+					     "lb", "qspi", "sdh", "sd0", "rcan";
 			#power-domain-cells = <0>;
 		};
 		/* Variable factor clocks */
Index: renesas/include/dt-bindings/clock/r8a7794-clock.h
===================================================================
--- renesas.orig/include/dt-bindings/clock/r8a7794-clock.h
+++ renesas/include/dt-bindings/clock/r8a7794-clock.h
@@ -20,8 +20,7 @@
 #define R8A7794_CLK_QSPI		5
 #define R8A7794_CLK_SDH			6
 #define R8A7794_CLK_SD0			7
-#define R8A7794_CLK_Z			8
-#define R8A7794_CLK_RCAN		9
+#define R8A7794_CLK_RCAN		8
 
 /* MSTP0 */
 #define R8A7794_CLK_MSIOF0		0
