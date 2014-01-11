From: wigyori@uid0.hu (Zoltan HERPAI)
Date: Sat, 11 Jan 2014 16:54:52 +0100 (CET)
Subject: [PATCH] ARM: sun4i: dt: Add basic board support for LinkSprite pcDuino
Message-ID: <alpine.DEB.2.02.1401111509430.13932@trabant.deployis.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch will add a basic board support DT for the
LinkSprite pcDuino.

Signed-off-by: Zoltan HERPAI <wigyori@uid0.hu>
---
  arch/arm/boot/dts/Makefile              |    1 +
  arch/arm/boot/dts/sun4i-a10-pcduino.dts |   48 +++++++++++++++++++++++++++++++
  2 files changed, 49 insertions(+), 0 deletions(-)
  create mode 100644 arch/arm/boot/dts/sun4i-a10-pcduino.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b663ed7..a2e3620 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -253,6 +253,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += \
  	sun4i-a10-cubieboard.dtb \
  	sun4i-a10-mini-xplus.dtb \
  	sun4i-a10-hackberry.dtb \
+	sun4i-a10-pcduino.dtb \
  	sun5i-a10s-olinuxino-micro.dtb \
  	sun5i-a13-olinuxino.dtb \
  	sun5i-a13-olinuxino-micro.dtb \
diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino.dts b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
new file mode 100644
index 0000000..752f002
--- /dev/null
+++ b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
@@ -0,0 +1,48 @@
+/*
+ * Copyright 2014 Zoltan HERPAI
+ * Zoltan HERPAI <wigyori@uid0.hu>
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
+/include/ "sun4i-a10.dtsi"
+
+/ {
+	model = "LinkSprite pcDuino";
+	compatible = "pcduino,a10-pcduino", "allwinner,sun4i-a10";
+
+	soc at 01c00000 {
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
+	};
+};
-- 
1.7.0.4
