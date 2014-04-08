From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 9 Apr 2014 02:17:03 +0400
Subject: [PATCH 1/2] ARM: shmobile: r8a7790: add USB PHY DT support
In-Reply-To: <201404090211.56867.sergei.shtylyov@cogentembedded.com>
References: <201404090211.56867.sergei.shtylyov@cogentembedded.com>
Message-ID: <201404090217.04437.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the R8A7790 generic part of the USB PHY device node. It is up to the
board file to enable the device.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7790.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7790.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7790.dtsi
+++ renesas/arch/arm/boot/dts/r8a7790.dtsi
@@ -412,6 +412,15 @@
 		status = "disabled";
 	};
 
+	usbphy: usb-phy at e6590100 {
+		compatible = "renesas,usb-phy-r8a7790";
+		reg = <0 0xe6590100 0 0x100>;
+		#phy-cells = <2>;
+		clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
+		clock-names = "usbhs";
+		status = "disabled";
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
