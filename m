From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Jun 2013 10:45:57 +0200
Subject: [PATCHv2] ARM: sunxi: Add Olimex A10s-Olinuxino-micro device tree
Message-ID: <1371458757-6343-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Tested-by: Emilio L?pez <emilio@elopez.com.ar>
---
 arch/arm/boot/dts/Makefile                       |  1 +
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 76 ++++++++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f0895c5..bae46c3 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -181,6 +181,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += \
 	sun4i-a10-cubieboard.dtb \
 	sun4i-a10-mini-xplus.dtb \
 	sun4i-a10-hackberry.dtb \
+	sun5i-a10s-olinuxino-micro.dtb \
 	sun5i-a13-olinuxino.dtb
 dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
 	tegra20-iris-512.dtb \
diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
new file mode 100644
index 0000000..64dc0c4
--- /dev/null
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -0,0 +1,76 @@
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
+		green {
+			label = "a10s-olinuxino-micro:green:usr";
+			gpios = <&pio 4 3 0>;
+			default-state = "on";
+		};
+	};
+};
-- 
1.8.3.1
