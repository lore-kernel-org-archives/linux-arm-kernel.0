From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Mon, 10 Apr 2017 10:25:16 +0200
Subject: [PATCH 1/2] ARM: dts: at91: sama5d3_xplained: fix ADC vref
Message-ID: <20170410082517.19628-1-ludovic.desroches@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The voltage reference for the ADC is not 3V but 3.3V since it is connected to
VDDANA.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: <stable@vger.kernel.org> # 3.16+
---
 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index c51fc65..7a0fa1a 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -162,6 +162,7 @@
 			};
 
 			adc0: adc at f8018000 {
+				atmel,adc-vref = <3300>;
 				pinctrl-0 = <
 					&pinctrl_adc0_adtrg
 					&pinctrl_adc0_ad0
-- 
2.9.0
