From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 18 Apr 2017 12:22:04 +0800
Subject: [PATCH 2/3] ARM: sun8i: a83t: Drop leading zeroes from device node
 addresses
In-Reply-To: <20170418042205.27894-1-wens@csie.org>
References: <20170418042205.27894-1-wens@csie.org>
Message-ID: <20170418042205.27894-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kbuild now complains about leading zeroes in the address portion of
device node names.

Get rid of them.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 913aacafe8d5..82cb87f21b96 100644
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
@@ -201,14 +201,14 @@
 			clocks = <&osc24M>;
 		};
 
-		watchdog at 01c20ca0 {
+		watchdog at 1c20ca0 {
 			compatible = "allwinner,sun6i-a31-wdt";
 			reg = <0x01c20ca0 0x20>;
 			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&osc24M>;
 		};
 
-		uart0: serial at 01c28000 {
+		uart0: serial at 1c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
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
