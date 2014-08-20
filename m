From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 20 Aug 2014 09:23:57 +0900
Subject: [PATCH 06/12] ARM: shmobile: r8a7791: Add DMAC devices to DT
In-Reply-To: <cover.1408492753.git.horms+renesas@verge.net.au>
References: <cover.1408492753.git.horms+renesas@verge.net.au>
Message-ID: <fde8feefc489652749920f18123ad9e48b427c5e.1408492753.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Instantiate the two system DMA controllers in the r8a7791 device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 60 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 0f28921..146ed64 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -209,6 +209,66 @@
 			     <0 17 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	dmac0: dma-controller at e6700000 {
+		compatible = "renesas,rcar-dmac";
+		reg = <0 0xe6700000 0 0x20000>;
+		interrupts = <0 197 IRQ_TYPE_LEVEL_HIGH
+			      0 200 IRQ_TYPE_LEVEL_HIGH
+			      0 201 IRQ_TYPE_LEVEL_HIGH
+			      0 202 IRQ_TYPE_LEVEL_HIGH
+			      0 203 IRQ_TYPE_LEVEL_HIGH
+			      0 204 IRQ_TYPE_LEVEL_HIGH
+			      0 205 IRQ_TYPE_LEVEL_HIGH
+			      0 206 IRQ_TYPE_LEVEL_HIGH
+			      0 207 IRQ_TYPE_LEVEL_HIGH
+			      0 208 IRQ_TYPE_LEVEL_HIGH
+			      0 209 IRQ_TYPE_LEVEL_HIGH
+			      0 210 IRQ_TYPE_LEVEL_HIGH
+			      0 211 IRQ_TYPE_LEVEL_HIGH
+			      0 212 IRQ_TYPE_LEVEL_HIGH
+			      0 213 IRQ_TYPE_LEVEL_HIGH
+			      0 214 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "error",
+				"ch0", "ch1", "ch2", "ch3",
+				"ch4", "ch5", "ch6", "ch7",
+				"ch8", "ch9", "ch10", "ch11",
+				"ch12", "ch13", "ch14";
+		clocks = <&mstp2_clks R8A7791_CLK_SYS_DMAC0>;
+		clock-names = "fck";
+		#dma-cells = <1>;
+		dma-channels = <15>;
+	};
+
+	dmac1: dma-controller at e6720000 {
+		compatible = "renesas,rcar-dmac";
+		reg = <0 0xe6720000 0 0x20000>;
+		interrupts = <0 220 IRQ_TYPE_LEVEL_HIGH
+			      0 216 IRQ_TYPE_LEVEL_HIGH
+			      0 217 IRQ_TYPE_LEVEL_HIGH
+			      0 218 IRQ_TYPE_LEVEL_HIGH
+			      0 219 IRQ_TYPE_LEVEL_HIGH
+			      0 308 IRQ_TYPE_LEVEL_HIGH
+			      0 309 IRQ_TYPE_LEVEL_HIGH
+			      0 310 IRQ_TYPE_LEVEL_HIGH
+			      0 311 IRQ_TYPE_LEVEL_HIGH
+			      0 312 IRQ_TYPE_LEVEL_HIGH
+			      0 313 IRQ_TYPE_LEVEL_HIGH
+			      0 314 IRQ_TYPE_LEVEL_HIGH
+			      0 315 IRQ_TYPE_LEVEL_HIGH
+			      0 316 IRQ_TYPE_LEVEL_HIGH
+			      0 317 IRQ_TYPE_LEVEL_HIGH
+			      0 318 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "error",
+				"ch0", "ch1", "ch2", "ch3",
+				"ch4", "ch5", "ch6", "ch7",
+				"ch8", "ch9", "ch10", "ch11",
+				"ch12", "ch13", "ch14";
+		clocks = <&mstp2_clks R8A7791_CLK_SYS_DMAC1>;
+		clock-names = "fck";
+		#dma-cells = <1>;
+		dma-channels = <15>;
+	};
+
 	/* The memory map in the User's Manual maps the cores to bus numbers */
 	i2c0: i2c at e6508000 {
 		#address-cells = <1>;
-- 
2.0.1
