From: Anson.Huang@nxp.com (Anson Huang)
Date: Fri, 13 Jul 2018 15:58:25 +0800
Subject: [PATCH 1/3] ARM: dts: imx6sll-evk: enable PWM1 for backlight driver
Message-ID: <1531468707-25737-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable pwm1 module on i.MX6SLL EVK board to make
backlight driver really work with LCD panel connected.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sll-evk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-evk.dts
index bc8d155..cc5cf5e 100644
--- a/arch/arm/boot/dts/imx6sll-evk.dts
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -213,6 +213,12 @@
 	};
 };
 
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -381,4 +387,10 @@
 			MX6SLL_PAD_I2C1_SDA__I2C1_SDA	 0x4001b8b1
 		>;
 	};
+
+	pinctrl_pwm1: pmw1grp {
+		fsl,pins = <
+			MX6SLL_PAD_PWM1__PWM1_OUT   0x110b0
+		>;
+	};
 };
-- 
2.7.4
