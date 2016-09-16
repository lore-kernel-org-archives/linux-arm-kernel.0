From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 16 Sep 2016 23:42:02 +0200
Subject: [PATCH 7/7] ARM: dts: exynos: Use human-friendly symbols for
 interrupt properties in exynos5440
In-Reply-To: <1474062122-22720-1-git-send-email-krzk@kernel.org>
References: <1474062122-22720-1-git-send-email-krzk@kernel.org>
Message-ID: <1474062122-22720-8-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace hard-coded values of type of GIC interrupt and its flags with
respective macros from header to increase code readability

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5440.dtsi | 80 ++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 39 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 20f600225121..97c9f0e38526 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -10,6 +10,7 @@
 */
 
 #include <dt-bindings/clock/exynos5440.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
@@ -42,7 +43,8 @@
 			<0x2E2000 0x1000>,
 			<0x2E4000 0x2000>,
 			<0x2E6000 0x2000>;
-		interrupts = <1 9 0xf04>;
+		interrupts = <GIC_PPI 9
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
 	cpus {
@@ -73,26 +75,26 @@
 
 	arm-pmu {
 		compatible = "arm,cortex-a15-pmu", "arm,cortex-a9-pmu";
-		interrupts = <0 52 4>,
-			     <0 53 4>,
-			     <0 54 4>,
-			     <0 55 4>;
+		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	timer {
 		compatible = "arm,cortex-a15-timer",
 			     "arm,armv7-timer";
-		interrupts = <1 13 0xf08>,
-			     <1 14 0xf08>,
-			     <1 11 0xf08>,
-			     <1 10 0xf08>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 		clock-frequency = <50000000>;
 	};
 
 	cpufreq at 160000 {
 		compatible = "samsung,exynos5440-cpufreq";
 		reg = <0x160000 0x1000>;
-		interrupts = <0 57 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 		operating-points = <
 				/* KHz	  uV */
 				1500000 1100000
@@ -109,7 +111,7 @@
 	serial_0: serial@B0000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0xB0000 0x1000>;
-		interrupts = <0 2 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_B_125>, <&clock CLK_B_125>;
 		clock-names = "uart", "clk_uart_baud0";
 	};
@@ -117,7 +119,7 @@
 	serial_1: serial at C0000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0xC0000 0x1000>;
-		interrupts = <0 3 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_B_125>, <&clock CLK_B_125>;
 		clock-names = "uart", "clk_uart_baud0";
 	};
@@ -125,7 +127,7 @@
 	spi_0: spi at D0000 {
 		compatible = "samsung,exynos5440-spi";
 		reg = <0xD0000 0x100>;
-		interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		samsung,spi-src-clk = <0>;
@@ -137,14 +139,14 @@
 	pin_ctrl: pinctrl at E0000 {
 		compatible = "samsung,exynos5440-pinctrl";
 		reg = <0xE0000 0x1000>;
-		interrupts = <0 37 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 38 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 39 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 40 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 41 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 42 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 43 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 44 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		#gpio-cells = <2>;
@@ -169,7 +171,7 @@
 	i2c at F0000 {
 		compatible = "samsung,exynos5440-i2c";
 		reg = <0xF0000 0x1000>;
-		interrupts = <0 5 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&clock CLK_B_125>;
@@ -179,7 +181,7 @@
 	i2c at 100000 {
 		compatible = "samsung,exynos5440-i2c";
 		reg = <0x100000 0x1000>;
-		interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&clock CLK_B_125>;
@@ -189,7 +191,7 @@
 	watchdog at 110000 {
 		compatible = "samsung,s3c2410-wdt";
 		reg = <0x110000 0x1000>;
-		interrupts = <0 1 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_B_125>;
 		clock-names = "watchdog";
 	};
@@ -198,7 +200,7 @@
 		compatible = "snps,dwmac-3.70a";
 		reg = <0x00230000 0x8000>;
 		interrupt-parent = <&gic>;
-		interrupts = <0 31 4>;
+		interrupts = <GIC_SPI 31 4>;
 		interrupt-names = "macirq";
 		phy-mode = "sgmii";
 		clocks = <&clock CLK_GMAC0>;
@@ -216,8 +218,8 @@
 	rtc at 130000 {
 		compatible = "samsung,s3c6410-rtc";
 		reg = <0x130000 0x1000>;
-		interrupts = <0 17 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 16 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_B_125>;
 		clock-names = "rtc";
 	};
@@ -225,7 +227,7 @@
 	tmuctrl_0: tmuctrl at 160118 {
 		compatible = "samsung,exynos5440-tmu";
 		reg = <0x160118 0x230>, <0x160368 0x10>;
-		interrupts = <0 58 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_B_125>;
 		clock-names = "tmu_apbif";
 		#include "exynos5440-tmu-sensor-conf.dtsi"
@@ -234,7 +236,7 @@
 	tmuctrl_1: tmuctrl at 16011C {
 		compatible = "samsung,exynos5440-tmu";
 		reg = <0x16011C 0x230>, <0x160368 0x10>;
-		interrupts = <0 58 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_B_125>;
 		clock-names = "tmu_apbif";
 		#include "exynos5440-tmu-sensor-conf.dtsi"
@@ -243,7 +245,7 @@
 	tmuctrl_2: tmuctrl at 160120 {
 		compatible = "samsung,exynos5440-tmu";
 		reg = <0x160120 0x230>, <0x160368 0x10>;
-		interrupts = <0 58 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_B_125>;
 		clock-names = "tmu_apbif";
 		#include "exynos5440-tmu-sensor-conf.dtsi"
@@ -267,7 +269,7 @@
 	sata at 210000 {
 		compatible = "snps,exynos5440-ahci";
 		reg = <0x210000 0x10000>;
-		interrupts = <0 30 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_SATA>;
 		clock-names = "sata";
 	};
@@ -275,7 +277,7 @@
 	ohci at 220000 {
 		compatible = "samsung,exynos5440-ohci";
 		reg = <0x220000 0x1000>;
-		interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_USB>;
 		clock-names = "usbhost";
 	};
@@ -283,7 +285,7 @@
 	ehci at 221000 {
 		compatible = "samsung,exynos5440-ehci";
 		reg = <0x221000 0x1000>;
-		interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_USB>;
 		clock-names = "usbhost";
 	};
@@ -293,9 +295,9 @@
 		reg = <0x290000 0x1000
 			0x270000 0x1000
 			0x271000 0x40>;
-		interrupts = <0 20 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 21 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 22 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_PR0_250_O>, <&clock CLK_PB0_250_O>;
 		clock-names = "pcie", "pcie_bus";
 		#address-cells = <3>;
@@ -316,9 +318,9 @@
 		reg = <0x2a0000 0x1000
 			0x272000 0x1000
 			0x271040 0x40>;
-		interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 24 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 25 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_PR1_250_O>, <&clock CLK_PB0_250_O>;
 		clock-names = "pcie", "pcie_bus";
 		#address-cells = <3>;
-- 
2.7.4
