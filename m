From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 12 Mar 2014 10:19:25 -0300
Subject: [PATCH v2 2/2] ARM: dts: imx25-pdk: Add CAN support
In-Reply-To: <1394630365-27250-1-git-send-email-fabio.estevam@freescale.com>
References: <1394630365-27250-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1394630365-27250-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Put the transceiver enable GPIO into the cangrp and also select it as GPIO

 arch/arm/boot/dts/imx25-pdk.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index 9507365..cccd8fe 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -52,6 +52,14 @@
 			regulator-max-microvolt = <3300000>;
 		};
 
+		reg_can_3v3: regulator at 3 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+			regulator-name = "can-3v3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio4 6 0>;
+		};
 	};
 
 	sound {
@@ -75,6 +83,13 @@
 	status = "okay";
 };
 
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can1>;
+	xceiver-supply = <&reg_can_3v3>;
+	status = "okay";
+};
+
 &esdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
@@ -118,6 +133,14 @@
 			>;
 		};
 
+		pinctrl_can1: can1grp {
+			fsl,pins = <
+				MX25_PAD_GPIO_A__CAN1_TX		0x0
+				MX25_PAD_GPIO_B__CAN1_RX		0x0
+				MX25_PAD_D14__GPIO_4_6 			0x80000000
+			>;
+		};
+
 		pinctrl_esdhc1: esdhc1grp {
 			fsl,pins = <
 				MX25_PAD_SD1_CMD__SD1_CMD		0x80000000
-- 
1.8.1.2
