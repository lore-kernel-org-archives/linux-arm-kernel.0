From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 29 Sep 2014 22:21:59 +0400
Subject: [PATCH v4] ARM: shmobile: r8a7790: link PCI USB devices to USB PHY
Message-ID: <6141061.UF13qqqgfz@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe the PCI USB devices that are behind the PCI bridges, adding necessary
links to the USB PHY device.

Based on the original work by Ben Dooks <ben.dooks@codethink.co.uk>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against 'renesas-devel-20140924-v3.17-rc6' tag of Simon Horman's
'renesas.git' repo plus R8A7790/Lager USB PHY support patches posted before.
The patch requires the USB PHY driver and USB HCD generic PHY support (merged
by Kishon and Greg recently) in order to work.

Changes in version 4:
- refreshed the patch.

Changes in version 3:
- adjusted "phys" properties in the PCI OHCI/EHCI device nodes;
- resolved rejects.

Changes in version 2:
- renamed the PCI OHCI/EHCI device nodes to comply with the PCI binding;
- changed the PHY specifier in the PCI#2 node to reflect that channel #1 support
  was dropped;
- resolved rejects, refreshed the patch.

 arch/arm/boot/dts/r8a7790.dtsi |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7790.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7790.dtsi
+++ renesas/arch/arm/boot/dts/r8a7790.dtsi
@@ -1107,6 +1107,20 @@
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
 
 	pci1: pci at ee0b0000 {
@@ -1147,6 +1161,20 @@
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
