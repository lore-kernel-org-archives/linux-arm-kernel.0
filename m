From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Fri, 7 Sep 2018 10:18:51 +0200
Subject: [PATCH] ARM: dts: at91: sama5d2_ptc_ek: fix nand pinctrl
Message-ID: <20180907081851.15911-1-ludovic.desroches@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The drive strength has to be set to medium otherwise some data
corruption may happen.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---

Hi,

This fix depends on the support of the drive-strength for the atmel pio4
pinctroller. It has been added in v4.19 but I omitted to send it at the
same time.

Ludovic

 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
index b10dccd0958f..3b1baa8605a7 100644
--- a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
@@ -11,6 +11,7 @@
 #include "sama5d2-pinfunc.h"
 #include <dt-bindings/mfd/atmel-flexcom.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/at91.h>
 
 / {
 	model = "Atmel SAMA5D2 PTC EK";
@@ -299,6 +300,7 @@
 							 <PIN_PA30__NWE_NANDWE>,
 							 <PIN_PB2__NRD_NANDOE>;
 						bias-pull-up;
+						atmel,drive-strength = <ATMEL_PIO_DRVSTR_ME>;
 					};
 
 					ale_cle_rdy_cs {
-- 
2.12.2
