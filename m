From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  8 Aug 2017 10:39:26 +0200
Subject: [PATCH 08/10] ARM: dts: r8a7794: Use R-Car GPIO Gen2 fallback compat
 string
In-Reply-To: <1502181568-12299-1-git-send-email-horms+renesas@verge.net.au>
References: <1502181568-12299-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1502181568-12299-9-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use newly added R-Car GPIO Gen2 fallback compat string
in place of now deprecated non-generation specific
R-Car GPIO fallback compat string in the DT of the r8a7794 SoC.

This should have no run-time effect as the driver matches against
the per-SoC compat string before considering the fallback compat string.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 26535414203a..294bb1a697a6 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -81,7 +81,7 @@
 	};
 
 	gpio0: gpio at e6050000 {
-		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7794", "renesas,rcar-gen2-gpio";
 		reg = <0 0xe6050000 0 0x50>;
 		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -94,7 +94,7 @@
 	};
 
 	gpio1: gpio at e6051000 {
-		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7794", "renesas,rcar-gen2-gpio";
 		reg = <0 0xe6051000 0 0x50>;
 		interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -107,7 +107,7 @@
 	};
 
 	gpio2: gpio at e6052000 {
-		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7794", "renesas,rcar-gen2-gpio";
 		reg = <0 0xe6052000 0 0x50>;
 		interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -120,7 +120,7 @@
 	};
 
 	gpio3: gpio at e6053000 {
-		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7794", "renesas,rcar-gen2-gpio";
 		reg = <0 0xe6053000 0 0x50>;
 		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -133,7 +133,7 @@
 	};
 
 	gpio4: gpio at e6054000 {
-		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7794", "renesas,rcar-gen2-gpio";
 		reg = <0 0xe6054000 0 0x50>;
 		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -146,7 +146,7 @@
 	};
 
 	gpio5: gpio at e6055000 {
-		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7794", "renesas,rcar-gen2-gpio";
 		reg = <0 0xe6055000 0 0x50>;
 		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -159,7 +159,7 @@
 	};
 
 	gpio6: gpio at e6055400 {
-		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7794", "renesas,rcar-gen2-gpio";
 		reg = <0 0xe6055400 0 0x50>;
 		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
-- 
2.1.4
