From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Thu, 18 Jan 2018 15:38:47 +0100
Subject: [PATCH] ARM: dts: at91: sama5d4: fix pinctrl compatible string
Message-ID: <20180118143847.15309-1-ludovic.desroches@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Santiago Esteban <Santiago.Esteban@microchip.com>

The compatible string is incorrect. Add atmel,sama5d3-pinctrl since
it's the appropriate compatible string. Remove the
atmel,at91rm9200-pinctrl compatible string, this fallback is
useless, there are too many changes.

Signed-off-by: Santiago Esteban <Santiago.Esteban@microchip.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: stable at vger.kernel.org #v3.18
---
 arch/arm/boot/dts/sama5d4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 373b3621b536..c7105096c623 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -1379,7 +1379,7 @@
 			pinctrl at fc06a000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "atmel,at91sam9x5-pinctrl", "atmel,at91rm9200-pinctrl", "simple-bus";
+				compatible = "atmel,sama5d3-pinctrl", "atmel,at91sam9x5-pinctrl", "simple-bus";
 				ranges = <0xfc068000 0xfc068000 0x100
 					  0xfc06a000 0xfc06a000 0x4000>;
 				/* WARNING: revisit as pin spec has changed */
-- 
2.12.2
