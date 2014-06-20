From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 21 Jun 2014 00:50:07 +0400
Subject: [PATCH v3 2/3] ARM: shmobile: koelsch: enable internal PCI
In-Reply-To: <201406210044.51620.sergei.shtylyov@cogentembedded.com>
References: <201406210044.51620.sergei.shtylyov@cogentembedded.com>
Message-ID: <201406210050.08413.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable internal AHB-PCI bridges for the USB EHCI/OHCI controllers attached to
them.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 3:
- refreshed the patch.

Changes in version 2:
- refreshed the patch.

 arch/arm/boot/dts/r8a7791-koelsch.dts |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-koelsch.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ renesas/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -279,6 +279,16 @@
 		renesas,groups = "i2c6";
 		renesas,function = "i2c6";
 	};
+
+	usb0_pins: usb0 {
+		renesas,groups = "usb0";
+		renesas,function = "usb0";
+	};
+
+	usb1_pins: usb1 {
+		renesas,groups = "usb1";
+		renesas,function = "usb1";
+	};
 };
 
 &ether {
@@ -426,6 +436,18 @@
 	};
 };
 
+&pci0 {
+	status = "okay";
+	pinctrl-0 = <&usb0_pins>;
+	pinctrl-names = "default";
+};
+
+&pci1 {
+	status = "okay";
+	pinctrl-0 = <&usb1_pins>;
+	pinctrl-names = "default";
+};
+
 &pcie_bus_clk {
 	status = "okay";
 };
