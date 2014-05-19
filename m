From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 20 May 2014 01:53:47 +0400
Subject: [PATCH v2 2/3] ARM: shmobile: koelsch: enable internal PCI
In-Reply-To: <201405200148.28683.sergei.shtylyov@cogentembedded.com>
References: <201405200148.28683.sergei.shtylyov@cogentembedded.com>
Message-ID: <201405200153.48335.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable internal AHB-PCI bridges for the USB EHCI/OHCI controllers attached to
them.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- refreshed the patch.

 arch/arm/boot/dts/r8a7791-koelsch.dts |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-koelsch.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ renesas/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -293,6 +293,16 @@
 				 "msiof0_tx";
 		renesas,function = "msiof0";
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
@@ -408,3 +418,15 @@
 		spi-cpha;
 	};
 };
+
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
