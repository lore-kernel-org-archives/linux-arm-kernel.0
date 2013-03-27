From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Wed, 27 Mar 2013 14:41:58 +0100
Subject: [PATCH] ARM: imx: Add support for the Armadeus Systems APF27Dev
 docking board
Message-ID: <1364391718-11322-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The APF27Dev is a docking board for an APF27 SOM

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 arch/arm/boot/dts/Makefile            |  1 +
 arch/arm/boot/dts/imx27-apf27dev.dtsp | 60 +++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx27-apf27dev.dtsp

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 3b9d646..2b4b9fb 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -87,6 +87,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx25-karo-tx25.dtb \
 	imx25-pdk.dtb \
 	imx27-apf27.dtb \
+	imx27-apf27dev.dtb \
 	imx27-pdk.dtb \
 	imx31-bug.dtb \
 	imx51-apf51.dtb \
diff --git a/arch/arm/boot/dts/imx27-apf27dev.dtsp b/arch/arm/boot/dts/imx27-apf27dev.dtsp
new file mode 100644
index 0000000..171e60e
--- /dev/null
+++ b/arch/arm/boot/dts/imx27-apf27dev.dtsp
@@ -0,0 +1,60 @@
+/*
+ * Copyright 2013 Armadeus Systems - <support@armadeus.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/* APF27Dev is a docking board for the APF27 SOM */
+#include "imx27-apf27.dtsp"
+
+/ {
+	model = "Armadeus Systems APF27Dev docking/development board";
+	compatible = "armadeus,imx27-apf27dev", "armadeus,imx27-apf27", "fsl,imx27";
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		user-key {
+			label = "user";
+			gpios = <&gpio6 13 0>;
+			linux,code = <276>; /* BTN_EXTRA */
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		user {
+			label = "Heartbeat";
+			gpios = <&gpio6 14 0>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&cspi1 {
+	fsl,spi-num-chipselects = <1>;
+	cs-gpios = <&gpio4 28 1>;
+	status = "okay";
+};
+
+&cspi2 {
+	fsl,spi-num-chipselects = <3>;
+	cs-gpios = <&gpio4 21 1>, <&gpio4 27 1>,
+			<&gpio2 17 1>;
+	status = "okay";
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
-- 
1.8.1.5
