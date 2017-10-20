From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:28:45 +0200
Subject: [PATCH 18/42] ARM: dts: r8a7743: Enable DMA for HSUSB
In-Reply-To: <cover.1508493785.git.horms+renesas@verge.net.au>
References: <cover.1508493785.git.horms+renesas@verge.net.au>
Message-ID: <e0a10e7b070624965f20205c59fb2a0c0b465782.1508493785.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

This patch adds DMA properties to the HSUSB node.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7743.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index de89295ce63a..699c04003eac 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -979,6 +979,9 @@
 			reg = <0 0xe6590000 0 0x100>;
 			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 704>;
+			dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
+			       <&usb_dmac1 0>, <&usb_dmac1 1>;
+			dma-names = "ch0", "ch1", "ch2", "ch3";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
 			resets = <&cpg 704>;
 			renesas,buswait = <4>;
-- 
2.11.0
