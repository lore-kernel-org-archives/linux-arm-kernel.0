From: Anson.Huang@nxp.com (Anson Huang)
Date: Sat,  5 May 2018 16:29:22 +0800
Subject: [PATCH V6 6/7] ARM: dts: imx6sx-sabreauto: add debug LED support
In-Reply-To: <1525508963-7986-1-git-send-email-Anson.Huang@nxp.com>
References: <1525508963-7986-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1525508963-7986-6-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a debug LED(D11) connected to GPIO1_IO24,
add support for it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 13de77b..1dc5b58 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -18,6 +18,18 @@
 		reg = <0x80000000 0x80000000>;
 	};
 
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_led>;
+
+		user {
+			label = "debug";
+			gpios = <&gpio1 24 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
 	reg_fec: fec_io_supply {
 		compatible = "regulator-gpio";
 		regulator-name = "1.8V_1.5V_FEC";
@@ -160,6 +172,12 @@
 		>;
 	};
 
+	pinctrl_led: ledgrp {
+		fsl,pins = <
+			MX6SX_PAD_CSI_PIXCLK__GPIO1_IO_24 0x17059
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX6SX_PAD_GPIO1_IO04__UART1_TX		0x1b0b1
-- 
2.7.4
