From: anson.huang@nxp.com (Anson Huang)
Date: Thu, 22 Nov 2018 02:55:45 +0000
Subject: [PATCH] ARM: dts: imx6sll-evk: use WDOG_B pin reset
Message-ID: <1542855018-30217-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6SLL EVK board has WDOG_B pin connected to the PMIC;

Add the WDOG_B pinctrl entry and 'fsl,ext-reset-output'
property to wdog node to let watchdog trigger a system
POR reset via the PMIC.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sll-evk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-evk.dts
index 9c90cbd..d8ad2a2 100644
--- a/arch/arm/boot/dts/imx6sll-evk.dts
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -313,6 +313,12 @@
 	status = "okay";
 };
 
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog1>;
+	fsl,ext-reset-output;
+};
+
 &iomuxc {
 	pinctrl_reg_sd3_vmmc: sd3vmmcgrp {
 		fsl,pins = <
@@ -478,4 +484,10 @@
 			MX6SLL_PAD_PWM1__PWM1_OUT   0x110b0
 		>;
 	};
+
+	pinctrl_wdog1: wdog1grp	{
+		fsl,pins = <
+			MX6SLL_PAD_WDOG_B__WDOG1_B   0x170b0
+		>;
+	};
 };
-- 
2.7.4
