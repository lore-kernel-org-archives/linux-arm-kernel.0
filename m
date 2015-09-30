From: aalonso@freescale.com (Adrian Alonso)
Date: Wed, 30 Sep 2015 11:11:05 -0500
Subject: [PATCH v8 3/7] ARM: dts: imx: imx7d-sbd add usb_otg2_vbus pinctrl
 settings
In-Reply-To: <1443629469-12294-1-git-send-email-aalonso@freescale.com>
References: <1443629469-12294-1-git-send-email-aalonso@freescale.com>
Message-ID: <1443629469-12294-3-git-send-email-aalonso@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add usb_otg2_vbus pinctrl settings

Signed-off-by: Adrian Alonso <aalonso@freescale.com>
---
Changes for V7: New patch in series
Changes for V8: Rework for latest master

 arch/arm/boot/dts/imx7d-sdb.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index ca68a67..1962cb9 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -77,6 +77,8 @@
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
 			gpio = <&gpio4 7 GPIO_ACTIVE_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 =  <&pinctrl_usb_otg2_vbus>;
 			enable-active-high;
 		};
 
@@ -340,11 +342,16 @@
 
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
-				MX7D_PAD_UART3_CTS_B__GPIO4_IO7		0x14
 				MX7D_PAD_ECSPI2_SS0__GPIO4_IO23		0x34  /* bt reg on */
 			>;
 		};
 
+		pinctrl_usb_otg2_vbus: usbotg2vbusgrp {
+			fsl,pins = <
+				MX7D_PAD_UART3_CTS_B__GPIO4_IO7		0x14 /* usb_otg2_pwr */
+			>;
+		};
+
 		pinctrl_i2c1: i2c1grp {
 			fsl,pins = <
 				MX7D_PAD_I2C1_SDA__I2C1_SDA		0x4000007f
-- 
2.1.4
