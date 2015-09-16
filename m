From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 17 Sep 2015 02:53:58 +0300
Subject: [PATCH] ARM: shmobile: r8a7794: add HS-USB DT support
In-Reply-To: <1674850.BZpGW9kEud@wasted.cogentembedded.com>
References: <1674850.BZpGW9kEud@wasted.cogentembedded.com>
Message-ID: <49756124.B9jeO4ArbL@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the R8A7794 generic part of the HS-USB device node.
It is up to the board file to enable the device.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against  'renesas-devel-20150914-v4.3-rc1' tag  of Simon Horman's
'renesas.git' repo plus the R8A7794/ PCI USB and USB PHY support patches posted
last week.

 arch/arm/boot/dts/r8a7794.dtsi |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
+++ renesas/arch/arm/boot/dts/r8a7794.dtsi
@@ -718,6 +718,18 @@
 		};
 	};
 
+	hsusb: usb at e6590000 {
+		compatible = "renesas,usbhs-r8a7794";
+		reg = <0 0xe6590000 0 0x100>;
+		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7794_CLK_HSUSB>;
+		power-domains = <&cpg_clocks>;
+		renesas,buswait = <4>;
+		phys = <&usb0 1>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
 	usbphy: usb-phy at e6590100 {
 		compatible = "renesas,usb-phy-r8a7794";
 		reg = <0 0xe6590100 0 0x100>;
