From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  1 May 2017 11:14:07 +0800
Subject: [PATCH v2 1/2] ARM: sun8i: a83t: Drop leading zeroes from device node
 addresses
In-Reply-To: <20170501031408.10469-1-wens@csie.org>
References: <20170501031408.10469-1-wens@csie.org>
Message-ID: <20170501031408.10469-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kbuild now complains about leading zeroes in the address portion of
device node names.

Get rid of them all, except for the uart device node. U-boot currently
hard codes the device node path. We can remove the leading zero for
the uart once we teach U-boot to use the aliases or stdout-path
property.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 5f5c10c04dd3..aecde8be53bc 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -162,7 +162,7 @@
 		#size-cells = <1>;
 		ranges;
 
-		pio: pinctrl at 01c20800 {
+		pio: pinctrl at 1c20800 {
 			compatible = "allwinner,sun8i-a83t-pinctrl";
 			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
@@ -193,7 +193,7 @@
 			};
 		};
 
-		timer at 01c20c00 {
+		timer at 1c20c00 {
 			compatible = "allwinner,sun4i-a10-timer";
 			reg = <0x01c20c00 0xa0>;
 			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
@@ -201,7 +201,7 @@
 			clocks = <&osc24M>;
 		};
 
-		watchdog at 01c20ca0 {
+		watchdog at 1c20ca0 {
 			compatible = "allwinner,sun6i-a31-wdt";
 			reg = <0x01c20ca0 0x20>;
 			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
@@ -218,7 +218,7 @@
 			status = "disabled";
 		};
 
-		gic: interrupt-controller at 01c81000 {
+		gic: interrupt-controller at 1c81000 {
 			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
 			reg = <0x01c81000 0x1000>,
 			      <0x01c82000 0x2000>,
-- 
2.11.0
