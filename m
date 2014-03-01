From: hdegoede@redhat.com (Hans de Goede)
Date: Sat,  1 Mar 2014 20:26:38 +0100
Subject: [PATCH 19/19] ARM: sun4i: dt: Add support for the INet-97F_Rev_02
 board
In-Reply-To: <1393701998-3553-1-git-send-email-hdegoede@redhat.com>
References: <1393701998-3553-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1393701998-3553-20-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Lanzend??rfer <david.lanzendoerfer@o2s.ch>

This patch adds basic support for the INet-97F_Rev_02 board found in various
low cost consumer tablet devices (http://linux-sunxi.org/INet-97F_Rev_02)

Signed-off-by: David Lanzend??rfer <david.lanzendoerfer@o2s.ch>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/Makefile                |  1 +
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts | 69 +++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 66d6df3..aaa130e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -284,6 +284,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += \
 	sun4i-a10-cubieboard.dtb \
 	sun4i-a10-mini-xplus.dtb \
 	sun4i-a10-hackberry.dtb \
+	sun4i-a10-inet97fv2.dtb \
 	sun4i-a10-olinuxino-lime.dtb \
 	sun4i-a10-pcduino.dtb \
 	sun5i-a10s-olinuxino-micro.dtb \
diff --git a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
new file mode 100644
index 0000000..fe9272e
--- /dev/null
+++ b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
@@ -0,0 +1,69 @@
+/*
+ * Copyright 2014 Open Source Support GmbH
+ *
+ * David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "sun4i-a10.dtsi"
+/include/ "sunxi-common-regulators.dtsi"
+
+/ {
+	model = "INet-97F Rev 02";
+	compatible = "primux,inet97fv2", "allwinner,sun4i-a10";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	soc at 01c00000 {
+		uart0: serial at 01c28000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins_a>;
+			status = "okay";
+		};
+
+		i2c0: i2c at 01c2ac00 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins_a>;
+			status = "okay";
+		};
+
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
+	};
+
+	reg_usb1_vbus: usb1-vbus {
+		status = "okay";
+	};
+
+	reg_usb2_vbus: usb2-vbus {
+		status = "okay";
+	};
+};
-- 
1.9.0
