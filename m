From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Fri, 16 Sep 2016 00:46:54 +0530
Subject: [PATCH v5 5/6] ARM: dts: imx6qdl-icore: Add usbotg support
In-Reply-To: <1473967015-8523-1-git-send-email-jagan@amarulasolutions.com>
References: <1473967015-8523-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <1473967015-8523-6-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add usbotg support for Engicam i.CoreM6 dql modules.

Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v5:
	- none
Changes for v4:
	- new patch

 arch/arm/boot/dts/imx6qdl-icore.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
index fb77a47..a0ca442 100644
--- a/arch/arm/boot/dts/imx6qdl-icore.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore.dtsi
@@ -63,6 +63,15 @@
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	reg_usb_otg_vbus: usb_otg_vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
 };
 
 &can1 {
@@ -122,6 +131,14 @@
 	status = "okay";
 };
 
+&usbotg {
+	vbus-supply = <&reg_usb_otg_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	disable-over-current;
+	status = "okay";
+};
+
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
@@ -196,6 +213,12 @@
 		>;
 	};
 
+	pinctrl_usbotg: usbotggrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x17059
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17070
-- 
2.7.4
