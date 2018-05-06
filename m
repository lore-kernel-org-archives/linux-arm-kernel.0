From: Anson.Huang@nxp.com (Anson Huang)
Date: Sun,  6 May 2018 14:28:09 +0800
Subject: [PATCH V7 3/7] ARM: dts: imx6sx-sabreauto: add IO expander max7310
 support
In-Reply-To: <1525588093-29994-1-git-send-email-Anson.Huang@nxp.com>
References: <1525588093-29994-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1525588093-29994-3-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6SX Sabre Auto board has two max7310 IO expander on I2C3 bus, add
support for them.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V6:
	remove unnecessary sign-off.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index ae253af..4d41b4d 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -73,6 +73,13 @@
 		>;
 	};
 
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX6SX_PAD_KEY_ROW4__I2C3_SDA            0x4001b8b1
+			MX6SX_PAD_KEY_COL4__I2C3_SCL            0x4001b8b1
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX6SX_PAD_GPIO1_IO04__UART1_TX		0x1b0b1
@@ -262,3 +269,24 @@
 		#gpio-cells = <2>;
 	};
 };
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	max7310_a: gpio at 30 {
+		compatible = "maxim,max7310";
+		reg = <0x30>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	max7310_b: gpio at 32 {
+		compatible = "maxim,max7310";
+		reg = <0x32>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
-- 
2.7.4
