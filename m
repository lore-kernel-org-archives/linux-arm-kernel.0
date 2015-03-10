From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 10 Mar 2015 09:44:38 +0900
Subject: [PATCH 01/15] ARM: shmobile: r8a7790: Reference DMA channels in SDHI
 DT nodes
In-Reply-To: <cover.1425947992.git.horms+renesas@verge.net.au>
References: <cover.1425947992.git.horms+renesas@verge.net.au>
Message-ID: <941fe36b4071ddfd6c793bfaeed1d051175d4d80.1425947992.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add references to the transmit and receive DMA channels in the four
SDHI nodes.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index c6c0a0c..5ce3564 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -496,6 +496,8 @@
 		reg = <0 0xee100000 0 0x200>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
+		dmas = <&dmac1 0xcd>, <&dmac1 0xce>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -504,6 +506,8 @@
 		reg = <0 0xee120000 0 0x200>;
 		interrupts = <0 166 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI1>;
+		dmas = <&dmac1 0xc9>, <&dmac1 0xca>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -512,6 +516,8 @@
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI2>;
+		dmas = <&dmac1 0xc1>, <&dmac1 0xc2>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -520,6 +526,8 @@
 		reg = <0 0xee160000 0 0x100>;
 		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI3>;
+		dmas = <&dmac1 0xd3>, <&dmac1 0xd4>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
-- 
2.1.4
