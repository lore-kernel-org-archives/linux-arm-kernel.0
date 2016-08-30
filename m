From: vanessa.maegima@nxp.com (Vanessa Maegima)
Date: Tue, 30 Aug 2016 17:23:03 -0300
Subject: [PATCH v2 2/3] ARM: dts: imx7s-warp: Add User Button support
In-Reply-To: <1472588584-686-1-git-send-email-vanessa.maegima@nxp.com>
References: <1472588584-686-1-git-send-email-vanessa.maegima@nxp.com>
Message-ID: <1472588584-686-2-git-send-email-vanessa.maegima@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add User Button at GPIO7_1.

Tested by evtest.

Signed-off-by: Vanessa Maegima <vanessa.maegima@nxp.com>
---
Changes since v1:
- Add line between property list and sub-node
- Use 'wakeup-source' property
- Remove 'autorepeat' property from child node

 arch/arm/boot/dts/imx7s-warp.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index 71dbece..b3c75c1 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -54,6 +54,19 @@
 		reg = <0x80000000 0x20000000>;
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&pinctrl_gpio>;
+		autorepeat;
+
+		back {
+			label = "Back";
+			gpios = <&gpio7 1 GPIO_ACTIVE_HIGH>;
+			linux,code = <KEY_BACK>;
+			wakeup-source;
+		};
+	};
+
 	reg_brcm: regulator-brcm {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -278,6 +291,12 @@
 		>;
 	};
 
+	pinctrl_gpio: gpiogrp {
+		fsl,pins = <
+			MX7D_PAD_ENET1_RGMII_RD1__GPIO7_IO1	0x14
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX7D_PAD_I2C1_SDA__I2C1_SDA		0x4000007f
-- 
2.7.4
