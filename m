From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:14:27 +0200
Subject: [PATCH 005/102] arm64: dts: renesas: r8a77965: add HS-USB node
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <a06e8af801760a98fd1d1355cafa92f89c78c771.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds HS-USB node for r8a77965.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index e5a5dd9d43da..ac74413d006f 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -861,8 +861,20 @@
 		};
 
 		hsusb: usb at e6590000 {
+			compatible = "renesas,usbhs-r8a7796",
+				     "renesas,rcar-gen3-usbhs";
 			reg = <0 0xe6590000 0 0x100>;
-			/* placeholder */
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 704>;
+			dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
+			       <&usb_dmac1 0>, <&usb_dmac1 1>;
+			dma-names = "ch0", "ch1", "ch2", "ch3";
+			renesas,buswait = <11>;
+			phys = <&usb2_phy0>;
+			phy-names = "usb";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 704>;
+			status = "disabled";
 		};
 
 		pciec0: pcie at fe000000 {
-- 
2.11.0
