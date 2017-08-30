From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 30 Aug 2017 14:41:10 +0100
Subject: [PATCH  2/5] ARM: dts: r8a7743: Add USB PHY DT support
In-Reply-To: <1504100473-5528-1-git-send-email-biju.das@bp.renesas.com>
References: <1504100473-5528-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1504100473-5528-3-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the r8a7743 generic part of the USB PHY device node.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 3f1faad..a81d70e 100644
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
1.9.1
