From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 9 Apr 2014 23:18:25 +0400
Subject: [PATCH] ARM: shmobile: r8a7790: link PCI USb devices to USB PHY
Message-ID: <201404092318.26231.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe the PCI USB devices that are behind the PCI bridges, adding necessary
links to the USB PHY device.

Based on the original work by Ben Dooks <ben.dooks@codethink.co.uk>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against 'renesas-devel-v3.14-20140408' tag of Simon Horman's
'renesas.git' repo plus R8A7790/Lager PCI and USB PHY support patches posted
yesterday and day before. The patch requires the internal PCI and USB PHY
drivers (also already posted) in order to work...

 arch/arm/boot/dts/r8a7790.dtsi |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7790.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7790.dtsi
+++ renesas/arch/arm/boot/dts/r8a7790.dtsi
@@ -841,6 +841,20 @@
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
 
 	pci1: pci at ee0b0000 {
@@ -867,5 +881,19 @@
 		bus-range = <2 2>;
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
