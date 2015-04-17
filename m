From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Fri, 17 Apr 2015 22:56:24 +0900
Subject: [PATCH v2 5/7] ARM: dts: exynos5: Use labels for overriding nodes in
 Exynos5420
In-Reply-To: <1429278986-4374-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1429278986-4374-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1429278986-4374-6-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Usage of labels instead of full paths reduces possible mistakes when
overriding nodes. Additionally remove duplicated serial and uart labels
for serial

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts |  2 +-
 arch/arm/boot/dts/exynos5420.dtsi          | 80 +++++++++++++++---------------
 arch/arm/boot/dts/exynos5800-peach-pi.dts  |  2 +-
 3 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 0788d08fb43e..d5921ffe1e0e 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -1026,7 +1026,7 @@
 	};
 };
 
-&uart_3 {
+&serial_3 {
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index f67b23f303c3..0ba0004aae44 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -328,13 +328,6 @@
 		interrupts = <0 47 0>;
 	};
 
-	rtc: rtc at 101E0000 {
-		clocks = <&clock CLK_RTC>;
-		clock-names = "rtc";
-		interrupt-parent = <&pmu_system_controller>;
-		status = "disabled";
-	};
-
 	amba {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -496,26 +489,6 @@
 		status = "disabled";
 	};
 
-	uart_0: serial at 12C00000 {
-		clocks = <&clock CLK_UART0>, <&clock CLK_SCLK_UART0>;
-		clock-names = "uart", "clk_uart_baud0";
-	};
-
-	uart_1: serial at 12C10000 {
-		clocks = <&clock CLK_UART1>, <&clock CLK_SCLK_UART1>;
-		clock-names = "uart", "clk_uart_baud0";
-	};
-
-	uart_2: serial at 12C20000 {
-		clocks = <&clock CLK_UART2>, <&clock CLK_SCLK_UART2>;
-		clock-names = "uart", "clk_uart_baud0";
-	};
-
-	uart_3: serial at 12C30000 {
-		clocks = <&clock CLK_UART3>, <&clock CLK_SCLK_UART3>;
-		clock-names = "uart", "clk_uart_baud0";
-	};
-
 	pwm: pwm at 12dd0000 {
 		compatible = "samsung,exynos4210-pwm";
 		reg = <0x12dd0000 0x100>;
@@ -531,13 +504,6 @@
 		#phy-cells = <0>;
 	};
 
-	dp: dp-controller at 145B0000 {
-		clocks = <&clock CLK_DP1>;
-		clock-names = "dp";
-		phys = <&dp_phy>;
-		phy-names = "dp";
-	};
-
 	mipi_phy: video-phy at 10040714 {
 		compatible = "samsung,s5pv210-mipi-video-phy";
 		reg = <0x10040714 12>;
@@ -557,12 +523,6 @@
 		status = "disabled";
 	};
 
-	fimd: fimd at 14400000 {
-		clocks = <&clock CLK_SCLK_FIMD1>, <&clock CLK_FIMD1>;
-		clock-names = "sclk_fimd", "fimd";
-		power-domains = <&disp_pd>;
-	};
-
 	adc: adc at 12D10000 {
 		compatible = "samsung,exynos-adc-v2";
 		reg = <0x12D10000 0x100>;
@@ -962,3 +922,43 @@
 		samsung,pmureg-phandle = <&pmu_system_controller>;
 	};
 };
+
+&dp {
+	clocks = <&clock CLK_DP1>;
+	clock-names = "dp";
+	phys = <&dp_phy>;
+	phy-names = "dp";
+};
+
+&fimd {
+	clocks = <&clock CLK_SCLK_FIMD1>, <&clock CLK_FIMD1>;
+	clock-names = "sclk_fimd", "fimd";
+	power-domains = <&disp_pd>;
+};
+
+&rtc {
+	clocks = <&clock CLK_RTC>;
+	clock-names = "rtc";
+	interrupt-parent = <&pmu_system_controller>;
+	status = "disabled";
+};
+
+&serial_0 {
+	clocks = <&clock CLK_UART0>, <&clock CLK_SCLK_UART0>;
+	clock-names = "uart", "clk_uart_baud0";
+};
+
+&serial_1 {
+	clocks = <&clock CLK_UART1>, <&clock CLK_SCLK_UART1>;
+	clock-names = "uart", "clk_uart_baud0";
+};
+
+&serial_2 {
+	clocks = <&clock CLK_UART2>, <&clock CLK_SCLK_UART2>;
+	clock-names = "uart", "clk_uart_baud0";
+};
+
+&serial_3 {
+	clocks = <&clock CLK_UART3>, <&clock CLK_SCLK_UART3>;
+	clock-names = "uart", "clk_uart_baud0";
+};
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 412f41d62686..3a1c46378460 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -989,7 +989,7 @@
 	};
 };
 
-&uart_3 {
+&serial_3 {
 	status = "okay";
 };
 
-- 
2.1.0
