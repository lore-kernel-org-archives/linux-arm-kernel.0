From: joel@jms.id.au (Joel Stanley)
Date: Thu, 28 Sep 2017 17:21:49 +0930
Subject: [PATCH 8/8] ARM: dts: aspeed: Clean up UART nodes
In-Reply-To: <20170928075149.8154-1-joel@jms.id.au>
References: <20170928075149.8154-1-joel@jms.id.au>
Message-ID: <20170928075149.8154-9-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 - Shorten size of reg property so it covers only the implemented
 registers

 - Add VUART compatible

 - Move stray uart1 in g5 definition

 - Remove outdated current-speed property. Different bootloaders use
 different speeds, so this is no longer helpful

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 17 +++++++++--------
 arch/arm/boot/dts/aspeed-g5.dtsi | 36 ++++++++++++++++++------------------
 2 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 191c33d18122..7a4a53666d70 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -27,6 +27,7 @@
 		serial2 = &uart3;
 		serial3 = &uart4;
 		serial4 = &uart5;
+		serial5 = &vuart;
 	};
 
 	cpus {
@@ -199,7 +200,7 @@
 
 			uart1: serial at 1e783000 {
 				compatible = "ns16550a";
-				reg = <0x1e783000 0x1000>;
+				reg = <0x1e783000 0x20>;
 				reg-shift = <2>;
 				interrupts = <9>;
 				clocks = <&clk_uart>;
@@ -209,7 +210,7 @@
 
 			uart2: serial at 1e78d000 {
 				compatible = "ns16550a";
-				reg = <0x1e78d000 0x1000>;
+				reg = <0x1e78d000 0x20>;
 				reg-shift = <2>;
 				interrupts = <32>;
 				clocks = <&clk_uart>;
@@ -219,7 +220,7 @@
 
 			uart3: serial at 1e78e000 {
 				compatible = "ns16550a";
-				reg = <0x1e78e000 0x1000>;
+				reg = <0x1e78e000 0x20>;
 				reg-shift = <2>;
 				interrupts = <33>;
 				clocks = <&clk_uart>;
@@ -229,7 +230,7 @@
 
 			uart4: serial at 1e78f000 {
 				compatible = "ns16550a";
-				reg = <0x1e78f000 0x1000>;
+				reg = <0x1e78f000 0x20>;
 				reg-shift = <2>;
 				interrupts = <34>;
 				clocks = <&clk_uart>;
@@ -239,7 +240,7 @@
 
 			uart5: serial at 1e784000 {
 				compatible = "ns16550a";
-				reg = <0x1e784000 0x1000>;
+				reg = <0x1e784000 0x20>;
 				reg-shift = <2>;
 				interrupts = <10>;
 				clocks = <&clk_uart>;
@@ -248,9 +249,9 @@
 				status = "disabled";
 			};
 
-			uart6: serial at 1e787000 {
-				compatible = "ns16550a";
-				reg = <0x1e787000 0x1000>;
+			vuart: vuart at 1e787000 {
+				compatible = "aspeed,ast2400-vuart";
+				reg = <0x1e787000 0x40>;
 				reg-shift = <2>;
 				interrupts = <10>;
 				clocks = <&clk_uart>;
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 251fc9f4637e..0b793305120a 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -27,6 +27,7 @@
 		serial2 = &uart3;
 		serial3 = &uart4;
 		serial4 = &uart5;
+		serial5 = &vuart;
 	};
 
 	cpus {
@@ -247,16 +248,6 @@
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
@@ -287,9 +278,19 @@
 				};
 			};
 
+			uart1: serial at 1e783000 {
+				compatible = "ns16550a";
+				reg = <0x1e783000 0x20>;
+				reg-shift = <2>;
+				interrupts = <9>;
+				clocks = <&clk_uart>;
+				no-loopback-test;
+				status = "disabled";
+			};
+
 			uart2: serial at 1e78d000 {
 				compatible = "ns16550a";
-				reg = <0x1e78d000 0x1000>;
+				reg = <0x1e78d000 0x20>;
 				reg-shift = <2>;
 				interrupts = <32>;
 				clocks = <&clk_uart>;
@@ -299,7 +300,7 @@
 
 			uart3: serial at 1e78e000 {
 				compatible = "ns16550a";
-				reg = <0x1e78e000 0x1000>;
+				reg = <0x1e78e000 0x20>;
 				reg-shift = <2>;
 				interrupts = <33>;
 				clocks = <&clk_uart>;
@@ -309,7 +310,7 @@
 
 			uart4: serial at 1e78f000 {
 				compatible = "ns16550a";
-				reg = <0x1e78f000 0x1000>;
+				reg = <0x1e78f000 0x20>;
 				reg-shift = <2>;
 				interrupts = <34>;
 				clocks = <&clk_uart>;
@@ -319,18 +320,17 @@
 
 			uart5: serial at 1e784000 {
 				compatible = "ns16550a";
-				reg = <0x1e784000 0x1000>;
+				reg = <0x1e784000 0x20>;
 				reg-shift = <2>;
 				interrupts = <10>;
 				clocks = <&clk_uart>;
-				current-speed = <38400>;
 				no-loopback-test;
 				status = "disabled";
 			};
 
-			uart6: serial at 1e787000 {
-				compatible = "ns16550a";
-				reg = <0x1e787000 0x1000>;
+			vuart: vuart at 1e787000 {
+				compatible = "aspeed,ast2500-vuart";
+				reg = <0x1e787000 0x40>;
 				reg-shift = <2>;
 				interrupts = <10>;
 				clocks = <&clk_uart>;
-- 
2.14.1
