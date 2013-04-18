From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 18 Apr 2013 15:01:11 +0200
Subject: [PATCH 3/5] ARM: at91/at91sam9x5.dtsi: add UART0/1 nodes
In-Reply-To: <cover.1366289869.git.nicolas.ferre@atmel.com>
References: <cover.1366289869.git.nicolas.ferre@atmel.com>
Message-ID: <0209fb2e06ac4a81f614c8c3b8d7b154c52e8419.1366289869.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reported-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9x5.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 58747f3..2cc33fb 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -522,6 +522,24 @@
 				status = "disabled";
 			};
 
+			uart0: serial at f8040000 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xf8040000 0x200>;
+				interrupts = <15 4 5>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart0>;
+				status = "disabled";
+			};
+
+			uart1: serial at f8044000 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xf8044000 0x200>;
+				interrupts = <16 4 5>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart1>;
+				status = "disabled";
+			};
+
 			adc0: adc at f804c000 {
 				compatible = "atmel,at91sam9260-adc";
 				reg = <0xf804c000 0x100>;
-- 
1.8.0
