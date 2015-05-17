From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sun, 17 May 2015 17:26:09 +0900
Subject: [PATCH v4 2/8] ARM: dts: Use labels for overriding nodes in exynos5250
In-Reply-To: <1431851175-32624-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1431851175-32624-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1431851175-32624-3-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Usage of labels instead of full paths reduces possible mistakes when
overriding nodes.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/boot/dts/exynos5250.dtsi | 82 +++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 257e2f10525d..916871bb3f05 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -241,13 +241,6 @@
 		clock-names = "mfc";
 	};
 
-	rtc: rtc at 101E0000 {
-		clocks = <&clock CLK_RTC>;
-		clock-names = "rtc";
-		interrupt-parent = <&pmu_system_controller>;
-		status = "disabled";
-	};
-
 	tmu: tmu at 10060000 {
 		compatible = "samsung,exynos5250-tmu";
 		reg = <0x10060000 0x100>;
@@ -276,26 +269,6 @@
 		};
 	};
 
-	serial at 12C00000 {
-		clocks = <&clock CLK_UART0>, <&clock CLK_SCLK_UART0>;
-		clock-names = "uart", "clk_uart_baud0";
-	};
-
-	serial at 12C10000 {
-		clocks = <&clock CLK_UART1>, <&clock CLK_SCLK_UART1>;
-		clock-names = "uart", "clk_uart_baud0";
-	};
-
-	serial at 12C20000 {
-		clocks = <&clock CLK_UART2>, <&clock CLK_SCLK_UART2>;
-		clock-names = "uart", "clk_uart_baud0";
-	};
-
-	serial at 12C30000 {
-		clocks = <&clock CLK_UART3>, <&clock CLK_SCLK_UART3>;
-		clock-names = "uart", "clk_uart_baud0";
-	};
-
 	sata: sata at 122F0000 {
 		compatible = "snps,dwc-ahci";
 		samsung,sata-freq = <66>;
@@ -778,20 +751,6 @@
 		#phy-cells = <0>;
 	};
 
-	dp: dp-controller at 145B0000 {
-		power-domains = <&pd_disp1>;
-		clocks = <&clock CLK_DP>;
-		clock-names = "dp";
-		phys = <&dp_phy>;
-		phy-names = "dp";
-	};
-
-	fimd: fimd at 14400000 {
-		power-domains = <&pd_disp1>;
-		clocks = <&clock CLK_SCLK_FIMD1>, <&clock CLK_FIMD1>;
-		clock-names = "sclk_fimd", "fimd";
-	};
-
 	adc: adc at 12D10000 {
 		compatible = "samsung,exynos-adc-v1";
 		reg = <0x12D10000 0x100>;
@@ -812,3 +771,44 @@
 		clock-names = "secss";
 	};
 };
+
+&dp {
+	power-domains = <&pd_disp1>;
+	clocks = <&clock CLK_DP>;
+	clock-names = "dp";
+	phys = <&dp_phy>;
+	phy-names = "dp";
+};
+
+&fimd {
+	power-domains = <&pd_disp1>;
+	clocks = <&clock CLK_SCLK_FIMD1>, <&clock CLK_FIMD1>;
+	clock-names = "sclk_fimd", "fimd";
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
-- 
2.1.4
