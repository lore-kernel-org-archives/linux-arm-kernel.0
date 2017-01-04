From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  4 Jan 2017 10:30:46 +0100
Subject: [PATCH 2/2] ARM: dts: OX820: Update with dt-bindings includes
In-Reply-To: <20170104093046.12428-1-narmstrong@baylibre.com>
References: <20170104093046.12428-1-narmstrong@baylibre.com>
Message-ID: <20170104093046.12428-3-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add OX820 dt-bindings includes files for clocks and resets, replace
resets numbers by human readable defines.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/ox820.dtsi | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/ox820.dtsi b/arch/arm/boot/dts/ox820.dtsi
index e40f282..4592075 100644
--- a/arch/arm/boot/dts/ox820.dtsi
+++ b/arch/arm/boot/dts/ox820.dtsi
@@ -8,6 +8,8 @@
 
 /include/ "skeleton.dtsi"
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/oxsemi,ox820.h>
+#include <dt-bindings/reset/oxsemi,ox820.h>
 
 / {
 	compatible = "oxsemi,ox820";
@@ -83,8 +85,8 @@
 		nandc: nand-controller at 41000000 {
 			compatible = "oxsemi,ox820-nand";
 			reg = <0x41000000 0x100000>;
-			clocks = <&stdclk 11>;
-			resets = <&reset 15>;
+			clocks = <&stdclk CLK_820_NAND>;
+			resets = <&reset RESET_NAND>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -99,9 +101,9 @@
 			mac-address = [000000000000]; /* Filled in by U-Boot */
 			phy-mode = "rgmii";
 
-			clocks = <&stdclk 9>, <&gmacclk>;
+			clocks = <&stdclk CLK_820_ETHA>, <&gmacclk>;
 			clock-names = "gmac", "stmmaceth";
-			resets = <&reset 6>;
+			resets = <&reset RESET_MAC>;
 
 			/* Regmap for sys registers */
 			oxsemi,sys-ctrl = <&sys>;
@@ -208,7 +210,7 @@
 			       no-loopback-test;
 			       status = "disabled";
 			       clocks = <&sysclk>;
-			       resets = <&reset 17>;
+			       resets = <&reset RESET_UART1>;
 			};
 
 			uart1: serial at 300000 {
@@ -222,7 +224,7 @@
 			       no-loopback-test;
 			       status = "disabled";
 			       clocks = <&sysclk>;
-			       resets = <&reset 18>;
+			       resets = <&reset RESET_UART2>;
 			};
 
 			rps at 400000 {
-- 
2.7.0
