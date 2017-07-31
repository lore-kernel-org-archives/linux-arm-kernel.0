From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:19:44 +0200
Subject: [PATCH 32/38] ARM: dts: genmai: Add user led device nodes
In-Reply-To: <cover.1501514100.git.horms+renesas@verge.net.au>
References: <cover.1501514100.git.horms+renesas@verge.net.au>
Message-ID: <55ec65552d3b53987853c61bd487de9e239f06a3.1501514100.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

Add device nodes for user leds on Genmai board.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100-genmai.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100-genmai.dts b/arch/arm/boot/dts/r7s72100-genmai.dts
index 0766661d4206..e7824f0857c6 100644
--- a/arch/arm/boot/dts/r7s72100-genmai.dts
+++ b/arch/arm/boot/dts/r7s72100-genmai.dts
@@ -11,6 +11,7 @@
 
 /dts-v1/;
 #include "r7s72100.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/r7s72100-pinctrl.h>
 
 / {
@@ -35,6 +36,19 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 	};
+
+	leds {
+		status = "okay";
+		compatible = "gpio-leds";
+
+		led1 {
+			gpios = <&port4 10 GPIO_ACTIVE_LOW>;
+		};
+
+		led2 {
+			gpios = <&port4 11 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
 
 &pinctrl {
-- 
2.1.4
