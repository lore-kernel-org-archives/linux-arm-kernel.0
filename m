From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 28 Nov 2014 17:49:27 +0100
Subject: [PATCH 2/2] ARM: at91/dt: sama5d4: add pioD controller
In-Reply-To: <1417193367-12422-1-git-send-email-ludovic.desroches@atmel.com>
References: <1417193367-12422-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1417193367-12422-2-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PioD controller was not described in the device tree since we don't use
it. As pinctrl-at91 allows disabled gpio controllers in the device
tree, we can add it to complete the device description.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/boot/dts/sama5d4.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index e0157b0..2cc3cfe 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -61,6 +61,7 @@
 		gpio0 = &pioA;
 		gpio1 = &pioB;
 		gpio2 = &pioC;
+		gpio3 = &pioD;
 		gpio4 = &pioE;
 		tcb0 = &tcb0;
 		tcb1 = &tcb1;
@@ -1042,6 +1043,18 @@
 					clocks = <&pioC_clk>;
 				};
 
+				pioD: gpio at fc068000 {
+					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
+					reg = <0xfc068000 0x100>;
+					interrupts = <5 IRQ_TYPE_LEVEL_HIGH 1>;
+					#gpio-cells = <2>;
+					gpio-controller;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					clocks = <&pioD_clk>;
+					status = "disabled";
+				};
+
 				pioE: gpio at fc06d000 {
 					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
 					reg = <0xfc06d000 0x100>;
-- 
2.0.3
