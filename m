From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  8 Jun 2016 09:59:49 +0900
Subject: [PATCH 19/30] ARM: dts: ape6evm: Fix W=1 dtc warnings
In-Reply-To: <cover.1465346599.git.horms+renesas@verge.net.au>
References: <cover.1465346599.git.horms+renesas@verge.net.au>
Message-ID: <4706147211708c7a8c027b798a016fdd5d03c9d2.1465346599.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Warning (unit_address_vs_reg): Node /regulator at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 2 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 3 has a unit name, but no reg property

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index 93ace33e3e36..740e5d23f7c7 100644
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
2.1.4
