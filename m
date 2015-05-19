From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Tue, 19 May 2015 20:52:50 +0900
Subject: [RESEND PATCH 1/2] ARM: dts: s3c2416: Add labels to S3C2416 nodes
Message-ID: <1432036371-6407-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new labels to certain nodes on S3C2416 so they could be easily
referenced by board DTS files.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/boot/dts/s3c2416.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/s3c2416.dtsi b/arch/arm/boot/dts/s3c2416.dtsi
index 30b8f7e47454..a5184ff56933 100644
--- a/arch/arm/boot/dts/s3c2416.dtsi
+++ b/arch/arm/boot/dts/s3c2416.dtsi
@@ -17,7 +17,7 @@
 	compatible = "samsung,s3c2416";
 
 	aliases {
-		serial3 = &uart3;
+		serial3 = &uart_3;
 	};
 
 	cpus {
@@ -48,7 +48,7 @@
 		clock-names = "timers";
 	};
 
-	serial at 50000000 {
+	uart_0: serial at 50000000 {
 		compatible = "samsung,s3c2440-uart";
 		clock-names = "uart", "clk_uart_baud2",
 				"clk_uart_baud3";
@@ -56,7 +56,7 @@
 				<&clocks SCLK_UART>;
 	};
 
-	serial at 50004000 {
+	uart_1: serial at 50004000 {
 		compatible = "samsung,s3c2440-uart";
 		clock-names = "uart", "clk_uart_baud2",
 				"clk_uart_baud3";
@@ -64,7 +64,7 @@
 				<&clocks SCLK_UART>;
 	};
 
-	serial at 50008000 {
+	uart_2: serial at 50008000 {
 		compatible = "samsung,s3c2440-uart";
 		clock-names = "uart", "clk_uart_baud2",
 				"clk_uart_baud3";
@@ -72,7 +72,7 @@
 				<&clocks SCLK_UART>;
 	};
 
-	uart3: serial at 5000C000 {
+	uart_3: serial at 5000C000 {
 		compatible = "samsung,s3c2440-uart";
 		reg = <0x5000C000 0x4000>;
 		interrupts = <1 18 24 4>, <1 18 25 4>;
@@ -83,7 +83,7 @@
 		status = "disabled";
 	};
 
-	sdhci at 4AC00000 {
+	sdhci_1: sdhci at 4AC00000 {
 		compatible = "samsung,s3c6410-sdhci";
 		reg = <0x4AC00000 0x100>;
 		interrupts = <0 0 21 3>;
@@ -94,7 +94,7 @@
 		status = "disabled";
 	};
 
-	sdhci at 4A800000 {
+	sdhci_0: sdhci at 4A800000 {
 		compatible = "samsung,s3c6410-sdhci";
 		reg = <0x4A800000 0x100>;
 		interrupts = <0 0 20 3>;
@@ -105,13 +105,13 @@
 		status = "disabled";
 	};
 
-	watchdog at 53000000 {
+	watchdog: watchdog at 53000000 {
 		interrupts = <1 9 27 3>;
 		clocks = <&clocks PCLK_WDT>;
 		clock-names = "watchdog";
 	};
 
-	rtc at 57000000 {
+	rtc: rtc at 57000000 {
 		compatible = "samsung,s3c2416-rtc";
 		clocks = <&clocks PCLK_RTC>;
 		clock-names = "rtc";
-- 
2.1.4
