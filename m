From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 13 May 2016 09:55:51 +0200
Subject: [PATCH 11/23] ARM: dts: armadillo800eva: Fix W=1 dtc warnings
In-Reply-To: <1463126163-29423-1-git-send-email-geert+renesas@glider.be>
References: <1463126163-29423-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1463126163-29423-12-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /regulator at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 2 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 3 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /i2c at 2 has a unit name, but no reg property

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index 2c82dab2b6f45f9c..b3f0ac4b99bd5a3d 100644
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
+	i2c2: i2c2 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "i2c-gpio";
-- 
1.9.1
