From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 16 Sep 2015 17:37:00 +0200
Subject: [PATCH v2 4/7] ARM: at91/dt: sama5d2: add pio controller node
In-Reply-To: <1442417823-15850-1-git-send-email-ludovic.desroches@atmel.com>
References: <1442417823-15850-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1442417823-15850-5-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pio4 controller node to enable pinmux and gpio.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 034cd48..cc05cde 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -921,6 +921,20 @@
 				clocks = <&twi1_clk>;
 				status = "disabled";
 			};
+
+			pioA: pinctrl at fc038000 {
+				compatible = "atmel,sama5d2-pinctrl";
+				reg = <0xfc038000 0x600>;
+				interrupts = <18 IRQ_TYPE_LEVEL_HIGH 7>,
+					     <68 IRQ_TYPE_LEVEL_HIGH 7>,
+					     <69 IRQ_TYPE_LEVEL_HIGH 7>,
+					     <70 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				clocks = <&pioA_clk>;
+			};
 		};
 	};
 };
-- 
2.5.0
