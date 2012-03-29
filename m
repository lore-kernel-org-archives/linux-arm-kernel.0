From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 29 Mar 2012 15:27:15 +0200
Subject: [PATCH 04/12] ARM: at91/dts: USB host vbus is active low
In-Reply-To: <cover.1333026637.git.nicolas.ferre@atmel.com>
References: <cover.1333026637.git.nicolas.ferre@atmel.com>
Message-ID: <44829c6b9071853311b87eaf3b8952fd6c5b8d82.1333026637.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change vbus gpio configuration in .dts files to switch to
active low configuration.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: stable <stable@vger.kernel.org>
---
 arch/arm/boot/dts/at91sam9g25ek.dts    |    4 ++--
 arch/arm/boot/dts/at91sam9m10g45ek.dts |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9g25ek.dts
index ac0dc00..7829a4d 100644
--- a/arch/arm/boot/dts/at91sam9g25ek.dts
+++ b/arch/arm/boot/dts/at91sam9g25ek.dts
@@ -37,8 +37,8 @@
 		usb0: ohci at 00600000 {
 			status = "okay";
 			num-ports = <2>;
-			atmel,vbus-gpio = <&pioD 19 0
-					   &pioD 20 0
+			atmel,vbus-gpio = <&pioD 19 1
+					   &pioD 20 1
 					  >;
 		};
 
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index c4c8ae4..6abb571 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -73,8 +73,8 @@
 		usb0: ohci at 00700000 {
 			status = "okay";
 			num-ports = <2>;
-			atmel,vbus-gpio = <&pioD 1 0
-					   &pioD 3 0>;
+			atmel,vbus-gpio = <&pioD 1 1
+					   &pioD 3 1>;
 		};
 
 		usb1: ehci at 00800000 {
-- 
1.7.9.4
