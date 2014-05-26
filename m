From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 27 May 2014 02:18:28 +0400
Subject: [PATCH v2] ARM: shmobile: r8a7791: link PCI USB devices to USB PHY
Message-ID: <201405270218.30040.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe the PCI USB devices that are behind the PCI bridges, adding necessary
links to the USB PHY device.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against 'renesas-devel-v3.15-rc7-20140526' tag of Simon Horman's
'renesas.git' repo plus R8A7791/Koelsch/Henninger PCI and USB PHY support
patches posted before.  The patch requires the internal PCI DT support, USB PHY
driver, and USB HCD generic PHY support (also already posted) in order to work.

Changes in version 2:
- renamed the PCI OHCI/EHCI device nodes to comply with the PCI binding;
- changed the PHY specifier in the PCI#1 node to reflect that channel #1 support
  was dropped;
- resolved rejects.

 arch/arm/boot/dts/r8a7791.dtsi |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791.dtsi
+++ renesas/arch/arm/boot/dts/r8a7791.dtsi
@@ -923,6 +923,20 @@
 		interrupt-map = <0x0000 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
 			      	 0x0800 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
 			      	 0x1000 0 0 2 &gic 0 108 IRQ_TYPE_LEVEL_HIGH>;
+
+		usb at 0,1 {
+			reg = <0x800 0 0 0 0>;
+			device_type = "pci";
+			phys = <&usbphy 0 0>;
+			phy-names = "usb";
+		};
+
+		usb at 0,2 {
+			reg = <0x1000 0 0 0 0>;
+			device_type = "pci";
+			phys = <&usbphy 0 0>;
+			phy-names = "usb";
+		};
 	};
 
 	pci1: pci at ee0d0000 {
@@ -941,5 +955,19 @@
 		interrupt-map = <0x0000 0 0 1 &gic 0 113 IRQ_TYPE_LEVEL_HIGH
 			      	 0x0800 0 0 1 &gic 0 113 IRQ_TYPE_LEVEL_HIGH
 			      	 0x1000 0 0 2 &gic 0 113 IRQ_TYPE_LEVEL_HIGH>;
+
+		usb at 0,1 {
+			reg = <0x800 0 0 0 0>;
+			device_type = "pci";
+			phys = <&usbphy 1 0>;
+			phy-names = "usb";
+		};
+
+		usb at 0,2 {
+			reg = <0x1000 0 0 0 0>;
+			device_type = "pci";
+			phys = <&usbphy 1 0>;
+			phy-names = "usb";
+		};
 	};
 };
