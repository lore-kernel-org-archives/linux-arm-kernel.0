From: joel@jms.id.au (Joel Stanley)
Date: Mon, 19 Feb 2018 18:05:40 +1030
Subject: [PATCH] ARM: dts: aspeed: Add LPC reset controller node
Message-ID: <20180219073540.24520-1-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On both the ast2400 and ast2500 SoCs, the LPC reset controller is
required to bring the UARTs out of reset without waiting for the LPC
reset to be deasserted.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
Bindings and driver change is under reivew:
  https://lkml.org/lkml/2018/2/19/12

 arch/arm/boot/dts/aspeed-g4.dtsi | 10 ++++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 48c28a71ae7e..36ae23aa3b48 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -162,6 +162,7 @@
 				reg-shift = <2>;
 				interrupts = <9>;
 				clocks = <&syscon ASPEED_CLK_GATE_UART1CLK>;
+				resets = <&lpc_reset 4>;
 				no-loopback-test;
 				status = "disabled";
 			};
@@ -249,6 +250,12 @@
 						reg = <0x20 0x24 0x48 0x8>;
 					};
 
+					lpc_reset: reset-controller at 18 {
+						compatible = "aspeed,ast2400-lpc-reset";
+						reg = <0x18 0x4>;
+						#reset-cells = <1>;
+					};
+
 					ibt: ibt at c0  {
 						compatible = "aspeed,ast2400-ibt-bmc";
 						reg = <0xc0 0x18>;
@@ -264,6 +271,7 @@
 				reg-shift = <2>;
 				interrupts = <32>;
 				clocks = <&syscon ASPEED_CLK_GATE_UART2CLK>;
+				resets = <&lpc_reset 5>;
 				no-loopback-test;
 				status = "disabled";
 			};
@@ -274,6 +282,7 @@
 				reg-shift = <2>;
 				interrupts = <33>;
 				clocks = <&syscon ASPEED_CLK_GATE_UART3CLK>;
+				resets = <&lpc_reset 6>;
 				no-loopback-test;
 				status = "disabled";
 			};
@@ -284,6 +293,7 @@
 				reg-shift = <2>;
 				interrupts = <34>;
 				clocks = <&syscon ASPEED_CLK_GATE_UART4CLK>;
+				resets = <&lpc_reset 7>;
 				no-loopback-test;
 				status = "disabled";
 			};
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 8eac57c33880..17ee0fa33a14 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -205,6 +205,7 @@
 				reg-shift = <2>;
 				interrupts = <9>;
 				clocks = <&syscon ASPEED_CLK_GATE_UART1CLK>;
+				resets = <&lpc_reset 4>;
 				no-loopback-test;
 				status = "disabled";
 			};
@@ -299,6 +300,12 @@
 						reg = <0x20 0x24 0x48 0x8>;
 					};
 
+					lpc_reset: reset-controller at 18 {
+						compatible = "aspeed,ast2500-lpc-reset";
+						reg = <0x18 0x4>;
+						#reset-cells = <1>;
+					};
+
 					ibt: ibt at c0 {
 						compatible = "aspeed,ast2500-ibt-bmc";
 						reg = <0xc0 0x18>;
@@ -314,6 +321,7 @@
 				reg-shift = <2>;
 				interrupts = <32>;
 				clocks = <&syscon ASPEED_CLK_GATE_UART2CLK>;
+				resets = <&lpc_reset 5>;
 				no-loopback-test;
 				status = "disabled";
 			};
@@ -324,6 +332,7 @@
 				reg-shift = <2>;
 				interrupts = <33>;
 				clocks = <&syscon ASPEED_CLK_GATE_UART3CLK>;
+				resets = <&lpc_reset 6>;
 				no-loopback-test;
 				status = "disabled";
 			};
@@ -334,6 +343,7 @@
 				reg-shift = <2>;
 				interrupts = <34>;
 				clocks = <&syscon ASPEED_CLK_GATE_UART4CLK>;
+				resets = <&lpc_reset 7>;
 				no-loopback-test;
 				status = "disabled";
 			};
-- 
2.15.1
