From: hdegoede@redhat.com (Hans de Goede)
Date: Sat,  1 Mar 2014 20:26:29 +0100
Subject: [PATCH 10/19] ARM: sun4i: dt: Add USB host nodes to mini-xplus dts
In-Reply-To: <1393701998-3553-1-git-send-email-hdegoede@redhat.com>
References: <1393701998-3553-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1393701998-3553-11-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for the usb-phy and ehci- and ohci-usb-host controllers.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts | 31 ++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
index 70b3323..dd84a9e 100644
--- a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
+++ b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
@@ -13,16 +13,47 @@
 
 /dts-v1/;
 /include/ "sun4i-a10.dtsi"
+/include/ "sunxi-common-regulators.dtsi"
 
 / {
 	model = "PineRiver Mini X-Plus";
 	compatible = "pineriver,mini-xplus", "allwinner,sun4i-a10";
 
 	soc at 01c00000 {
+		usbphy: phy at 01c13400 {
+			usb1_vbus-supply = <&reg_usb1_vbus>;
+			usb2_vbus-supply = <&reg_usb2_vbus>;
+			status = "okay";
+		};
+
+		ehci0: usb at 01c14000 {
+			status = "okay";
+		};
+
+		ohci0: usb at 01c14400 {
+			status = "okay";
+		};
+
+		ehci1: usb at 01c1c000 {
+			status = "okay";
+		};
+
+		ohci1: usb at 01c1c400 {
+			status = "okay";
+		};
+
 		uart0: serial at 01c28000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart0_pins_a>;
 			status = "okay";
 		};
 	};
+
+	reg_usb1_vbus: usb1-vbus {
+		status = "okay";
+	};
+
+	reg_usb2_vbus: usb2-vbus {
+		status = "okay";
+	};
 };
-- 
1.9.0
