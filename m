From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Oct 2013 15:50:14 +0900
Subject: [PATCH 04/13] ARM: shmobile: armadillo-reference: Add PWM backlight
 node to DT
In-Reply-To: <cover.1381298964.git.horms+renesas@verge.net.au>
References: <cover.1381298964.git.horms+renesas@verge.net.au>
Message-ID: <87b73d88723601636646a69445f89c0e498fff71.1381298964.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../boot/dts/r8a7740-armadillo800eva-reference.dts    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 9fcffc1..8b2aab5 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -11,6 +11,7 @@
 /dts-v1/;
 /include/ "r8a7740.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "armadillo 800 eva reference";
@@ -49,6 +50,15 @@
 			gpios = <&pfc 177 GPIO_ACTIVE_HIGH>;
 		};
 	};
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&tpu 2 33333 PWM_POLARITY_INVERTED>;
+		brightness-levels = <0 1 2 4 8 16 32 64 128 255>;
+		default-brightness-level = <9>;
+		pinctrl-0 = <&backlight_pins>;
+		pinctrl-names = "default";
+	};
 };
 
 &i2c0 {
@@ -77,4 +87,13 @@
 		renesas,groups = "intc_irq10";
 		renesas,function = "intc";
 	};
+
+	backlight_pins: backlight {
+		renesas,groups = "tpu0_to2_1";
+		renesas,function = "tpu0";
+	};
+};
+
+&tpu {
+	status = "okay";
 };
-- 
1.8.4
