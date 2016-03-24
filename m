From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 Mar 2016 15:51:30 +0100
Subject: [PATCH 2/2] ARM: dts: ux500: use the GIC include header
Message-ID: <1458831090-10513-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the <dt-bindings/interrupt-controller/arm-gic.h> header for
generating the flags for the first cell of the interrupt
definitions.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 91 ++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 45 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index d85830d80252..6ae56838bd3a 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -10,6 +10,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mfd/dbx500-prcmu.h>
 #include <dt-bindings/arm/ux500_pm_domains.h>
 #include <dt-bindings/gpio/gpio.h>
@@ -204,14 +205,14 @@
 		L2: l2-cache {
 			compatible = "arm,pl310-cache";
 			reg = <0xa0412000 0x1000>;
-			interrupts = <0 13 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
 			cache-unified;
 			cache-level = <2>;
 		};
 
 		pmu {
 			compatible = "arm,cortex-a9-pmu";
-			interrupts = <0 7 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pm_domains: pm_domains0 {
@@ -254,7 +255,7 @@
 			/* Nomadik System Timer */
 			compatible = "st,nomadik-mtu";
 			reg = <0xa03c6000 0x1000>;
-			interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 
 			clocks = <&prcmu_clk PRCMU_TIMCLK>, <&prcc_pclk 6 6>;
 			clock-names = "timclk", "apb_pclk";
@@ -263,7 +264,7 @@
 		timer at a0410600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xa0410600 0x20>;
-			interrupts = <1 13 0x304>; /* IRQ level high per-CPU */
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_HIGH)>;
 
 			clocks = <&smp_twd_clk>;
 		};
