From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 17 Jun 2015 10:59:05 +0200
Subject: [RESEND PATCH 2/2] ARM: at91/dt: update udc compatible strings
In-Reply-To: <99dc2e0ec98342632b6e3adad3861f4dd0fcde41.1434530650.git.nicolas.ferre@atmel.com>
References: <99dc2e0ec98342632b6e3adad3861f4dd0fcde41.1434530650.git.nicolas.ferre@atmel.com>
Message-ID: <8ec182ab7c5186a64d605d0e174e750994586f02.1434530650.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris Brezillon <boris.brezillon@free-electrons.com>

at91sam9g45, at91sam9x5 and sama5 SoCs should not use
"atmel,at91sam9rl-udc" for their USB device compatible property since
this compatible is attached to a specific hardware bug fix.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Tested-by: Bo Shen <voice.shen@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: <stable@vger.kernel.org>  #4.0+
---
Hi,

This patch was forgotten while dealing with the series "usb: atmel_usba_udc:
Rework errata handling". This patch and the previous one should be added to
mainline as fixes, the soonest. In fact, the errata handling is now broken
because of this desynchronization.

We'll try to queue it during 4.2-rc phase for inclusion in arm-soc tree.

Bye,

 arch/arm/boot/dts/at91sam9g45.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi  | 2 +-
 arch/arm/boot/dts/sama5d3.dtsi     | 2 +-
 arch/arm/boot/dts/sama5d4.dtsi     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index d260ba779ae5..18177f5a7464 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -1148,7 +1148,7 @@
 			usb2: gadget at fff78000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-				compatible = "atmel,at91sam9rl-udc";
+				compatible = "atmel,at91sam9g45-udc";
 				reg = <0x00600000 0x80000
 				       0xfff78000 0x400>;
 				interrupts = <27 IRQ_TYPE_LEVEL_HIGH 0>;
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 7521bdf17ef2..b6c8df8d380e 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -1108,7 +1108,7 @@
 			usb2: gadget at f803c000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-				compatible = "atmel,at91sam9rl-udc";
+				compatible = "atmel,at91sam9g45-udc";
 				reg = <0x00500000 0x80000
 				       0xf803c000 0x400>;
 				interrupts = <23 IRQ_TYPE_LEVEL_HIGH 0>;
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 5ab7548e04e1..9e2444b07bce 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -1321,7 +1321,7 @@
 		usb0: gadget at 00500000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "atmel,at91sam9rl-udc";
+			compatible = "atmel,sama5d3-udc";
 			reg = <0x00500000 0x100000
 			       0xf8030000 0x4000>;
 			interrupts = <33 IRQ_TYPE_LEVEL_HIGH 2>;
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 653a1f851f2b..3ee22ee13c5a 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -127,7 +127,7 @@
 		usb0: gadget at 00400000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "atmel,at91sam9rl-udc";
+			compatible = "atmel,sama5d3-udc";
 			reg = <0x00400000 0x100000
 			       0xfc02c000 0x4000>;
 			interrupts = <47 IRQ_TYPE_LEVEL_HIGH 2>;
-- 
2.1.3
