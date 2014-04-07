From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 8 Apr 2014 02:40:12 +0400
Subject: [PATCH v2 2/2] ARM: shmobile: lager: enable internal PCI
In-Reply-To: <201404080235.22151.sergei.shtylyov@cogentembedded.com>
References: <201404080235.22151.sergei.shtylyov@cogentembedded.com>
Message-ID: <201404080240.13639.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

Enable internal AHB-PCI bridges for the USB EHCI/OHCI controllers attached to
them.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
[Sergei: enabled PCI0]
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- enabled PCI0 device;
- reworded summary and changelog;
- refreshed the patch.

 arch/arm/boot/dts/r8a7790-lager.dts |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7790-lager.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7790-lager.dts
+++ renesas/arch/arm/boot/dts/r8a7790-lager.dts
@@ -199,6 +199,21 @@
 				 "msiof1_tx";
 		renesas,function = "msiof1";
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
+
+	usb2_pins: usb2 {
+		renesas,groups = "usb2";
+		renesas,function = "usb2";
+	};
 };
 
 &ether {
@@ -297,3 +312,21 @@
 	cd-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
 	status = "okay";
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
+
+&pci2 {
+	status = "okay";
+	pinctrl-0 = <&usb2_pins>;
+	pinctrl-names = "default";
+};
