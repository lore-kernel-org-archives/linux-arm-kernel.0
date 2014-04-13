From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 13 Apr 2014 09:19:06 +0400
Subject: [PATCH 03/10] ARM: dts: imx51-babbage: Use separate pingroup for
 regulator-fixed
In-Reply-To: <1397366353-29395-1-git-send-email-shc_work@mail.ru>
References: <1397366353-29395-1-git-send-email-shc_work@mail.ru>
Message-ID: <1397366353-29395-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves GPIOs definitions for "regulator-fixed" into a
separate pingroup. Additionally, this patch fixes GPIO active
level definition.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51-babbage.dts | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 651a8c8..3312736 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -141,11 +141,13 @@
 
 		reg_usb_vbus: regulator at 0 {
 			compatible = "regulator-fixed";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usbreg>;
 			reg = <0>;
 			regulator-name = "usb_vbus";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio2 5 0>;
+			gpio = <&gpio2 5 GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 		};
 	};
@@ -536,7 +538,12 @@
 				MX51_PAD_USBH1_DATA5__USBH1_DATA5	0x80000000
 				MX51_PAD_USBH1_DATA6__USBH1_DATA6	0x80000000
 				MX51_PAD_USBH1_DATA7__USBH1_DATA7	0x80000000
-				MX51_PAD_EIM_D21__GPIO2_5		0x80000000
+			>;
+		};
+
+		pinctrl_usbreg: usbreggrp {
+			fsl,pins = <
+				MX51_PAD_EIM_D21__GPIO2_5		0x85
 			>;
 		};
 	};
-- 
1.8.3.2
