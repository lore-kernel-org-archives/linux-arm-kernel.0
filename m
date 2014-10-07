From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 08 Oct 2014 00:23:16 +0400
Subject: [PATCH v3 1/2] ARM: shmobile: r8a7790: add HS-USB device node
In-Reply-To: <2438577.UAUDMkTTWI@wasted.cogentembedded.com>
References: <2438577.UAUDMkTTWI@wasted.cogentembedded.com>
Message-ID: <2254854.tSoZel4tS4@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Define the R8A7790 generic part of the HS-USB device node. It is up to the board
file to enable the device.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
[Sergei: fixed summary, added changelog]
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 3:
- uppercased "arm" in the summary;
- added changelog.

 arch/arm/boot/dts/r8a7790.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7790.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7790.dtsi
+++ renesas/arch/arm/boot/dts/r8a7790.dtsi
@@ -600,6 +600,17 @@
 		status = "disabled";
 	};
 
+	hsusb: usb at e6590000 {
+		compatible = "renesas,usbhs-r8a7790";
+		reg = <0 0xe6590000 0 0x100>;
+		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
+		renesas,buswait = <4>;
+		phys = <&usb0 1>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
 	usbphy: usb-phy at e6590100 {
 		compatible = "renesas,usb-phy-r8a7790";
 		reg = <0 0xe6590100 0 0x100>;
