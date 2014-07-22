From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 23 Jul 2014 01:25:29 +0400
Subject: [PATCH v3 1/3] ARM: shmobile: r8a7791: add USB PHY DT support
In-Reply-To: <201407230122.49264.sergei.shtylyov@cogentembedded.com>
References: <201407230122.49264.sergei.shtylyov@cogentembedded.com>
Message-ID: <201407230125.30257.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the R8A7791 generic part of the USB PHY device node. It is up to the
board file to enable the device.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 3:
- changed subnodes of the USB PHY node to be per-channel;
- changed "renesas,phy-select" property to "reg" in the subnodes, and thus added
  "#address-cells" and "#size-cells" properties to the parent node;
- moved "#phy-cells" property from the parent node to the subnodes, changing its
  value to <1>;
- refreshed the patch.

Changes in version 2:
- added subnodes to the USB PHY node;
- refreshed the patch.

 arch/arm/boot/dts/r8a7791.dtsi |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791.dtsi
+++ renesas/arch/arm/boot/dts/r8a7791.dtsi
@@ -550,6 +550,25 @@
 		status = "disabled";
 	};
 
+	usbphy: usb-phy at e6590100 {
+		compatible = "renesas,usb-phy-r8a7791";
+		reg = <0 0xe6590100 0 0x100>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&mstp7_clks R8A7791_CLK_HSUSB>;
+		clock-names = "usbhs";
+		status = "disabled";
+
+		usb0: usb-channel at 0 {
+			reg = <0>;
+			#phy-cells = <1>;
+		};
+		usb2: usb-channel at 2 {
+			reg = <2>;
+			#phy-cells = <1>;
+		};
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
