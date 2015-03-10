From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 10 Mar 2015 09:44:39 +0900
Subject: [PATCH 02/15] ARM: shmobile: r8a7791: Reference DMA channels in SDHI
 DT nodes
In-Reply-To: <cover.1425947992.git.horms+renesas@verge.net.au>
References: <cover.1425947992.git.horms+renesas@verge.net.au>
Message-ID: <ae67fa2f8b29aa0bb443ee213991f4b712d58faa.1425947992.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add references to the transmit and receive DMA channels in the three
SDHI nodes.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 1e593a2..32f0506 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -485,6 +485,8 @@
 		reg = <0 0xee100000 0 0x200>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_SDHI0>;
+		dmas = <&dmac1 0xcd>, <&dmac1 0xce>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -493,6 +495,8 @@
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_SDHI1>;
+		dmas = <&dmac1 0xc1>, <&dmac1 0xc2>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -501,6 +505,8 @@
 		reg = <0 0xee160000 0 0x100>;
 		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_SDHI2>;
+		dmas = <&dmac1 0xd3>, <&dmac1 0xd4>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
-- 
2.1.4
