From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 26 Nov 2018 13:54:35 +0100
Subject: [PATCH 09/40] arm64: dts: renesas: revise hsusb's reg size
In-Reply-To: <cover.1543229515.git.horms+renesas@verge.net.au>
References: <cover.1543229515.git.horms+renesas@verge.net.au>
Message-ID: <e67898dc2d2b4bf484dd8807d62c88480f6290fb.1543229515.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch revises the reg size of each hsusb device node for
r8a7795, r8a7796 and r8a77965.

Reported-by: Biju Das <biju.das@bp.renesas.com>
Fixes: d2422e108812 ("arm64: dts: r8a7795: Add HSUSB device node")
Fixes: 4725f2b88057 ("arm64: dts: renesas: r8a7795: add hsusb ch3 device node")
Fixes: b9535853777f ("arm64: dts: r8a7796: Add HSUSB device node")
Fixes: 9e1b00a2ef43 ("arm64: dts: renesas: r8a77965: Add "reg" properties")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 4 ++--
 arch/arm64/boot/dts/renesas/r8a7796.dtsi  | 2 +-
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 95a8ed40e7d3..27faaccd0cae 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -695,7 +695,7 @@
 		hsusb: usb at e6590000 {
 			compatible = "renesas,usbhs-r8a7795",
 				     "renesas,rcar-gen3-usbhs";
-			reg = <0 0xe6590000 0 0x100>;
+			reg = <0 0xe6590000 0 0x200>;
 			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 704>, <&cpg CPG_MOD 703>;
 			dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
@@ -712,7 +712,7 @@
 		hsusb3: usb at e659c000 {
 			compatible = "renesas,usbhs-r8a7795",
 				     "renesas,rcar-gen3-usbhs";
-			reg = <0 0xe659c000 0 0x100>;
+			reg = <0 0xe659c000 0 0x200>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 705>, <&cpg CPG_MOD 700>;
 			dmas = <&usb_dmac2 0>, <&usb_dmac2 1>,
diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 1ec6aaa520c1..3baee26ae372 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -674,7 +674,7 @@
 		hsusb: usb at e6590000 {
 			compatible = "renesas,usbhs-r8a7796",
 				     "renesas,rcar-gen3-usbhs";
-			reg = <0 0xe6590000 0 0x100>;
+			reg = <0 0xe6590000 0 0x200>;
 			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 704>, <&cpg CPG_MOD 703>;
 			dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index b984b85dc066..4ac2abeda48c 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -590,7 +590,7 @@
 		hsusb: usb at e6590000 {
 			compatible = "renesas,usbhs-r8a77965",
 				     "renesas,rcar-gen3-usbhs";
-			reg = <0 0xe6590000 0 0x100>;
+			reg = <0 0xe6590000 0 0x200>;
 			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 704>, <&cpg CPG_MOD 703>;
 			dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
-- 
2.11.0
