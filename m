From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 16 Sep 2016 23:41:56 +0200
Subject: [PATCH 1/7] arm64: dts: exynos: Use human-friendly symbols for
 interrupt properties in exynos7
In-Reply-To: <1474062122-22720-1-git-send-email-krzk@kernel.org>
References: <1474062122-22720-1-git-send-email-krzk@kernel.org>
Message-ID: <1474062122-22720-2-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace hard-coded values of type of GIC interrupt and its flags with
respective macros from header to increase code readability

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi | 32 +++++------
 arch/arm64/boot/dts/exynos/exynos7.dtsi         | 70 ++++++++++++-------------
 2 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
index 20f10e0f7c77..82321984e1fb 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
@@ -20,14 +20,14 @@
 		interrupt-controller;
 		interrupt-parent = <&gic>;
 		#interrupt-cells = <2>;
-		interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 1 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 2 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 3 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 4 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 5 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 6 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 7 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	gpa1: gpa1 {
@@ -37,14 +37,14 @@
 		interrupt-controller;
 		interrupt-parent = <&gic>;
 		#interrupt-cells = <2>;
-		interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 9 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 10 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 11 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 12 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 13 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 14 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 15 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	gpa2: gpa2 {
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index 0a80dabfbe95..4b5a1eadffb5 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -106,7 +106,7 @@
 			pdma0: pdma at 10E10000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0x10E10000 0x1000>;
-				interrupts = <0 225 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clock_fsys0 ACLK_PDMA0>;
 				clock-names = "apb_pclk";
 				#dma-cells = <1>;
@@ -117,7 +117,7 @@
 			pdma1: pdma at 10EB0000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0x10EB0000 0x1000>;
-				interrupts = <0 226 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clock_fsys0 ACLK_PDMA1>;
 				clock-names = "apb_pclk";
 				#dma-cells = <1>;
@@ -220,7 +220,7 @@
 		serial_0: serial at 13630000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x13630000 0x100>;
-			interrupts = <0 440 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock_peric0 PCLK_UART0>,
 				 <&clock_peric0 SCLK_UART0>;
 			clock-names = "uart", "clk_uart_baud0";
@@ -230,7 +230,7 @@
 		serial_1: serial at 14c20000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x14c20000 0x100>;
-			interrupts = <0 456 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock_peric1 PCLK_UART1>,
 				 <&clock_peric1 SCLK_UART1>;
 			clock-names = "uart", "clk_uart_baud0";
@@ -240,7 +240,7 @@
 		serial_2: serial at 14c30000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x14c30000 0x100>;
-			interrupts = <0 457 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock_peric1 PCLK_UART2>,
 				 <&clock_peric1 SCLK_UART2>;
 			clock-names = "uart", "clk_uart_baud0";
@@ -250,7 +250,7 @@
 		serial_3: serial at 14c40000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x14c40000 0x100>;
-			interrupts = <0 458 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock_peric1 PCLK_UART3>,
 				 <&clock_peric1 SCLK_UART3>;
 			clock-names = "uart", "clk_uart_baud0";
@@ -264,62 +264,62 @@
 			wakeup-interrupt-controller {
 				compatible = "samsung,exynos7-wakeup-eint";
 				interrupt-parent = <&gic>;
-				interrupts = <0 16 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
 		pinctrl_bus0: pinctrl at 13470000 {
 			compatible = "samsung,exynos7-pinctrl";
 			reg = <0x13470000 0x1000>;
-			interrupts = <0 383 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pinctrl_nfc: pinctrl at 14cd0000 {
 			compatible = "samsung,exynos7-pinctrl";
 			reg = <0x14cd0000 0x1000>;
-			interrupts = <0 473 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pinctrl_touch: pinctrl at 14ce0000 {
 			compatible = "samsung,exynos7-pinctrl";
 			reg = <0x14ce0000 0x1000>;
-			interrupts = <0 474 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pinctrl_ff: pinctrl at 14c90000 {
 			compatible = "samsung,exynos7-pinctrl";
 			reg = <0x14c90000 0x1000>;
-			interrupts = <0 475 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pinctrl_ese: pinctrl at 14ca0000 {
 			compatible = "samsung,exynos7-pinctrl";
 			reg = <0x14ca0000 0x1000>;
-			interrupts = <0 476 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 476 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pinctrl_fsys0: pinctrl at 10e60000 {
 			compatible = "samsung,exynos7-pinctrl";
 			reg = <0x10e60000 0x1000>;
-			interrupts = <0 221 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pinctrl_fsys1: pinctrl at 15690000 {
 			compatible = "samsung,exynos7-pinctrl";
 			reg = <0x15690000 0x1000>;
-			interrupts = <0 203 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pinctrl_bus1: pinctrl at 14870000 {
 			compatible = "samsung,exynos7-pinctrl";
 			reg = <0x14870000 0x1000>;
-			interrupts = <0 384 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		hsi2c_0: hsi2c at 13640000 {
 			compatible = "samsung,exynos7-hsi2c";
 			reg = <0x13640000 0x1000>;
-			interrupts = <0 441 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 441 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			pinctrl-names = "default";
@@ -332,7 +332,7 @@
 		hsi2c_1: hsi2c at 13650000 {
 			compatible = "samsung,exynos7-hsi2c";
 			reg = <0x13650000 0x1000>;
-			interrupts = <0 442 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 442 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			pinctrl-names = "default";
@@ -345,7 +345,7 @@
 		hsi2c_2: hsi2c at 14e60000 {
 			compatible = "samsung,exynos7-hsi2c";
 			reg = <0x14e60000 0x1000>;
-			interrupts = <0 459 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			pinctrl-names = "default";
@@ -358,7 +358,7 @@
 		hsi2c_3: hsi2c at 14e70000 {
 			compatible = "samsung,exynos7-hsi2c";
 			reg = <0x14e70000 0x1000>;
-			interrupts = <0 460 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			pinctrl-names = "default";
@@ -371,7 +371,7 @@
 		hsi2c_4: hsi2c at 13660000 {
 			compatible = "samsung,exynos7-hsi2c";
 			reg = <0x13660000 0x1000>;
-			interrupts = <0 443 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 443 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			pinctrl-names = "default";
@@ -384,7 +384,7 @@
 		hsi2c_5: hsi2c at 13670000 {
 			compatible = "samsung,exynos7-hsi2c";
 			reg = <0x13670000 0x1000>;
-			interrupts = <0 444 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			pinctrl-names = "default";
@@ -397,7 +397,7 @@
 		hsi2c_6: hsi2c at 14e00000 {
 			compatible = "samsung,exynos7-hsi2c";
 			reg = <0x14e00000 0x1000>;
-			interrupts = <0 461 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			pinctrl-names = "default";
@@ -410,7 +410,7 @@
 		hsi2c_7: hsi2c at 13e10000 {
 			compatible = "samsung,exynos7-hsi2c";
 			reg = <0x13e10000 0x1000>;
-			interrupts = <0 462 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			pinctrl-names = "default";
@@ -423,7 +423,7 @@
 		hsi2c_8: hsi2c at 14e20000 {
 			compatible = "samsung,exynos7-hsi2c";
 			reg = <0x14e20000 0x1000>;
-			interrupts = <0 463 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			pinctrl-names = "default";
@@ -436,7 +436,7 @@
 		hsi2c_9: hsi2c at 13680000 {
 			compatible = "samsung,exynos7-hsi2c";
 			reg = <0x13680000 0x1000>;
-			interrupts = <0 445 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			pinctrl-names = "default";
@@ -449,7 +449,7 @@
 		hsi2c_10: hsi2c at 13690000 {
 			compatible = "samsung,exynos7-hsi2c";
 			reg = <0x13690000 0x1000>;
-			interrupts = <0 446 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			pinctrl-names = "default";
@@ -462,7 +462,7 @@
 		hsi2c_11: hsi2c at 136a0000 {
 			compatible = "samsung,exynos7-hsi2c";
 			reg = <0x136a0000 0x1000>;
-			interrupts = <0 447 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			pinctrl-names = "default";
@@ -499,8 +499,8 @@
 		rtc: rtc at 10590000 {
 			compatible = "samsung,s3c6410-rtc";
 			reg = <0x10590000 0x100>;
-			interrupts = <0 355 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 356 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock_ccore PCLK_RTC>;
 			clock-names = "rtc";
 			status = "disabled";
@@ -509,7 +509,7 @@
 		watchdog: watchdog at 101d0000 {
 			compatible = "samsung,exynos7-wdt";
 			reg = <0x101d0000 0x100>;
-			interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock_peris PCLK_WDT>;
 			clock-names = "watchdog";
 			samsung,syscon-phandle = <&pmu_system_controller>;
@@ -518,7 +518,7 @@
 
 		mmc_0: mmc at 15740000 {
 			compatible = "samsung,exynos7-dw-mshc-smu";
-			interrupts = <0 201 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x15740000 0x2000>;
@@ -531,7 +531,7 @@
 
 		mmc_1: mmc at 15750000 {
 			compatible = "samsung,exynos7-dw-mshc";
-			interrupts = <0 202 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x15750000 0x2000>;
@@ -544,7 +544,7 @@
 
 		mmc_2: mmc at 15560000 {
 			compatible = "samsung,exynos7-dw-mshc-smu";
-			interrupts = <0 216 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x15560000 0x2000>;
@@ -558,7 +558,7 @@
 		adc: adc at 13620000 {
 			compatible = "samsung,exynos7-adc";
 			reg = <0x13620000 0x100>;
-			interrupts = <0 448 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock_peric0 PCLK_ADCIF>;
 			clock-names = "adc";
 			#io-channel-cells = <1>;
@@ -578,7 +578,7 @@
 		tmuctrl_0: tmu at 10060000 {
 			compatible = "samsung,exynos7-tmu";
 			reg = <0x10060000 0x200>;
-			interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock_peris PCLK_TMU>,
 				 <&clock_peris SCLK_TMU>;
 			clock-names = "tmu_apbif", "tmu_sclk";
-- 
2.7.4
