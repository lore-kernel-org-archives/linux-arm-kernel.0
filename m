From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 29 Sep 2014 22:23:11 +0400
Subject: [PATCH v4] ARM: shmobile: r8a7791: link PCI USB devices to USB PHY
Message-ID: <5270578.Srkf5AOOOJ@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe the PCI USB devices that are behind the PCI bridges, adding necessary
links to the USB PHY device.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against 'renesas-devel-20140924-v3.17-rc6' tag of Simon Horman's
'renesas.git' repo plus R8A7791/Koelsch/Henninger USB PHY support patches posted
before.  The patch requires the USB PHY driver and USB HCD generic PHY support
(merged by Kishon and Greg recently) in order to work.

Changes in version 4:
- refreshed the patch.

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
@@ -1125,6 +1125,20 @@
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
@@ -1145,6 +1159,20 @@
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
