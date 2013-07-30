From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Jul 2013 16:59:54 +0200
Subject: [PATCH 10/10] ARM: sun7i: a20-olinuxino: Enable the user LED
In-Reply-To: <1375196394-21138-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1375196394-21138-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1375196394-21138-11-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A20-olinuxino Micro has a LED connected to the PH2 pin. Use the
gpio-led driver to enable the control over this LED.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 96e8c56..70affa7 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -19,6 +19,15 @@
 	compatible = "olimex,a20-olinuxino-micro", "allwinner,sun7i-a20";
 
 	soc at 01c20000 {
+		pinctrl at 01c20800 {
+			led_pins_olinuxino: led_pins at 0 {
+				allwinner,pins = "PH2";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <1>;
+				allwinner,pull = <0>;
+			};
+		};
+
 		uart0: serial at 01c28000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart0_pins_a>;
@@ -37,4 +46,16 @@
 			status = "okay";
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_olinuxino>;
+
+		green {
+			label = "a20s-olinuxino-micro:green:usr";
+			gpios = <&pio 7 2 0>;
+			default-state = "on";
+		};
+	};
 };
-- 
1.8.3.4
