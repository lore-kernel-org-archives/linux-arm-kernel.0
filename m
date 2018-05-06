From: Anson.Huang@nxp.com (Anson Huang)
Date: Sun,  6 May 2018 14:28:13 +0800
Subject: [PATCH V7 7/7] ARM: dts: imx6sx-sabreauto: add egalax touch screen
 support
In-Reply-To: <1525588093-29994-1-git-send-email-Anson.Huang@nxp.com>
References: <1525588093-29994-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1525588093-29994-7-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add egalax touch screen support on i2c2 bus.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V6:
	remove unnecessary sign-off, improve node name and add PAD setting value.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 8e6bd9d..bfbcf70 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -111,6 +111,12 @@
 };
 
 &iomuxc {
+	pinctrl_egalax_int: egalax-intgrp {
+		fsl,pins = <
+			MX6SX_PAD_SD4_RESET_B__GPIO6_IO_22      0x10b0
+		>;
+	};
+
 	pinctrl_enet1: enet1grp {
 		fsl,pins = <
 			MX6SX_PAD_ENET1_MDIO__ENET1_MDIO        0xa0b1
@@ -253,6 +259,16 @@
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
 
+	touchscreen at 4 {
+		compatible = "eeti,egalax_ts";
+		reg = <0x04>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_egalax_int>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <22 IRQ_TYPE_EDGE_FALLING>;
+		wakeup-gpios = <&gpio6 22 GPIO_ACTIVE_HIGH>;
+	};
+
 	pfuze100: pmic at 8 {
 		compatible = "fsl,pfuze100";
 		reg = <0x08>;
-- 
2.7.4
