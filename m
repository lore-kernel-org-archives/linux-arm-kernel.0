From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:14:25 +0200
Subject: [PATCH 003/102] arm64: dts: renesas: r8a77965: add USB 2.0 host nodes
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <1dfa66cd906a06fe05703b32d3fe818710414aaf.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds USB 2.0 host (EHCI/OHCI) nodes for r8a77965.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 38 +++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index abb4d4dcc0ed..ecc34ced3be2 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -640,13 +640,28 @@
 		};
 
 		ohci0: usb at ee080000 {
+			compatible = "generic-ohci";
 			reg = <0 0xee080000 0 0x100>;
-			/* placeholder */
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>;
+			phys = <&usb2_phy0>;
+			phy-names = "usb";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 703>;
+			status = "disabled";
 		};
 
 		ehci0: usb at ee080100 {
+			compatible = "generic-ehci";
 			reg = <0 0xee080100 0 0x100>;
-			/* placeholder */
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>;
+			phys = <&usb2_phy0>;
+			phy-names = "usb";
+			companion = <&ohci0>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 703>;
+			status = "disabled";
 		};
 
 		usb2_phy0: usb-phy at ee080200 {
@@ -673,13 +688,28 @@
 		};
 
 		ohci1: usb at ee0a0000 {
+			compatible = "generic-ohci";
 			reg = <0 0xee0a0000 0 0x100>;
-			/* placeholder */
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 702>;
+			phys = <&usb2_phy1>;
+			phy-names = "usb";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 702>;
+			status = "disabled";
 		};
 
 		ehci1: usb at ee0a0100 {
+			compatible = "generic-ehci";
 			reg = <0 0xee0a0100 0 0x100>;
-			/* placeholder */
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 702>;
+			phys = <&usb2_phy1>;
+			phy-names = "usb";
+			companion = <&ohci1>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 702>;
+			status = "disabled";
 		};
 
 		i2c0: i2c at e6500000 {
-- 
2.11.0
