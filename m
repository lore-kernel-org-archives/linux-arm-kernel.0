From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 13 Sep 2015 01:32:12 +0300
Subject: [PATCH 2/2] ARM: shmobile: silk: enable internal PCI
In-Reply-To: <3151312.grtDDBsSl8@wasted.cogentembedded.com>
References: <3151312.grtDDBsSl8@wasted.cogentembedded.com>
Message-ID: <3172073.DtCLeXEVqG@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable internal AHB-PCI bridges for the USB EHCI/OHCI controllers attached to
them.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7794-silk.dts |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7794-silk.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7794-silk.dts
+++ renesas/arch/arm/boot/dts/r8a7794-silk.dts
@@ -80,6 +80,16 @@
 		renesas,groups = "vin0_data8", "vin0_clk";
 		renesas,function = "vin0";
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
 
 &scif2 {
@@ -188,3 +198,15 @@
 		};
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
