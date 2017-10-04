From: joel@jms.id.au (Joel Stanley)
Date: Wed,  4 Oct 2017 17:19:16 +1030
Subject: [PATCH v2 8/9] ARM: dts: aspeed: Correctly order UART nodes
In-Reply-To: <20171004064917.2498-1-joel@jms.id.au>
References: <20171004064917.2498-1-joel@jms.id.au>
Message-ID: <20171004064917.2498-9-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Order them all by address.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 48 +++++++++++++++----------------
 arch/arm/boot/dts/aspeed-g5.dtsi | 61 ++++++++++++++++++++--------------------
 2 files changed, 54 insertions(+), 55 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index a549413bda3f..4125e07f22f9 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -183,6 +183,27 @@
 				clock-names = "PCLK";
 			};
 
+			uart1: serial at 1e783000 {
+				compatible = "ns16550a";
+				reg = <0x1e783000 0x1000>;
+				reg-shift = <2>;
+				interrupts = <9>;
+				clocks = <&clk_uart>;
+				no-loopback-test;
+				status = "disabled";
+			};
+
+			uart5: serial at 1e784000 {
+				compatible = "ns16550a";
+				reg = <0x1e784000 0x1000>;
+				reg-shift = <2>;
+				interrupts = <10>;
+				clocks = <&clk_uart>;
+				current-speed = <38400>;
+				no-loopback-test;
+				status = "disabled";
+			};
+
 			wdt1: wdt at 1e785000 {
 				compatible = "aspeed,ast2400-wdt";
 				reg = <0x1e785000 0x1c>;
@@ -197,11 +218,11 @@
 				status = "disabled";
 			};
 
-			uart1: serial at 1e783000 {
+			uart6: serial at 1e787000 {
 				compatible = "ns16550a";
-				reg = <0x1e783000 0x1000>;
+				reg = <0x1e787000 0x1000>;
 				reg-shift = <2>;
-				interrupts = <9>;
+				interrupts = <10>;
 				clocks = <&clk_uart>;
 				no-loopback-test;
 				status = "disabled";
@@ -237,27 +258,6 @@
 				status = "disabled";
 			};
 
-			uart5: serial at 1e784000 {
-				compatible = "ns16550a";
-				reg = <0x1e784000 0x1000>;
-				reg-shift = <2>;
-				interrupts = <10>;
-				clocks = <&clk_uart>;
-				current-speed = <38400>;
-				no-loopback-test;
-				status = "disabled";
-			};
-
-			uart6: serial at 1e787000 {
-				compatible = "ns16550a";
-				reg = <0x1e787000 0x1000>;
-				reg-shift = <2>;
-				interrupts = <10>;
-				clocks = <&clk_uart>;
-				no-loopback-test;
-				status = "disabled";
-			};
-
 			i2c: i2c at 1e78a000 {
 				compatible = "simple-bus";
 				#address-cells = <1>;
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index de2dafa71651..61cc2d25143a 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -227,6 +227,26 @@
 				clock-names = "PCLK";
 			};
 
+			uart1: serial at 1e783000 {
+				compatible = "ns16550a";
+				reg = <0x1e783000 0x1000>;
+				reg-shift = <2>;
+				interrupts = <9>;
+				clocks = <&clk_uart>;
+				no-loopback-test;
+				status = "disabled";
+			};
+
+			uart5: serial at 1e784000 {
+				compatible = "ns16550a";
+				reg = <0x1e784000 0x1000>;
+				reg-shift = <2>;
+				interrupts = <10>;
+				clocks = <&clk_uart>;
+				current-speed = <38400>;
+				no-loopback-test;
+				status = "disabled";
+			};
 
 			wdt1: wdt at 1e785000 {
 				compatible = "aspeed,ast2500-wdt";
@@ -247,16 +267,6 @@
 				status = "disabled";
 			};
 
-			uart1: serial at 1e783000 {
-				compatible = "ns16550a";
-				reg = <0x1e783000 0x1000>;
-				reg-shift = <2>;
-				interrupts = <9>;
-				clocks = <&clk_uart>;
-				no-loopback-test;
-				status = "disabled";
-			};
-
 			lpc: lpc at 1e789000 {
 				compatible = "aspeed,ast2500-lpc", "simple-mfd";
 				reg = <0x1e789000 0x1000>;
@@ -287,6 +297,16 @@
 				};
 			};
 
+			uart6: serial at 1e787000 {
+				compatible = "ns16550a";
+				reg = <0x1e787000 0x1000>;
+				reg-shift = <2>;
+				interrupts = <10>;
+				clocks = <&clk_uart>;
+				no-loopback-test;
+				status = "disabled";
+			};
+
 			uart2: serial at 1e78d000 {
 				compatible = "ns16550a";
 				reg = <0x1e78d000 0x1000>;
@@ -317,27 +337,6 @@
 				status = "disabled";
 			};
 
-			uart5: serial at 1e784000 {
-				compatible = "ns16550a";
-				reg = <0x1e784000 0x1000>;
-				reg-shift = <2>;
-				interrupts = <10>;
-				clocks = <&clk_uart>;
-				current-speed = <38400>;
-				no-loopback-test;
-				status = "disabled";
-			};
-
-			uart6: serial at 1e787000 {
-				compatible = "ns16550a";
-				reg = <0x1e787000 0x1000>;
-				reg-shift = <2>;
-				interrupts = <10>;
-				clocks = <&clk_uart>;
-				no-loopback-test;
-				status = "disabled";
-			};
-
 			i2c: i2c at 1e78a000 {
 				compatible = "simple-bus";
 				#address-cells = <1>;
-- 
2.14.1
