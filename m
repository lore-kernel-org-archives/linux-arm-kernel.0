From: raveendra.padasalagi@broadcom.com (Raveendra Padasalagi)
Date: Wed,  8 Nov 2017 13:16:43 +0530
Subject: [PATCH v2 3/3] ARM: dts: Add dt node for Broadcom Cygnus USB phy
In-Reply-To: <1510127203-5815-1-git-send-email-raveendra.padasalagi@broadcom.com>
References: <1510127203-5815-1-git-send-email-raveendra.padasalagi@broadcom.com>
Message-ID: <1510127203-5815-4-git-send-email-raveendra.padasalagi@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT node for Broadcom's USB phy controller's used
in Cygnus family of SoC.

Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 7c957ea..c7b39dd 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -96,6 +96,41 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
+		extcon_usb: extcon_usb {
+			compatible = "linux,extcon-usb-gpio";
+			vbus-gpio = <&gpio_asiu 121 0>;
+			id-gpio = <&gpio_asiu 122 0>;
+			status = "okay";
+		};
+
+		usbphy: usb-phy at 0301c028 {
+			compatible = "brcm,cygnus-usb-phy";
+			reg = <0x0301c028 0x4>,
+			      <0x0301d1b4 0x5c>,
+			      <0x18115000 0xa00>,
+			      <0x18111000 0xa00>;
+			reg-names = "crmu-usbphy-aon-ctrl", "cdru-usbphy",
+				    "usb2h-idm", "usb2d-idm";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			usbphy0: usb-phy at 0 {
+				#phy-cells = <1>;
+				reg = <0>;
+			};
+
+			usbphy1: usb-phy at 1 {
+				#phy-cells = <1>;
+				reg = <1>;
+			};
+
+			usbphy2: usb-phy at 2 {
+				#phy-cells = <1>;
+				reg = <2>;
+				extcon = <&extcon_usb>;
+			};
+		};
+
 		otp: otp at 0301c800 {
 			compatible = "brcm,ocotp";
 			reg = <0x0301c800 0x2c>;
-- 
1.9.1
