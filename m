From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 12 Aug 2013 12:14:26 +0800
Subject: [PATCH 1/2] ARM: dtsi: imx6qdl-sabresd: Add USB host 1 VBUS regulator
Message-ID: <1376280867-3259-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We enabled USB host 1, so host 1's vbus should be on to let
host 1 work.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi |   25 ++++++++++++++++++-------
 1 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 61b8959..b4db3f7 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -34,6 +34,15 @@
 			enable-active-high;
 		};
 
+		reg_usb_h1_vbus: usb_h1_vbus {
+			compatible = "regulator-fixed";
+			regulator-name = "usb_h1_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio1 29 0>;
+			enable-active-high;
+		};
+
 		reg_audio: wm8962_supply {
 			compatible = "regulator-fixed";
 			regulator-name = "wm8962-supply";
@@ -188,13 +197,14 @@
 	hog {
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_4__GPIO1_IO04   0x80000000
-				MX6QDL_PAD_GPIO_5__GPIO1_IO05   0x80000000
-				MX6QDL_PAD_NANDF_D0__GPIO2_IO00 0x80000000
-				MX6QDL_PAD_NANDF_D1__GPIO2_IO01 0x80000000
-				MX6QDL_PAD_NANDF_D2__GPIO2_IO02 0x80000000
-				MX6QDL_PAD_NANDF_D3__GPIO2_IO03 0x80000000
-				MX6QDL_PAD_GPIO_0__CCM_CLKO1    0x130b0
+				MX6QDL_PAD_GPIO_4__GPIO1_IO04   	0x80000000
+				MX6QDL_PAD_GPIO_5__GPIO1_IO05   	0x80000000
+				MX6QDL_PAD_NANDF_D0__GPIO2_IO00 	0x80000000
+				MX6QDL_PAD_NANDF_D1__GPIO2_IO01 	0x80000000
+				MX6QDL_PAD_NANDF_D2__GPIO2_IO02 	0x80000000
+				MX6QDL_PAD_NANDF_D3__GPIO2_IO03 	0x80000000
+				MX6QDL_PAD_GPIO_0__CCM_CLKO1    	0x130b0
+				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29	0x80000000
 			>;
 		};
 	};
@@ -228,6 +238,7 @@
 };
 
 &usbh1 {
+	vbus-supply = <&reg_usb_h1_vbus>;
 	status = "okay";
 };
 
-- 
1.7.1
