From: tharvey@gateworks.com (Tim Harvey)
Date: Mon,  8 Sep 2014 23:07:31 -0700
Subject: [PATCH 6/6] ARM: dts: imx: ventana: add canbus support for GW52xx
In-Reply-To: <1410242851-30765-1-git-send-email-tharvey@gateworks.com>
References: <1410242851-30765-1-git-send-email-tharvey@gateworks.com>
Message-ID: <1410242851-30765-7-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GW52xx baseboard supports CANbus so we enable it, configure its pinmux
and CAN_STBY gpio.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 6d137b4..d3c0bf5 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -145,6 +145,12 @@
 	status = "okay";
 };
 
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	status = "okay";
+};
+
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
@@ -352,6 +358,14 @@
 			>;
 		};
 
+		pinctrl_flexcan1: flexcan1grp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX	0x1b0b1
+				MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX	0x1b0b1
+				MX6QDL_PAD_GPIO_9__GPIO1_IO09		0x4001b0b0 /* CAN_STBY */
+			>;
+		};
+
 		pinctrl_gpio_leds: gpioledsgrp {
 			fsl,pins = <
 				MX6QDL_PAD_KEY_COL0__GPIO4_IO06  0x1b0b0
-- 
1.8.3.2
