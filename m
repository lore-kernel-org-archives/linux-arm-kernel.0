From: jagan@openedev.com (Jagan Teki)
Date: Tue, 14 Mar 2017 15:18:10 +0530
Subject: [PATCH v5 1/8] ARM: dts: imx6qdl-icore: Add backlight support for lvds
In-Reply-To: <1489484897-14933-1-git-send-email-jagan@openedev.com>
References: <1489484897-14933-1-git-send-email-jagan@openedev.com>
Message-ID: <1489484897-14933-2-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

This patch add support for lvds backlight on i.CoreM6 QDL
variant boards.

Cc: Domenico Acri <domenico.acri@engicam.com>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v5:
- %s/arm/ARM/g with subject prefix
- remove status=okay for backlight node
- remove -1 suffix from pwm3grp iomux node
Changes for v4, v3, v2:
- none

 arch/arm/boot/dts/imx6qdl-icore.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
index 55bebfc..56d0c5d 100644
--- a/arch/arm/boot/dts/imx6qdl-icore.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore.dtsi
@@ -48,6 +48,13 @@
 		reg = <0x10000000 0x80000000>;
 	};
 
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm3 0 100000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <7>;
+	};
+
 	reg_3p3v: regulator-3p3v {
 		compatible = "regulator-fixed";
 		regulator-name = "3P3V";
@@ -136,6 +143,12 @@
 	status = "okay";
 };
 
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm3>;
+	status = "okay";
+};
+
 &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart4>;
@@ -246,6 +259,12 @@
 		>;
 	};
 
+	pinctrl_pwm3: pwm3grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_DAT1__PWM3_OUT 0x1b0b1
+		>;
+	};
+
 	pinctrl_usbotg: usbotggrp {
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x17059
-- 
1.9.1