@@ -271,14 +272,14 @@
 		watchdog at a0410620 {
 			compatible = "arm,cortex-a9-twd-wdt";
 			reg = <0xa0410620 0x20>;
-			interrupts = <1 14 0x304>;
+			interrupts = <GIC_PPI 14 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&smp_twd_clk>;
 		};
 
 		rtc at 80154000 {
 			compatible = "arm,rtc-pl031", "arm,primecell";
 			reg = <0x80154000 0x1000>;
-			interrupts = <0 18 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
 
 			clocks = <&rtc_clk>;
 			clock-names = "apb_pclk";
@@ -288,7 +289,7 @@
 			compatible = "stericsson,db8500-gpio",
 				"st,nomadik-gpio";
 			reg =  <0x8012e000 0x80>;
-			interrupts = <0 119 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			st,supports-sleepmode;
@@ -303,7 +304,7 @@
 			compatible = "stericsson,db8500-gpio",
 				"st,nomadik-gpio";
 			reg =  <0x8012e080 0x80>;
-			interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			st,supports-sleepmode;
@@ -318,7 +319,7 @@
 			compatible = "stericsson,db8500-gpio",
 				"st,nomadik-gpio";
 			reg =  <0x8000e000 0x80>;
-			interrupts = <0 121 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			st,supports-sleepmode;
@@ -333,7 +334,7 @@
 			compatible = "stericsson,db8500-gpio",
 				"st,nomadik-gpio";
 			reg =  <0x8000e080 0x80>;
-			interrupts = <0 122 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			st,supports-sleepmode;
@@ -348,7 +349,7 @@
 			compatible = "stericsson,db8500-gpio",
 				"st,nomadik-gpio";
 			reg =  <0x8000e100 0x80>;
-			interrupts = <0 123 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			st,supports-sleepmode;
@@ -363,7 +364,7 @@
 			compatible = "stericsson,db8500-gpio",
 				"st,nomadik-gpio";
 			reg =  <0x8000e180 0x80>;
-			interrupts = <0 124 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			st,supports-sleepmode;
@@ -378,7 +379,7 @@
 			compatible = "stericsson,db8500-gpio",
 				"st,nomadik-gpio";
 			reg =  <0x8011e000 0x80>;
-			interrupts = <0 125 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			st,supports-sleepmode;
@@ -393,7 +394,7 @@
 			compatible = "stericsson,db8500-gpio",
 				"st,nomadik-gpio";
 			reg =  <0x8011e080 0x80>;
-			interrupts = <0 126 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			st,supports-sleepmode;
@@ -408,7 +409,7 @@
 			compatible = "stericsson,db8500-gpio",
 				"st,nomadik-gpio";
 			reg =  <0xa03fe000 0x80>;
-			interrupts = <0 127 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			st,supports-sleepmode;
@@ -430,7 +431,7 @@
 		usb_per5 at a03e0000 {
 			compatible = "stericsson,db8500-musb";
 			reg = <0xa03e0000 0x10000>;
-			interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "mc";
 
 			dr_mode = "otg";
@@ -468,7 +469,7 @@
 			compatible = "stericsson,db8500-dma40", "stericsson,dma40";
 			reg = <0x801C0000 0x1000 0x40010000 0x800>;
 			reg-names = "base", "lcpa";
-			interrupts = <0 25 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 
 			#dma-cells = <3>;
 			memcpy-channels = <56 57 58 59 60>;
@@ -480,7 +481,7 @@
 			compatible = "stericsson,db8500-prcmu";
 			reg = <0x80157000 0x2000>, <0x801b0000 0x8000>, <0x801b8000 0x1000>;
 			reg-names = "prcmu", "prcmu-tcpm", "prcmu-tcdm";
-			interrupts = <0 47 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			interrupt-controller;
@@ -598,7 +599,7 @@
 			ab8500 {
 				compatible = "stericsson,ab8500";
 				interrupt-parent = <&intc>;
-				interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 
@@ -786,7 +787,7 @@
 		i2c at 80004000 {
 			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c", "arm,primecell";
 			reg = <0x80004000 0x1000>;
-			interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -801,7 +802,7 @@
 		i2c at 80122000 {
 			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c", "arm,primecell";
 			reg = <0x80122000 0x1000>;
-			interrupts = <0 22 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -817,7 +818,7 @@
 		i2c at 80128000 {
 			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c", "arm,primecell";
 			reg = <0x80128000 0x1000>;
-			interrupts = <0 55 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -833,7 +834,7 @@
 		i2c at 80110000 {
 			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c", "arm,primecell";
 			reg = <0x80110000 0x1000>;
-			interrupts = <0 12 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -849,7 +850,7 @@
 		i2c at 8012a000 {
 			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c", "arm,primecell";
 			reg = <0x8012a000 0x1000>;
-			interrupts = <0 51 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
 
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -865,7 +866,7 @@
 		ssp at 80002000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x80002000 0x1000>;
-			interrupts = <0 14 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&prcc_kclk 3 1>, <&prcc_pclk 3 1>;
@@ -879,7 +880,7 @@
 		ssp at 80003000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x80003000 0x1000>;
-			interrupts = <0 52 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&prcc_kclk 3 2>, <&prcc_pclk 3 2>;
@@ -893,7 +894,7 @@
 		spi at 8011a000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x8011a000 0x1000>;
-			interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			/* Same clock wired to kernel and pclk */
@@ -908,7 +909,7 @@
 		spi at 80112000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x80112000 0x1000>;
-			interrupts = <0 96 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			/* Same clock wired to kernel and pclk */
@@ -923,7 +924,7 @@
 		spi at 80111000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x80111000 0x1000>;
-			interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			/* Same clock wired to kernel and pclk */
@@ -938,7 +939,7 @@
 		spi at 80129000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x80129000 0x1000>;
-			interrupts = <0 49 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			/* Same clock wired to kernel and pclk */
@@ -953,7 +954,7 @@
 		ux500_serial0: uart at 80120000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x80120000 0x1000>;
-			interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 
 			dmas = <&dma 13 0 0x2>, /* Logical - DevToMem */
 			       <&dma 13 0 0x0>; /* Logical - MemToDev */
@@ -968,7 +969,7 @@
 		ux500_serial1: uart at 80121000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x80121000 0x1000>;
-			interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 
 			dmas = <&dma 12 0 0x2>, /* Logical - DevToMem */
 			       <&dma 12 0 0x0>; /* Logical - MemToDev */
@@ -983,7 +984,7 @@
 		ux500_serial2: uart at 80007000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x80007000 0x1000>;
-			interrupts = <0 26 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 
 			dmas = <&dma 11 0 0x2>, /* Logical - DevToMem */
 			       <&dma 11 0 0x0>; /* Logical - MemToDev */
@@ -998,7 +999,7 @@
 		sdi0_per1 at 80126000 {
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80126000 0x1000>;
-			interrupts = <0 60 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 
 			dmas = <&dma 29 0 0x2>, /* Logical - DevToMem */
 			       <&dma 29 0 0x0>; /* Logical - MemToDev */
@@ -1014,7 +1015,7 @@
 		sdi1_per2 at 80118000 {
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80118000 0x1000>;
-			interrupts = <0 50 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
 
 			dmas = <&dma 32 0 0x2>, /* Logical - DevToMem */
 			       <&dma 32 0 0x0>; /* Logical - MemToDev */
@@ -1030,7 +1031,7 @@
 		sdi2_per3 at 80005000 {
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80005000 0x1000>;
-			interrupts = <0 41 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 
 			dmas = <&dma 28 0 0x2>, /* Logical - DevToMem */
 			       <&dma 28 0 0x0>; /* Logical - MemToDev */
@@ -1046,7 +1047,7 @@
 		sdi3_per2 at 80119000 {
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80119000 0x1000>;
-			interrupts = <0 59 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 
 			dmas = <&dma 41 0 0x2>, /* Logical - DevToMem */
 			       <&dma 41 0 0x0>; /* Logical - MemToDev */
@@ -1062,7 +1063,7 @@
 		sdi4_per2 at 80114000 {
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80114000 0x1000>;
-			interrupts = <0 99 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
 
 			dmas = <&dma 42 0 0x2>, /* Logical - DevToMem */
 			       <&dma 42 0 0x0>; /* Logical - MemToDev */
@@ -1078,7 +1079,7 @@
 		sdi5_per3 at 80008000 {
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80008000 0x1000>;
-			interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 
 			dmas = <&dma 43 0 0x2>, /* Logical - DevToMem */
 			       <&dma 43 0 0x0>; /* Logical - MemToDev */
@@ -1094,7 +1095,7 @@
 		msp0: msp at 80123000 {
 			compatible = "stericsson,ux500-msp-i2s";
 			reg = <0x80123000 0x1000>;
-			interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 			v-ape-supply = <&db8500_vape_reg>;
 
 			dmas = <&dma 31 0 0x12>, /* Logical - DevToMem - HighPrio */
@@ -1110,7 +1111,7 @@
 		msp1: msp at 80124000 {
 			compatible = "stericsson,ux500-msp-i2s";
 			reg = <0x80124000 0x1000>;
-			interrupts = <0 62 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 			v-ape-supply = <&db8500_vape_reg>;
 
 			/* This DMA channel only exist on DB8500 v1 */
@@ -1127,7 +1128,7 @@
 		msp2: msp at 80117000 {
 			compatible = "stericsson,ux500-msp-i2s";
 			reg = <0x80117000 0x1000>;
-			interrupts = <0 98 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
 			v-ape-supply = <&db8500_vape_reg>;
 
 			dmas = <&dma 14 0 0x12>, /* Logical  - DevToMem - HighPrio */
@@ -1144,7 +1145,7 @@
 		msp3: msp at 80125000 {
 			compatible = "stericsson,ux500-msp-i2s";
 			reg = <0x80125000 0x1000>;
-			interrupts = <0 62 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 			v-ape-supply = <&db8500_vape_reg>;
 
 			/* This DMA channel only exist on DB8500 v2 */
@@ -1177,7 +1178,7 @@
 			      <0xa0351000 0x1000>, /* DSI link 1 */
 			      <0xa0352000 0x1000>, /* DSI link 2 */
 			      <0xa0353000 0x1000>; /* DSI link 3 */
-			interrupts = <0 48 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&prcmu_clk PRCMU_MCDECLK>, /* Main MCDE clock */
 				 <&prcmu_clk PRCMU_LCDCLK>, /* LCD clock */
 				 <&prcmu_clk PRCMU_PLLDSI>, /* HDMI clock */
@@ -1191,7 +1192,7 @@
 		cryp at a03cb000 {
 			compatible = "stericsson,ux500-cryp";
 			reg = <0xa03cb000 0x1000>;
-			interrupts = <0 15 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 
 			v-ape-supply = <&db8500_vape_reg>;
 			clocks = <&prcc_pclk 6 1>;
-- 
2.4.3
