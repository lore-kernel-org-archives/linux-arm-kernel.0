From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Aug 2017 10:19:35 +0200
Subject: [PATCH 5/9] arm64: dts: r8a7796: add USB2.0 Host (EHCI/OHCI) device
 nodes
In-Reply-To: <cover.1502961153.git.horms+renesas@verge.net.au>
References: <cover.1502961153.git.horms+renesas@verge.net.au>
Message-ID: <3e95050a3d334c816152e32a500674d97690307d.1502961153.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 42 +++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index efaf941837ac..5301bfce15d5 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -1232,11 +1232,28 @@
 		};
 
 		ohci0: usb at ee080000 {
-			/* placeholder */
+			compatible = "generic-ohci";
+			reg = <0 0xee080000 0 0x100>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>;
+			phys = <&usb2_phy0>;
+			phy-names = "usb";
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 703>;
+			status = "disabled";
 		};
 
 		ehci0: usb at ee080100 {
-			/* placeholder */
+			compatible = "generic-ehci";
+			reg = <0 0xee080100 0 0x100>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>;
+			phys = <&usb2_phy0>;
+			phy-names = "usb";
+			companion= <&ohci0>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 703>;
+			status = "disabled";
 		};
 
 		usb2_phy0: usb-phy at ee080200 {
@@ -1252,11 +1269,28 @@
 		};
 
 		ohci1: usb at ee0a0000 {
-			/* placeholder */
+			compatible = "generic-ohci";
+			reg = <0 0xee0a0000 0 0x100>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 702>;
+			phys = <&usb2_phy1>;
+			phy-names = "usb";
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 702>;
+			status = "disabled";
 		};
 
 		ehci1: usb at ee0a0100 {
-			/* placeholder */
+			compatible = "generic-ehci";
+			reg = <0 0xee0a0100 0 0x100>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 702>;
+			phys = <&usb2_phy1>;
+			phy-names = "usb";
+			companion= <&ohci1>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 702>;
+			status = "disabled";
 		};
 
 		usb2_phy1: usb-phy at ee0a0200 {
-- 
2.1.4
