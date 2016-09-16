From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 16 Sep 2016 23:42:01 +0200
Subject: [PATCH 6/7] ARM: dts: exynos: Use human-friendly symbols for
 interrupt properties in exynos5260
In-Reply-To: <1474062122-22720-1-git-send-email-krzk@kernel.org>
References: <1474062122-22720-1-git-send-email-krzk@kernel.org>
Message-ID: <1474062122-22720-7-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace hard-coded values of type of GIC interrupt and its flags with
respective macros from header to increase code readability

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5260.dtsi | 50 ++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
index b0848a3d3d88..5818718618b1 100644
--- a/arch/arm/boot/dts/exynos5260.dtsi
+++ b/arch/arm/boot/dts/exynos5260.dtsi
@@ -10,6 +10,7 @@
 */
 
 #include <dt-bindings/clock/exynos5260-clk.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
@@ -169,7 +170,8 @@
 				<0x10482000 0x1000>,
 				<0x10484000 0x2000>,
 				<0x10486000 0x2000>;
-			interrupts = <1 9 0xf04>;
+			interrupts = <GIC_PPI 9
+					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
 		chipid: chipid at 10000000 {
@@ -182,18 +184,18 @@
 			reg = <0x100B0000 0x1000>;
 			clocks = <&fin_pll>, <&clock_peri PERI_CLK_MCT>;
 			clock-names = "fin_pll", "mct";
-			interrupts = <0 104 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 105 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 106 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 107 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 122 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 123 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 124 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 125 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 126 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 127 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 128 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 129 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		cci: cci at 10F00000 {
@@ -219,25 +221,25 @@
 		pinctrl_0: pinctrl at 11600000 {
 			compatible = "samsung,exynos5260-pinctrl";
 			reg = <0x11600000 0x1000>;
-			interrupts = <0 79 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
 
 			wakeup-interrupt-controller {
 				compatible = "samsung,exynos4210-wakeup-eint";
 				interrupt-parent = <&gic>;
-				interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
 		pinctrl_1: pinctrl at 12290000 {
 			compatible = "samsung,exynos5260-pinctrl";
 			reg = <0x12290000 0x1000>;
-			interrupts = <0 157 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pinctrl_2: pinctrl at 128B0000 {
 			compatible = "samsung,exynos5260-pinctrl";
 			reg = <0x128B0000 0x1000>;
-			interrupts = <0 243 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pmu_system_controller: system-controller at 10D50000 {
@@ -248,7 +250,7 @@
 		uart0: serial at 12C00000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x12C00000 0x100>;
-			interrupts = <0 146 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock_peri PERI_CLK_UART0>, <&clock_peri PERI_SCLK_UART0>;
 			clock-names = "uart", "clk_uart_baud0";
 			status = "disabled";
@@ -257,7 +259,7 @@
 		uart1: serial at 12C10000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x12C10000 0x100>;
-			interrupts = <0 147 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock_peri PERI_CLK_UART1>, <&clock_peri PERI_SCLK_UART1>;
 			clock-names = "uart", "clk_uart_baud0";
 			status = "disabled";
@@ -266,7 +268,7 @@
 		uart2: serial at 12C20000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x12C20000 0x100>;
-			interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock_peri PERI_CLK_UART2>, <&clock_peri PERI_SCLK_UART2>;
 			clock-names = "uart", "clk_uart_baud0";
 			status = "disabled";
@@ -275,7 +277,7 @@
 		uart3: serial at 12860000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x12860000 0x100>;
-			interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock_aud AUD_CLK_AUD_UART>, <&clock_aud AUD_SCLK_AUD_UART>;
 			clock-names = "uart", "clk_uart_baud0";
 			status = "disabled";
@@ -284,7 +286,7 @@
 		mmc_0: mmc at 12140000 {
 			compatible = "samsung,exynos5250-dw-mshc";
 			reg = <0x12140000 0x2000>;
-			interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&clock_fsys FSYS_CLK_MMC0>, <&clock_top TOP_SCLK_MMC0>;
@@ -296,7 +298,7 @@
 		mmc_1: mmc at 12150000 {
 			compatible = "samsung,exynos5250-dw-mshc";
 			reg = <0x12150000 0x2000>;
-			interrupts = <0 158 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&clock_fsys FSYS_CLK_MMC1>, <&clock_top TOP_SCLK_MMC1>;
@@ -308,7 +310,7 @@
 		mmc_2: mmc at 12160000 {
 			compatible = "samsung,exynos5250-dw-mshc";
 			reg = <0x12160000 0x2000>;
-			interrupts = <0 159 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&clock_fsys FSYS_CLK_MMC2>, <&clock_top TOP_SCLK_MMC2>;
-- 
2.7.4
