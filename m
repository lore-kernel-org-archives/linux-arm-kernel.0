From: lisovy@gmail.com (Rostislav Lisovy)
Date: Wed, 27 Nov 2013 00:53:16 +0100
Subject: [PATCH 2/2] ARM: i.MX53: dts: USB host controller
In-Reply-To: <1385509996-17769-1-git-send-email-lisovy@gmail.com>
References: <1385509996-17769-1-git-send-email-lisovy@gmail.com>
Message-ID: <1385509996-17769-3-git-send-email-lisovy@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rostislav Lisovy <lisovy@gmail.com>

diff --git a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
index fa7309f5..04a2895 100644
--- a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
+++ b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
@@ -38,6 +38,16 @@
 			regulator-max-microvolt = <3300000>;
 			regulator-always-on;
 		};
+
+		reg_usb_vbus: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "usb_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio3 31 0>; /* PEN */
+			enable-active-high;
+		};
 	};
 };
 
@@ -222,3 +232,9 @@
 	pinctrl-0 = <&pinctrl_uart1>;
 	status = "okay";
 };
+
+&usbh1 {
+	vbus-supply = <&reg_usb_vbus>;
+	phy_type = "utmi";
+	status = "okay";
+};
-- 
1.8.3.2
