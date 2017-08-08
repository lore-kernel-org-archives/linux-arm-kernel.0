From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  8 Aug 2017 10:39:23 +0200
Subject: [PATCH 05/10] ARM: dts: r8a7791: Use R-Car GPIO Gen2 fallback compat
 string
In-Reply-To: <1502181568-12299-1-git-send-email-horms+renesas@verge.net.au>
References: <1502181568-12299-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1502181568-12299-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use newly added R-Car GPIO Gen2 fallback compat string
in place of now deprecated non-generation specific
R-Car GPIO fallback compat string in the DT of the r8a7791 SoC.

This should have no run-time effect as the driver matches against
the per-SoC compat string before considering the fallback compat string.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index ea4a8147d995..4bef05f186df 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -123,7 +123,7 @@
 	};
 
 	gpio0: gpio at e6050000 {
-		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7791", "renesas,rcar-gen2-gpio";
 		reg = <0 0xe6050000 0 0x50>;
 		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -136,7 +136,7 @@
 	};
 
 	gpio1: gpio at e6051000 {
-		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7791", "renesas,rcar-gen2-gpio";
 		reg = <0 0xe6051000 0 0x50>;
 		interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -149,7 +149,7 @@
 	};
 
 	gpio2: gpio at e6052000 {
-		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7791", "renesas,rcar-gen2-gpio";
 		reg = <0 0xe6052000 0 0x50>;
 		interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -162,7 +162,7 @@
 	};
 
 	gpio3: gpio at e6053000 {
-		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7791", "renesas,rcar-gen2-gpio";
 		reg = <0 0xe6053000 0 0x50>;
 		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -175,7 +175,7 @@
 	};
 
 	gpio4: gpio at e6054000 {
-		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7791", "renesas,rcar-gen2-gpio";
 		reg = <0 0xe6054000 0 0x50>;
 		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -188,7 +188,7 @@
 	};
 
 	gpio5: gpio at e6055000 {
-		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7791", "renesas,rcar-gen2-gpio";
 		reg = <0 0xe6055000 0 0x50>;
 		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -201,7 +201,7 @@
 	};
 
 	gpio6: gpio at e6055400 {
-		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7791", "renesas,rcar-gen2-gpio";
 		reg = <0 0xe6055400 0 0x50>;
 		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -214,7 +214,7 @@
 	};
 
 	gpio7: gpio at e6055800 {
-		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7791", "renesas,rcar-gen2-gpio";
 		reg = <0 0xe6055800 0 0x50>;
 		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
-- 
2.1.4
