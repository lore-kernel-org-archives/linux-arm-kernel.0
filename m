From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:19:49 +0200
Subject: [PATCH 37/38] ARM: dts: rskrza1: Add LED0 pin support
In-Reply-To: <cover.1501514100.git.horms+renesas@verge.net.au>
References: <cover.1501514100.git.horms+renesas@verge.net.au>
Message-ID: <a4604f4d245fe58aac3bc792296ef2e9ec774e12.1501514100.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Brandt <chris.brandt@renesas.com>

Add pin configuration for LED0 which is connected to a GPIO.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100-rskrza1.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100-rskrza1.dts b/arch/arm/boot/dts/r7s72100-rskrza1.dts
index f8285b951140..5dcaaf131d27 100644
--- a/arch/arm/boot/dts/r7s72100-rskrza1.dts
+++ b/arch/arm/boot/dts/r7s72100-rskrza1.dts
@@ -10,6 +10,7 @@
 
 /dts-v1/;
 #include "r7s72100.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/r7s72100-pinctrl.h>
 
 / {
@@ -34,6 +35,15 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 	};
+
+	leds {
+		status = "okay";
+		compatible = "gpio-leds";
+
+		led0 {
+			gpios = <&port7 1 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
 
 &extal_clk {
-- 
2.1.4
