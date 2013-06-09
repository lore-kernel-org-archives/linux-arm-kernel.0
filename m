From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  9 Jun 2013 18:36:06 +0200
Subject: [PATCH 5/6] ARM: sunxi: Add Olimex A10s-Olinuxino-micro device tree
In-Reply-To: <1370795767-9769-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1370795767-9769-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1370795767-9769-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 75 ++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
new file mode 100644
index 0000000..73ad65e
--- /dev/null
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -0,0 +1,75 @@
+/*
+ * Copyright 2013 Maxime Ripard
+ *
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "sun5i-a10s.dtsi"
+
+/ {
+	model = "Olimex A10s-Olinuxino Micro";
+	compatible = "olimex,a10s-olinuxino-micro", "allwinner,sun5i-a10s";
+
+	soc at 01c20000 {
+		emac: ethernet at 01c0b000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&emac_pins_a>;
+			phy = <&phy1>;
+			status = "okay";
+		};
+
+		mdio at 01c0b080 {
+			status = "okay";
+
+			phy1: ethernet-phy at 1 {
+				reg = <1>;
+			};
+		};
+
+		pinctrl at 01c20800 {
+			led_pins_olinuxino: led_pins at 0 {
+				allwinner,pins = "PE3";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <1>;
+				allwinner,pull = <0>;
+			};
+		};
+
+		uart0: serial at 01c28000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins_a>;
+			status = "okay";
+		};
+
+		uart2: serial at 01c28800 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart2_pins_a>;
+			status = "okay";
+		};
+
+		uart3: serial at 01c28c00 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart3_pins_a>;
+			status = "okay";
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_olinuxino>;
+
+		power {
+			gpios = <&pio 4 3 0>;
+			default-state = "on";
+		};
+	};
+};
-- 
1.8.3
