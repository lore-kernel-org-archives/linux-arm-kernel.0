From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 3 Jul 2013 13:00:50 +0200
Subject: [PATCH] ARM: at91/DT: at91sam9x5ek: fix USB host property to enable
 port C
Message-ID: <1372849250-14715-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device Tree "num-ports" property of USB host node has to be
set to maximum number of ports available.
The possibility to activate a particular port is done by specifying the proper
gpio configuration for its vbus.

This patch fixes the USB host node by configuring the 3 ports available on the
product and letting "port A" available for USB gadget usage.

Reported-by: Rodolfo Giometti <giometti@enneenne.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Bo Shen <voice.shen@atmel.com>
---
 arch/arm/boot/dts/at91sam9x5ek.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
index b753855..49e3c45 100644
--- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
@@ -94,8 +94,9 @@
 
 		usb0: ohci at 00600000 {
 			status = "okay";
-			num-ports = <2>;
-			atmel,vbus-gpio = <&pioD 19 GPIO_ACTIVE_LOW
+			num-ports = <3>;
+			atmel,vbus-gpio = <0 /* &pioD 18 GPIO_ACTIVE_LOW *//* Activate to have access to port A */
+					   &pioD 19 GPIO_ACTIVE_LOW
 					   &pioD 20 GPIO_ACTIVE_LOW
 					  >;
 		};
-- 
1.8.2.2
