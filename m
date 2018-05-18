From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:14:26 +0200
Subject: [PATCH 004/102] arm64: dts: renesas: r8a77965: add usb_dmac nodes
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <dc68285152674f0178aff7004613a29efae23531.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds USB-DMAC nodes for r8a77965.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index ecc34ced3be2..e5a5dd9d43da 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -832,6 +832,34 @@
 			};
 		};
 
+		usb_dmac0: dma-controller at e65a0000 {
+			compatible = "renesas,r8a77965-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe65a0000 0 0x100>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&cpg CPG_MOD 330>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 330>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
+		};
+
+		usb_dmac1: dma-controller at e65b0000 {
+			compatible = "renesas,r8a77965-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe65b0000 0 0x100>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&cpg CPG_MOD 331>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 331>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
+		};
+
 		hsusb: usb at e6590000 {
 			reg = <0 0xe6590000 0 0x100>;
 			/* placeholder */
-- 
2.11.0
