From: denis@eukrea.com (Denis Carikli)
Date: Fri,  7 Mar 2014 18:04:17 +0100
Subject: [PATCH 3/9] ARM: dts: mbimxsd51 baseboard: Add USB host support
In-Reply-To: <1394211863-7569-1-git-send-email-denis@eukrea.com>
References: <1394211863-7569-1-git-send-email-denis@eukrea.com>
Message-ID: <1394211863-7569-3-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  |   47 ++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
index 5cec4f3..4d970b3 100644
--- a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
+++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
@@ -151,6 +151,29 @@
 				MX51_PAD_CSI1_D9__GPIO3_13 0x1f5
 			>;
 		};
+
+		pinctrl_usbh1: usbh1grp {
+			fsl,pins = <
+				MX51_PAD_USBH1_CLK__USBH1_CLK     0x1e5
+				MX51_PAD_USBH1_DIR__USBH1_DIR     0x1e5
+				MX51_PAD_USBH1_NXT__USBH1_NXT     0x1e5
+				MX51_PAD_USBH1_DATA0__USBH1_DATA0 0x1e5
+				MX51_PAD_USBH1_DATA1__USBH1_DATA1 0x1e5
+				MX51_PAD_USBH1_DATA2__USBH1_DATA2 0x1e5
+				MX51_PAD_USBH1_DATA3__USBH1_DATA3 0x1e5
+				MX51_PAD_USBH1_DATA4__USBH1_DATA4 0x1e5
+				MX51_PAD_USBH1_DATA5__USBH1_DATA5 0x1e5
+				MX51_PAD_USBH1_DATA6__USBH1_DATA6 0x1e5
+				MX51_PAD_USBH1_DATA7__USBH1_DATA7 0x1e5
+				MX51_PAD_USBH1_STP__USBH1_STP     0x1e5
+			>;
+		};
+
+		pinctrl_usbh1_vbus: usbh1-vbusgrp {
+			fsl,pins = <
+				MX51_PAD_EIM_CS3__GPIO2_28 0x1f5
+			>;
+		};
 	};
 };
 
@@ -173,3 +196,27 @@
 	fsl,uart-has-rtscts;
 	status = "okay";
 };
+
+&usbh1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbh1>;
+	phy_type = "ulpi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbotg {
+	phy_type = "utmi_wide";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbphy0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbh1_vbus>;
+	reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>;
+};
+
+&usbphy1 {
+	clock-frequency = <19200000>;
+};
-- 
1.7.9.5
