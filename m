From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Aug 2017 10:19:34 +0200
Subject: [PATCH 4/9] arm64: dts: r8a7796: add usb2_phy device nodes
In-Reply-To: <cover.1502961153.git.horms+renesas@verge.net.au>
References: <cover.1502961153.git.horms+renesas@verge.net.au>
Message-ID: <bf68012373546fe4e9078ae294f5886f497fb0e3.1502961153.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index ef1120f4e561..efaf941837ac 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -1240,7 +1240,15 @@
 		};
 
 		usb2_phy0: usb-phy at ee080200 {
-			/* placeholder */
+			compatible = "renesas,usb2-phy-r8a7796",
+				     "renesas,rcar-gen3-usb2-phy";
+			reg = <0 0xee080200 0 0x700>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 703>;
+			#phy-cells = <0>;
+			status = "disabled";
 		};
 
 		ohci1: usb at ee0a0000 {
@@ -1252,7 +1260,14 @@
 		};
 
 		usb2_phy1: usb-phy at ee0a0200 {
-			/* placeholder */
+			compatible = "renesas,usb2-phy-r8a7796",
+				     "renesas,rcar-gen3-usb2-phy";
+			reg = <0 0xee0a0200 0 0x700>;
+			clocks = <&cpg CPG_MOD 702>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 702>;
+			#phy-cells = <0>;
+			status = "disabled";
 		};
 
 		sdhi0: sd at ee100000 {
-- 
2.1.4
