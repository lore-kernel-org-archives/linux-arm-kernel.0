From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 23 Jul 2014 02:25:25 +0400
Subject: [PATCH v3] ARM: shmobile: r8a7791: link PCI USB devices to USB PHY
Message-ID: <201407230225.26798.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe the PCI USB devices that are behind the PCI bridges, adding necessary
links to the USB PHY device.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against 'renesas-devel-v3.16-rc5-20140722' tag of Simon Horman's
'renesas.git' repo plus R8A7791/Koelsch/Henninger USB PHY support patches posted
before.  The patch requires the USB PHY driver, and USB HCD generic PHY support
(also already posted) in order to work.

Changes in version 3:
- adjusted "phys" properties in the PCI OHCI/EHCI device nodes;
- resolved rejects.

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
@@ -1030,6 +1030,20 @@
 		interrupt-map = <0x0000 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
 				 0x0800 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
 				 0x1000 0 0 2 &gic 0 108 IRQ_TYPE_LEVEL_HIGH>;
+
+		usb at 0,1 {
+			reg = <0x800 0 0 0 0>;
+			device_type = "pci";
+			phys = <&usb0 0>;
+			phy-names = "usb";
+		};
+
+		usb at 0,2 {
+			reg = <0x1000 0 0 0 0>;
+			device_type = "pci";
+			phys = <&usb0 0>;
+			phy-names = "usb";
+		};
 	};
 
 	pci1: pci at ee0d0000 {
@@ -1050,6 +1064,20 @@
 		interrupt-map = <0x0000 0 0 1 &gic 0 113 IRQ_TYPE_LEVEL_HIGH
 				 0x0800 0 0 1 &gic 0 113 IRQ_TYPE_LEVEL_HIGH
 				 0x1000 0 0 2 &gic 0 113 IRQ_TYPE_LEVEL_HIGH>;
+
+		usb at 0,1 {
+			reg = <0x800 0 0 0 0>;
+			device_type = "pci";
+			phys = <&usb2 0>;
+			phy-names = "usb";
+		};
+
+		usb at 0,2 {
+			reg = <0x1000 0 0 0 0>;
+			device_type = "pci";
+			phys = <&usb2 0>;
+			phy-names = "usb";
+		};
 	};
 
 	pciec: pcie at fe000000 {
