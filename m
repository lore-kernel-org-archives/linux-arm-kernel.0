From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 24 May 2014 02:36:36 +0400
Subject: [PATCH v2 1/3] ARM: shmobile: r8a7791: add USB PHY DT support
In-Reply-To: <201405240234.47303.sergei.shtylyov@cogentembedded.com>
References: <201405240234.47303.sergei.shtylyov@cogentembedded.com>
Message-ID: <201405240236.37742.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the R8A7791 generic part of the USB PHY device node. It is up to the
board file to enable the device.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- added subnodes to the USB PHY node;
- refreshed the patch.

 arch/arm/boot/dts/r8a7791.dtsi |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791.dtsi
+++ renesas/arch/arm/boot/dts/r8a7791.dtsi
@@ -507,6 +507,32 @@
 		status = "disabled";
 	};
 
+	usbphy: usb-phy at e6590100 {
+		compatible = "renesas,usb-phy-r8a7791";
+		reg = <0 0xe6590100 0 0x100>;
+		#phy-cells = <2>;
+		clocks = <&mstp7_clks R8A7791_CLK_HSUSB>;
+		clock-names = "usbhs";
+		status = "disabled";
+
+		usb-phy at 0,0 {
+			renesas,phy-select = <0 0>;
+			renesas,ugctrl2-masks = <0x00000030 0x00000010>;
+		};
+		usb-phy at 0,1 {
+			renesas,phy-select = <0 1>;
+			renesas,ugctrl2-masks = <0x00000030 0x00000030>;
+		};
+		usb-phy at 1,0 {
+			renesas,phy-select = <1 0>;
+			renesas,ugctrl2-masks = <0x80000000 0x00000000>;
+		};
+		usb-phy at 1,1 {
+			renesas,phy-select = <1 1>;
+			renesas,ugctrl2-masks = <0x80000000 0x80000000>;
+		};
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
