From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 9 Aug 2013 08:23:44 +0800
Subject: [PATCH 1/1] ARM: dtsi: imx6qdl-sabresd: Add USB host 1 VBUS regulator
Message-ID: <1376007824-16325-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We enabled USB host 1, so host 1's vbus should be on to let
host 1 work.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 6e5dfdb..6e9d4d7 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -27,6 +27,15 @@
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
@@ -125,6 +134,7 @@
 };
 
 &usbh1 {
+	vbus-supply = <&reg_usb_h1_vbus>;
 	status = "okay";
 };
 
-- 
1.7.1
