From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 12 Jan 2015 11:57:56 +0100
Subject: [PATCH v3 3/5] ARM: at91/dt: update udc compatible strings
In-Reply-To: <1421060278-27329-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1421060278-27329-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1421060278-27329-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

at91sam9g45, at91sam9x5 and sama5 SoCs should not use
"atmel,at91sam9rl-udc" for their USB device compatible property since
this compatible is attached to a specific hardware bug fix.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9g45.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi  | 2 +-
 arch/arm/boot/dts/sama5d3.dtsi     | 2 +-
 arch/arm/boot/dts/sama5d4.dtsi     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 2a8da8a..acd90eb 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -1144,7 +1144,7 @@
 			usb2: gadget at fff78000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-				compatible = "atmel,at91sam9rl-udc";
+				compatible = "atmel,at91sam9g45-udc";
 				reg = <0x00600000 0x80000
 				       0xfff78000 0x400>;
 				interrupts = <27 IRQ_TYPE_LEVEL_HIGH 0>;
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index bbb3ba6..d213147 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -1057,7 +1057,7 @@
 			usb2: gadget at f803c000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-				compatible = "atmel,at91sam9rl-udc";
+				compatible = "atmel,at91sam9g45-udc";
 				reg = <0x00500000 0x80000
 				       0xf803c000 0x400>;
 				interrupts = <23 IRQ_TYPE_LEVEL_HIGH 0>;
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 5f4144d..2b407a4 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -1264,7 +1264,7 @@
 		usb0: gadget at 00500000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "atmel,at91sam9rl-udc";
+			compatible = "atmel,sama5d3-udc";
 			reg = <0x00500000 0x100000
 			       0xf8030000 0x4000>;
 			interrupts = <33 IRQ_TYPE_LEVEL_HIGH 2>;
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 1b0f30c..52dce24 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -112,7 +112,7 @@
 		usb0: gadget at 00400000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "atmel,at91sam9rl-udc";
+			compatible = "atmel,sama5d3-udc";
 			reg = <0x00400000 0x100000
 			       0xfc02c000 0x4000>;
 			interrupts = <47 IRQ_TYPE_LEVEL_HIGH 2>;
-- 
1.9.1
