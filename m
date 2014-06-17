From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Jun 2014 22:52:57 +0800
Subject: [PATCH v2 20/20] ARM: sun8i: dt: Add Ippo-q8h v5 support
In-Reply-To: <1403016777-15121-1-git-send-email-wens@csie.org>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
Message-ID: <1403016777-15121-21-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Ippo-q8h is a tablet circiut board commonly found in cheap Android
tablets with A23 SoCs. There are at least 2 versions of the board, with
different peripherals, such as WiFi chips.

This patch add supports for v5 of such boards, which has a ESP8089 WiFi
chip (not supported) connected to mmc1.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/Makefile                  |  2 +
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts | 57 +++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5986ff6..774a14b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -380,6 +380,8 @@ dtb-$(CONFIG_MACH_SUN7I) += \
 	sun7i-a20-cubietruck.dtb \
 	sun7i-a20-i12-tvbox.dtb \
 	sun7i-a20-olinuxino-micro.dtb
+dtb-$(CONFIG_MACH_SUN8I) += \
+	sun8i-a23-ippo-q8h-v5.dtb
 dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
 	tegra20-iris-512.dtb \
 	tegra20-medcom-wide.dtb \
diff --git a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
new file mode 100644
index 0000000..c1236bd
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
@@ -0,0 +1,57 @@
+/*
+ * Copyright 2014 Chen-Yu Tsai
+ *
+ * Chen-Yu Tsai <wens@csie.org>
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
+/include/ "sun8i-a23.dtsi"
+
+/ {
+	model = "Ippo Q8H Dual Core Tablet (v5)";
+	compatible = "ippo,q8h-v5", "allwinner,sun8i-a23";
+
+	chosen {
+		bootargs = "earlyprintk console=ttyS0,115200";
+	};
+
+	soc at 01c00000 {
+		uart0: serial at 01c28000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins_a>;
+			status = "okay";
+		};
+
+		i2c0: i2c at 01c2ac00 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins_a>;
+			status = "okay";
+		};
+
+		i2c1: i2c at 01c2b000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_pins_a>;
+			status = "okay";
+		};
+
+		i2c2: i2c at 01c2b400 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c2_pins_a>;
+			status = "okay";
+		};
+
+		r_uart: serial at 01f02800 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&r_uart_pins_a>;
+			status = "okay";
+		};
+	};
+};
+
-- 
2.0.0
