From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 13 Oct 2015 01:12:18 +0300
Subject: [PATCH] ARM: shmobile: porter: enable internal PCI and USB PHY
In-Reply-To: <3151312.grtDDBsSl8@wasted.cogentembedded.com>
References: <3151312.grtDDBsSl8@wasted.cogentembedded.com>
Message-ID: <4574604.BmF3DtBjpm@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable  internal AHB-PCI bridges for the USB EHCI/OHCI controllers attached
to them and also enable  USB PHY device  for the Porter board.  We have to
enable  everything in one patch since EHCI/OHCI devices are already linked
to the USB PHY device.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against 'renesas-devel-20151012-v4.3-rc5' tag of Simon Horman's
'renesas.git' repo.

 arch/arm/boot/dts/r8a7791-porter.dts |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-porter.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791-porter.dts
+++ renesas/arch/arm/boot/dts/r8a7791-porter.dts
@@ -120,6 +120,16 @@
 		renesas,function = "i2c2";
 	};
 
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
 	vin0_pins: vin0 {
 		renesas,groups = "vin0_data8", "vin0_clk";
 		renesas,function = "vin0";
@@ -245,6 +255,24 @@
 	};
 };
 
+&pci0 {
+	pinctrl-0 = <&usb0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pci1 {
+	pinctrl-0 = <&usb1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&usbphy {
+	status = "okay";
+};
+
 &pcie_bus_clk {
 	status = "okay";
 };
