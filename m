From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Apr 2014 10:25:52 +0900
Subject: [PATCH 24/33] ARM: shmobile: armadillo-reference dts: enable RTC
In-Reply-To: <cover.1398216022.git.horms+renesas@verge.net.au>
References: <cover.1398216022.git.horms+renesas@verge.net.au>
Message-ID: <584b23db5beb3bd3a3c0767248a4843cac848a58.1398216022.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht@gmail.com>

This enables the Seiko real-time clock that is attached to a couple of
GPIO pins.

Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 97342a4..0cb235a 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -118,6 +118,16 @@
 		};
 	};
 
+	i2c2: i2c at 2 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "i2c-gpio";
+		gpios = <&pfc 208 GPIO_ACTIVE_HIGH /* sda */
+			 &pfc 91 GPIO_ACTIVE_HIGH /* scl */
+			>;
+		i2c-gpio,delay-us = <5>;
+	};
+
 	backlight {
 		compatible = "pwm-backlight";
 		pwms = <&tpu 2 33333 PWM_POLARITY_INVERTED>;
@@ -167,6 +177,14 @@
 	};
 };
 
+&i2c2 {
+	status = "okay";
+	rtc at 30 {
+		compatible = "seiko,s35390a";
+		reg = <0x30>;
+	};
+};
+
 &pfc {
 	pinctrl-0 = <&scifa1_pins>;
 	pinctrl-names = "default";
-- 
1.8.5.2
