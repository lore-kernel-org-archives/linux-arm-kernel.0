From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 15 Mar 2016 11:08:11 +0900
Subject: [PATCH v2 3/7] ARM: dts: Add UART2 dt node for Exynos3250 SoC
In-Reply-To: <1458007695-3627-1-git-send-email-cw00.choi@samsung.com>
References: <1458007695-3627-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1458007695-3627-4-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pankaj Dubey <pankaj.dubey@samsung.com>

This patch add the uart2 devicetree node for Exynos3250 SoC.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi |  7 +++++++
 arch/arm/boot/dts/exynos3250.dtsi         | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250-pinctrl.dtsi b/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
index ecf79386e891..54c587f27265 100644
--- a/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
@@ -158,6 +158,13 @@
 		samsung,pin-drv = <0>;
 	};
 
+	uart2_data: uart2-data {
+		samsung,pins = "gpa1-0", "gpa1-1";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
 	i2c3_bus: i2c3-bus {
 		samsung,pins = "gpa1-2", "gpa1-3";
 		samsung,pin-function = <3>;
diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 18e3deffbf48..076677384d20 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -42,6 +42,7 @@
 		i2c7 = &i2c_7;
 		serial0 = &serial_0;
 		serial1 = &serial_1;
+		serial2 = &serial_2;
 	};
 
 	cpus {
@@ -465,6 +466,17 @@
 			status = "disabled";
 		};
 
+		serial_2: serial at 13820000 {
+			compatible = "samsung,exynos4210-uart";
+			reg = <0x13820000 0x100>;
+			interrupts = <0 111 0>;
+			clocks = <&cmu CLK_UART2>, <&cmu CLK_SCLK_UART2>;
+			clock-names = "uart", "clk_uart_baud0";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart2_data>;
+			status = "disabled";
+		};
+
 		i2c_0: i2c at 13860000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
1.9.1
