From: joel@jms.id.au (Joel Stanley)
Date: Wed,  4 Oct 2017 17:19:17 +1030
Subject: [PATCH v2 9/9] ARM: dts: aspeed: Clean up UART nodes
In-Reply-To: <20171004064917.2498-1-joel@jms.id.au>
References: <20171004064917.2498-1-joel@jms.id.au>
Message-ID: <20171004064917.2498-10-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 - Shorten size of reg property so it covers only the implemented
 registers

 - Add VUART compatible, and change node name to serial@

 - Remove outdated current-speed property. Different bootloaders use
 different speeds, so this is no longer helpful

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2:
 - move node reordering to seperate patch
 - fix vuart node name
 - actually remove current-speed from g4
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 18 +++++++++---------
 arch/arm/boot/dts/aspeed-g5.dtsi | 18 +++++++++---------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 4125e07f22f9..e455bd236798 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -27,6 +27,7 @@
 		serial2 = &uart3;
 		serial3 = &uart4;
 		serial4 = &uart5;
+		serial5 = &vuart;
 	};
 
 	cpus {
@@ -185,7 +186,7 @@
 
 			uart1: serial at 1e783000 {
 				compatible = "ns16550a";
-				reg = <0x1e783000 0x1000>;
+				reg = <0x1e783000 0x20>;
 				reg-shift = <2>;
 				interrupts = <9>;
 				clocks = <&clk_uart>;
@@ -195,11 +196,10 @@
 
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
@@ -218,9 +218,9 @@
 				status = "disabled";
 			};
 
-			uart6: serial at 1e787000 {
-				compatible = "ns16550a";
-				reg = <0x1e787000 0x1000>;
+			vuart: serial at 1e787000 {
+				compatible = "aspeed,ast2400-vuart";
+				reg = <0x1e787000 0x40>;
 				reg-shift = <2>;
 				interrupts = <10>;
 				clocks = <&clk_uart>;
@@ -230,7 +230,7 @@
 
 			uart2: serial at 1e78d000 {
 				compatible = "ns16550a";
-				reg = <0x1e78d000 0x1000>;
+				reg = <0x1e78d000 0x20>;
 				reg-shift = <2>;
 				interrupts = <32>;
 				clocks = <&clk_uart>;
@@ -240,7 +240,7 @@
 
 			uart3: serial at 1e78e000 {
 				compatible = "ns16550a";
-				reg = <0x1e78e000 0x1000>;
+				reg = <0x1e78e000 0x20>;
 				reg-shift = <2>;
 				interrupts = <33>;
 				clocks = <&clk_uart>;
@@ -250,7 +250,7 @@
 
 			uart4: serial at 1e78f000 {
 				compatible = "ns16550a";
-				reg = <0x1e78f000 0x1000>;
+				reg = <0x1e78f000 0x20>;
 				reg-shift = <2>;
 				interrupts = <34>;
 				clocks = <&clk_uart>;
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 61cc2d25143a..cef51dcc1002 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -27,6 +27,7 @@
 		serial2 = &uart3;
 		serial3 = &uart4;
 		serial4 = &uart5;
+		serial5 = &vuart;
 	};
 
 	cpus {
@@ -229,7 +230,7 @@
 
 			uart1: serial at 1e783000 {
 				compatible = "ns16550a";
-				reg = <0x1e783000 0x1000>;
+				reg = <0x1e783000 0x20>;
 				reg-shift = <2>;
 				interrupts = <9>;
 				clocks = <&clk_uart>;
@@ -239,11 +240,10 @@
 
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
@@ -297,9 +297,9 @@
 				};
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
@@ -309,7 +309,7 @@
 
 			uart2: serial at 1e78d000 {
 				compatible = "ns16550a";
-				reg = <0x1e78d000 0x1000>;
+				reg = <0x1e78d000 0x20>;
 				reg-shift = <2>;
 				interrupts = <32>;
 				clocks = <&clk_uart>;
@@ -319,7 +319,7 @@
 
 			uart3: serial at 1e78e000 {
 				compatible = "ns16550a";
-				reg = <0x1e78e000 0x1000>;
+				reg = <0x1e78e000 0x20>;
 				reg-shift = <2>;
 				interrupts = <33>;
 				clocks = <&clk_uart>;
@@ -329,7 +329,7 @@
 
 			uart4: serial at 1e78f000 {
 				compatible = "ns16550a";
-				reg = <0x1e78f000 0x1000>;
+				reg = <0x1e78f000 0x20>;
 				reg-shift = <2>;
 				interrupts = <34>;
 				clocks = <&clk_uart>;
-- 
2.14.1
