From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  8 Aug 2017 10:39:19 +0200
Subject: [PATCH 01/10] ARM: dts: r8a7778: Use R-Car GPIO Gen1 fallback compat
 string
In-Reply-To: <1502181568-12299-1-git-send-email-horms+renesas@verge.net.au>
References: <1502181568-12299-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1502181568-12299-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use newly added R-Car GPIO Gen1 fallback compat string
in place of now deprecated non-generation specific
R-Car GPIO fallback compat string in DT of r8a7778 SoC.

This should have no run-time effect as the driver matches against
the per-SoC compat string before considering the fallback compat string.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 8f3156c0e575..b3975e4c75dd 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -88,7 +88,7 @@
 	};
 
 	gpio0: gpio at ffc40000 {
-		compatible = "renesas,gpio-r8a7778", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7778", "renesas,rcar-gen2-gpio";
 		reg = <0xffc40000 0x2c>;
 		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -99,7 +99,7 @@
 	};
 
 	gpio1: gpio at ffc41000 {
-		compatible = "renesas,gpio-r8a7778", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7778", "renesas,rcar-gen1-gpio";
 		reg = <0xffc41000 0x2c>;
 		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -110,7 +110,7 @@
 	};
 
 	gpio2: gpio at ffc42000 {
-		compatible = "renesas,gpio-r8a7778", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7778", "renesas,rcar-gen1-gpio";
 		reg = <0xffc42000 0x2c>;
 		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -121,7 +121,7 @@
 	};
 
 	gpio3: gpio at ffc43000 {
-		compatible = "renesas,gpio-r8a7778", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7778", "renesas,rcar-gen1-gpio";
 		reg = <0xffc43000 0x2c>;
 		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -132,7 +132,7 @@
 	};
 
 	gpio4: gpio at ffc44000 {
-		compatible = "renesas,gpio-r8a7778", "renesas,gpio-rcar";
+		compatible = "renesas,gpio-r8a7778", "renesas,rcar-gen1-gpio";
 		reg = <0xffc44000 0x2c>;
 		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
-- 
2.1.4
