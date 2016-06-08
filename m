From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  8 Jun 2016 09:59:50 +0900
Subject: [PATCH 20/30] ARM: dts: armadillo800eva: Fix W=1 dtc warnings
In-Reply-To: <cover.1465346599.git.horms+renesas@verge.net.au>
References: <cover.1465346599.git.horms+renesas@verge.net.au>
Message-ID: <c9c3b7c3029d501402b5ac4817659d6e0a6f11f4.1465346599.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /regulator at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 2 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 3 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /i2c at 2 has a unit name, but no reg property

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index 2c82dab2b6f4..162049516685 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -28,12 +28,12 @@
 		stdout-path = &scifa1;
 	};
 
-	memory {
+	memory at 40000000 {
 		device_type = "memory";
 		reg = <0x40000000 0x20000000>;
 	};
 
-	reg_3p3v: regulator at 0 {
+	reg_3p3v: regulator-3p3v {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-3.3V";
 		regulator-min-microvolt = <3300000>;
@@ -42,7 +42,7 @@
 		regulator-boot-on;
 	};
 
-	vcc_sdhi0: regulator at 1 {
+	vcc_sdhi0: regulator-vcc-sdhi0 {
 		compatible = "regulator-fixed";
 
 		regulator-name = "SDHI0 Vcc";
@@ -53,7 +53,7 @@
 		enable-active-high;
 	};
 
-	vccq_sdhi0: regulator at 2 {
+	vccq_sdhi0: regulator-vccq-sdhi0 {
 		compatible = "regulator-gpio";
 
 		regulator-name = "SDHI0 VccQ";
@@ -69,7 +69,7 @@
 		enable-active-high;
 	};
 
-	reg_5p0v: regulator at 3 {
+	reg_5p0v: regulator-5p0v {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-5.0V";
 		regulator-min-microvolt = <5000000>;
@@ -127,7 +127,7 @@
 		};
 	};
 
-	i2c2: i2c at 2 {
+	i2c2: i2c-2 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "i2c-gpio";
-- 
2.1.4
