From: alex.gonzalez@digi.com (Alex Gonzalez)
Date: Thu, 25 Oct 2018 17:09:31 +0200
Subject: [PATCH v1 2/4] ARM: dts: ccimx6ulsbcpro: Enable AUO G101EVN010 lcdif
 panel
In-Reply-To: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com>
References: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com>
Message-ID: <1540480173-12009-3-git-send-email-alex.gonzalez@digi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change adds support for the AUO G101EVN010 lcdif panel for the
mxsfb DRM driver.

Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
---
 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
index 11966d12af76..f6e6b2cf780b 100644
--- a/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
+++ b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
@@ -24,6 +24,18 @@
 		status = "okay";
 	};
 
+	panel {
+		compatible = "auo,g101evn010", "simple-panel";
+		power-supply = <&ldo4_ext>;
+		backlight = <&lcd_backlight>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&display_out>;
+			};
+		};
+	};
+
 	reg_usb_otg1_vbus: regulator-usb-otg1 {
 		compatible = "regulator-fixed";
 		regulator-name = "usb_otg1_vbus";
@@ -112,6 +124,12 @@
 		     &pinctrl_lcdif_hvsync>;
 	lcd-supply = <&ldo4_ext>;       /* BU90T82 LVDS bridge power */
 	status = "okay";
+
+	port {
+		display_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
 };
 
 &ldo4_ext {
