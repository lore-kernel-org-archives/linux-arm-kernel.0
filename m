From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  3 Feb 2013 12:18:31 +0100
Subject: [PATCH 3/3] sunxi: a13-olinuxino: Add user LED to the device tree
In-Reply-To: <1359890311-10110-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1359889813-10029-1-git-send-email-maxime.ripard@free-electrons.com>
 <1359890311-10110-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1359890311-10110-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index 4a1e45d..33d1c7e 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -23,10 +23,30 @@
 	};
 
 	soc {
+		pinctrl at 01c20800 {
+			led_pins_olinuxino: led_pins at 0 {
+				allwinner,pins = "PG9";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <1>;
+				allwinner,pull = <0>;
+			};
+		};
+
 		uart1: uart at 01c28400 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart1_pins_b>;
 			status = "okay";
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_olinuxino>;
+
+		power {
+			gpios = <&pio 6 9 0>;
+			default-state = "on";
+		};
+	};
 };
-- 
1.7.10.4
