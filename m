From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 11 Jul 2017 14:56:47 +0200
Subject: [PATCH 1/3] ARM: dts: r8a7790: Use R-Car Gen 2 fallback binding for
 vin nodes
In-Reply-To: <1499777809-27492-1-git-send-email-horms+renesas@verge.net.au>
References: <1499777809-27492-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1499777809-27492-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use R-Car Gen 2 fallback binding for vind nodes in DT for r8a7790 SoC.

This has no run-time effect for the current driver as the initialisation
sequence is the same for the SoC-specific binding for r8a7790 and the
fallback binding for R-Car Gen 2

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index ff986df23b62..167fd57aea68 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -927,7 +927,7 @@
 	};
 
 	vin0: video at e6ef0000 {
-		compatible = "renesas,vin-r8a7790";
+		compatible = "renesas,vin-r8a7790", "renesas,rcar-gen2-vin";
 		reg = <0 0xe6ef0000 0 0x1000>;
 		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_VIN0>;
@@ -936,7 +936,7 @@
 	};
 
 	vin1: video at e6ef1000 {
-		compatible = "renesas,vin-r8a7790";
+		compatible = "renesas,vin-r8a7790", "renesas,rcar-gen2-vin";
 		reg = <0 0xe6ef1000 0 0x1000>;
 		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_VIN1>;
@@ -945,7 +945,7 @@
 	};
 
 	vin2: video at e6ef2000 {
-		compatible = "renesas,vin-r8a7790";
+		compatible = "renesas,vin-r8a7790", "renesas,rcar-gen2-vin";
 		reg = <0 0xe6ef2000 0 0x1000>;
 		interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_VIN2>;
@@ -954,7 +954,7 @@
 	};
 
 	vin3: video at e6ef3000 {
-		compatible = "renesas,vin-r8a7790";
+		compatible = "renesas,vin-r8a7790", "renesas,rcar-gen2-vin";
 		reg = <0 0xe6ef3000 0 0x1000>;
 		interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_VIN3>;
-- 
2.1.4
