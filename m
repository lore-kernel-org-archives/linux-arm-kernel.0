From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Oct 2015 10:58:03 +0900
Subject: [PATCH 26/28] ARM: shmobile: r8a7794: add HS-USB DT support
In-Reply-To: <cover.1444182812.git.horms+renesas@verge.net.au>
References: <cover.1444182812.git.horms+renesas@verge.net.au>
Message-ID: <2f33b9f796ce6ebb00f6e8238fba07149c5264f2.1444182812.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the R8A7794 generic part of the HS-USB device node.
It is up to the board file to enable the device.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index efc3548511c4..a9977d6ee81a 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
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
-- 
2.1.4
