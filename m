From: petr@barix.com (Petr Kulhavy)
Date: Tue,  5 Apr 2016 11:31:37 +0200
Subject: [PATCH] ARM: DTS: da850: fixed missing #gpio-cells in gpio node
Message-ID: <1459848697-21006-1-git-send-email-petr@barix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpio node was missing the mandatory property #gpio-cells, which was
causing runtime errors when using GPIOs e.g. with gpio-leds or gpio-keys:

"could not get #gpio-cells for /soc/gpio at 1e26000"

This fixes the problem and adds the missing parameter.
The value is 2 according to the gpio-davinci.txt binding.

Signed-off-by: Petr Kulhavy <petr@barix.com>
---
 arch/arm/boot/dts/da850.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 226cda76e77c..b0e3a4c833c3 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -312,6 +312,7 @@
 		gpio: gpio at 1e26000 {
 			compatible = "ti,dm6441-gpio";
 			gpio-controller;
+			#gpio-cells = <2>;
 			reg = <0x226000 0x1000>;
 			interrupts = <42 IRQ_TYPE_EDGE_BOTH
 				43 IRQ_TYPE_EDGE_BOTH 44 IRQ_TYPE_EDGE_BOTH
-- 
1.9.1
