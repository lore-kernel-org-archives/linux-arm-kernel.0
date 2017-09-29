From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:53:21 +0200
Subject: [PATCH 29/48] ARM: dts: r8a7743: Add USB PHY DT support
In-Reply-To: <cover.1506683482.git.horms+renesas@verge.net.au>
References: <cover.1506683482.git.horms+renesas@verge.net.au>
Message-ID: <9412c391af67fc8aa4e2d8975ba6143cd5289296.1506683482.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Define the r8a7743 generic part of the USB PHY device node.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7743.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 3f1faad7c24f..a81d70e713ea 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -822,6 +822,28 @@
 			status = "disabled";
 		};
 
+		usbphy: usb-phy at e6590100 {
+			compatible = "renesas,usb-phy-r8a7743",
+				     "renesas,rcar-gen2-usb-phy";
+			reg = <0 0xe6590100 0 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&cpg CPG_MOD 704>;
+			clock-names = "usbhs";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 704>;
+			status = "disabled";
+
+			usb0: usb-channel at 0 {
+				reg = <0>;
+				#phy-cells = <1>;
+			};
+			usb2: usb-channel at 2 {
+				reg = <2>;
+				#phy-cells = <1>;
+			};
+		};
+
 		pci0: pci at ee090000 {
 			compatible = "renesas,pci-r8a7743",
 				     "renesas,pci-rcar-gen2";
-- 
2.1.4
