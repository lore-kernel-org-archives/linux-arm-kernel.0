From: aalonso@freescale.com (Adrian Alonso)
Date: Wed, 30 Sep 2015 11:11:04 -0500
Subject: [PATCH v8 2/7] ARM: dts: imx: imx7d-sbd add iomuxc-lpsr hoggrp-2 pads
In-Reply-To: <1443629469-12294-1-git-send-email-aalonso@freescale.com>
References: <1443629469-12294-1-git-send-email-aalonso@freescale.com>
Message-ID: <1443629469-12294-2-git-send-email-aalonso@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add imx7d-sdb iomuxc-lpsr hoggrp-2 default pads settings
Add iomuxc-lpsr usb_otg1_vbus pinctrl settings

Signed-off-by: Adrian Alonso <aalonso@freescale.com>
---
Changes for V2: Resend
Changes for V3: Resend
Changes for V4: Resend
Changes for V5: Resend
Changes for V6:
- Add wdog pinctrl group, add comments for hog2 group gpios
Changes for V7:
- Remove wdog pinctrl settings as they are not currently used
- Add pinctrl_usb_otg1_vbus settings
Changes for V8: Resend

 arch/arm/boot/dts/imx7d-sdb.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 88308f3..ca68a67 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -65,6 +65,8 @@
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
 			gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 =  <&pinctrl_usb_otg1_vbus>;
 			enable-active-high;
 		};
 
@@ -495,3 +497,22 @@
 
 	};
 };
+
+&iomuxc_lpsr {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog_2>;
+
+	imx7d-sdb {
+		pinctrl_hog_2: hog2grp {
+			fsl,pins = <
+				MX7D_PAD_GPIO1_IO07__GPIO1_IO7    0x59  /* sensor_int_b */
+			>;
+		};
+
+		pinctrl_usb_otg1_vbus: usbotg1vbusgrp {
+			fsl,pins = <
+				MX7D_PAD_GPIO1_IO05__GPIO1_IO5    0x14 	/* usb_otg1_pwr */
+			>;
+		};
+	};
+};
-- 
2.1.4
