From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Thu, 14 May 2015 19:53:50 +0900
Subject: [PATCH v3 5/8] ARM: dts: Use labels for overriding nodes in exynos542x
In-Reply-To: <1431600833-3361-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1431600833-3361-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1431600833-3361-6-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Usage of labels instead of full paths reduces possible mistakes when
overriding nodes. Additionally remove duplicated serial and uart labels
for serial.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts |  2 +-
 arch/arm/boot/dts/exynos5420.dtsi          | 82 +++++++++++++++---------------
 arch/arm/boot/dts/exynos5800-peach-pi.dts  |  2 +-
 3 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 146e71118a72..8f4d76c5e11c 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -1027,7 +1027,7 @@
 	};
 };
 
-&uart_3 {
+&serial_3 {
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 5246556e2e24..72908cb0a69e 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -323,13 +323,6 @@
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
@@ -500,26 +493,6 @@
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
@@ -535,14 +508,6 @@
 		#phy-cells = <0>;
 	};
 
-	dp: dp-controller at 145B0000 {
-		clocks = <&clock CLK_DP1>;
-		clock-names = "dp";
-		phys = <&dp_phy>;
-		phy-names = "dp";
-		power-domains = <&disp_pd>;
-	};
-
 	mipi_phy: video-phy at 10040714 {
 		compatible = "samsung,s5pv210-mipi-video-phy";
 		reg = <0x10040714 12>;
@@ -562,12 +527,6 @@
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
@@ -967,3 +926,44 @@
 		samsung,pmureg-phandle = <&pmu_system_controller>;
 	};
 };
+
+&dp {
+	clocks = <&clock CLK_DP1>;
+	clock-names = "dp";
+	phys = <&dp_phy>;
+	phy-names = "dp";
+	power-domains = <&disp_pd>;
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
index 02eb8b15374f..7d5b386b5ae6 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -990,7 +990,7 @@
 	};
 };
 
-&uart_3 {
+&serial_3 {
 	status = "okay";
 };
 
-- 
2.1.4
