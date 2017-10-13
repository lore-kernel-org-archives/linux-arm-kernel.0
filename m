From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Oct 2017 13:05:58 +0200
Subject: [PATCH v2 08/10] ARM: dts: r8a7794: Use R-Car GPIO Gen2 fallback
 compat string
In-Reply-To: <20171013110600.6858-1-horms+renesas@verge.net.au>
References: <20171013110600.6858-1-horms+renesas@verge.net.au>
Message-ID: <20171013110600.6858-9-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use newly added R-Car GPIO Gen2 fallback compat string
in place of now deprecated non-generation specific
R-Car GPIO fallback compat string in the DT of the r8a7794 SoC.

This should have no run-time effect as the driver matches against
the per-SoC compat string before considering the fallback compat string.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 19cff0dd90cf..7720a6ca8702 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -82,7 +82,7 @@
 	};
 
 	gpio0: gpio at e6050000 {
-		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7794", "renesas,rcar-gen2-gpio";
 		reg = <0 0xe6050000 0 0x50>;
 		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -96,7 +96,7 @@
 	};
 
 	gpio1: gpio at e6051000 {
-		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7794", "renesas,rcar-gen2-gpio";
 		reg = <0 0xe6051000 0 0x50>;
 		interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -110,7 +110,7 @@
 	};
 
 	gpio2: gpio at e6052000 {
-		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7794", "renesas,rcar-gen2-gpio";
 		reg = <0 0xe6052000 0 0x50>;
 		interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -124,7 +124,7 @@
 	};
 
 	gpio3: gpio at e6053000 {
-		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7794", "renesas,rcar-gen2-gpio";
 		reg = <0 0xe6053000 0 0x50>;
 		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -138,7 +138,7 @@
 	};
 
 	gpio4: gpio at e6054000 {
-		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7794", "renesas,rcar-gen2-gpio";
 		reg = <0 0xe6054000 0 0x50>;
 		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -152,7 +152,7 @@
 	};
 
 	gpio5: gpio at e6055000 {
-		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7794", "renesas,rcar-gen2-gpio";
 		reg = <0 0xe6055000 0 0x50>;
 		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -166,7 +166,7 @@
 	};
 
 	gpio6: gpio at e6055400 {
-		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7794", "renesas,rcar-gen2-gpio";
 		reg = <0 0xe6055400 0 0x50>;
 		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
-- 
2.11.0
