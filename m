From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 9 Apr 2014 23:19:30 +0400
Subject: [PATCH] ARM: shmobile: r8a7791: link PCI USb devices to USB PHY
Message-ID: <201404092319.31646.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe the PCI USB devices that are behind the PCI bridges, adding necessary
links to the USB PHY device.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against 'renesas-devel-v3.14-20140408' tag of Simon Horman's
'renesas.git' repo plus R8A7791/Koelsch PCI and USB PHY support patches posted
yesterday and day before. The patch requires the internal PCI and USB PHY
drivers (also already posted) in order to work...

 arch/arm/boot/dts/r8a7791.dtsi |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791.dtsi
+++ renesas/arch/arm/boot/dts/r8a7791.dtsi
@@ -891,6 +891,20 @@
 		bus-range = <0 0>;
 		#address-cells = <3>;
 		#size-cells = <2>;
+
+		pci at 0,1 {
+			reg = <0x800 0 0 0 0>;
+			device_type = "pci";
+			phys = <&usbphy 0 0>;
+			phy-names = "usb";
+		};
+
+		pci at 0,2 {
+			reg = <0x1000 0 0 0 0>;
+			device_type = "pci";
+			phys = <&usbphy 0 0>;
+			phy-names = "usb";
+		};
 	};
 
 	pci1: pci at ee0d0000 {
@@ -904,5 +918,19 @@
 		bus-range = <1 1>;
 		#address-cells = <3>;
 		#size-cells = <2>;
+
+		pci at 0,1 {
+			reg = <0x800 0 0 0 0>;
+			device_type = "pci";
+			phys = <&usbphy 2 0>;
+			phy-names = "usb";
+		};
+
+		pci at 0,2 {
+			reg = <0x1000 0 0 0 0>;
+			device_type = "pci";
+			phys = <&usbphy 2 0>;
+			phy-names = "usb";
+		};
 	};
 };
