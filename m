From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 02 Oct 2015 01:05:12 +0300
Subject: [PATCH v2 1/2] ARM: shmobile: r8a7794: add USB PHY DT support
In-Reply-To: <4938706.NQELE8A71r@wasted.cogentembedded.com>
References: <4938706.NQELE8A71r@wasted.cogentembedded.com>
Message-ID: <4141247.ev8chFQgXD@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the R8A7794 generic part of the USB PHY device node. It is up to the
board file to enable the device.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- added the "power-domains" property.

 arch/arm/boot/dts/r8a7794.dtsi |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
+++ renesas/arch/arm/boot/dts/r8a7794.dtsi
@@ -690,6 +690,26 @@
 				 0x1000 0 0 2 &gic 0 113 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	usbphy: usb-phy at e6590100 {
+		compatible = "renesas,usb-phy-r8a7794";
+		reg = <0 0xe6590100 0 0x100>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&mstp7_clks R8A7794_CLK_HSUSB>;
+		clock-names = "usbhs";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+
+		usb0: usb-channel at 0 {
+			reg = <0>;
+			#phy-cells = <1>;
+		};
+		usb2: usb-channel at 2 {
+			reg = <2>;
+			#phy-cells = <1>;
+		};
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
