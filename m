From: Anson.Huang@nxp.com (Anson Huang)
Date: Fri, 16 Mar 2018 16:54:31 +0800
Subject: [PATCH] ARM: dts: imx7d-sdb: add gpio key support
Message-ID: <1521190471-25242-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for imx7d-sdb board's gpio keys:

S1(FUNC1): KEY_VOLUMEUP
S3(FUNC2): KEY_VOLUMEDOWN

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 7f241af..e47b5b2 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -52,6 +52,24 @@
 		reg = <0x80000000 0x80000000>;
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		volume-up {
+			label = "Volume Up";
+			gpios = <&gpio5 11 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+
+		volume-down {
+			label = "Volume Down";
+			gpios = <&gpio5 10 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+	};
+
 	spi4 {
 		compatible = "spi-gpio";
 		pinctrl-names = "default";
@@ -519,6 +537,12 @@
 			>;
 		};
 
+		pinctrl_gpio_keys: gpio_keysgrp {
+			fsl,pins = <
+				MX7D_PAD_SD2_RESET_B__GPIO5_IO11	0x59
+				MX7D_PAD_SD2_WP__GPIO5_IO10		0x59
+			>;
+		};
 
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
-- 
2.7.4
