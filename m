From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 13 May 2016 09:55:50 +0200
Subject: [PATCH 10/23] ARM: dts: ape6evm: Fix W=1 dtc warnings
In-Reply-To: <1463126163-29423-1-git-send-email-geert+renesas@glider.be>
References: <1463126163-29423-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1463126163-29423-11-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Warning (unit_address_vs_reg): Node /regulator at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 2 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 3 has a unit name, but no reg property

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index 93ace33e3e361af0..740e5d23f7c70843 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -36,7 +36,7 @@
 		reg = <2 0x00000000 0 0x40000000>;
 	};
 
-	vcc_mmc0: regulator at 0 {
+	vcc_mmc0: regulator-mmc0 {
 		compatible = "regulator-fixed";
 		regulator-name = "MMC0 Vcc";
 		regulator-min-microvolt = <2800000>;
@@ -44,7 +44,7 @@
 		regulator-always-on;
 	};
 
-	vcc_sdhi0: regulator at 1 {
+	vcc_sdhi0: regulator-sdhi0 {
 		compatible = "regulator-fixed";
 
 		regulator-name = "SDHI0 Vcc";
@@ -56,7 +56,7 @@
 	};
 
 	/* Common 1.8V and 3.3V rails, used by several devices on APE6EVM */
-	ape6evm_fixed_1v8: regulator at 2 {
+	ape6evm_fixed_1v8: regulator-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "1V8";
 		regulator-min-microvolt = <1800000>;
@@ -64,7 +64,7 @@
 		regulator-always-on;
 	};
 
-	ape6evm_fixed_3v3: regulator at 3 {
+	ape6evm_fixed_3v3: regulator-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "3V3";
 		regulator-min-microvolt = <3300000>;
-- 
1.9.1
