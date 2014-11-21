From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Nov 2014 09:54:49 +0900
Subject: [PATCH 23/29] ARM: shmobile: r8a7791: add DMA nodes for IIC
In-Reply-To: <cover.1416476366.git.horms+renesas@verge.net.au>
References: <cover.1416476366.git.horms+renesas@verge.net.au>
Message-ID: <3f58c54bd027b42099d59e5ea0521f7b39d82e15.1416476366.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 379e1a5..cfea2eca 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -434,6 +434,8 @@
 		reg = <0 0xe60b0000 0 0x425>;
 		interrupts = <0 173 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_IICDVFS>;
+		dmas = <&dmac0 0x77>, <&dmac0 0x78>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -444,6 +446,8 @@
 		reg = <0 0xe6500000 0 0x425>;
 		interrupts = <0 174 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_IIC0>;
+		dmas = <&dmac0 0x61>, <&dmac0 0x62>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -454,6 +458,8 @@
 		reg = <0 0xe6510000 0 0x425>;
 		interrupts = <0 175 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_IIC1>;
+		dmas = <&dmac0 0x65>, <&dmac0 0x66>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
-- 
2.1.1
