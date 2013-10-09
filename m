From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Oct 2013 15:50:13 +0900
Subject: [PATCH 03/13] ARM: shmobile: r8a73a4: add a DT node for the DMAC
In-Reply-To: <cover.1381298964.git.horms+renesas@verge.net.au>
References: <cover.1381298964.git.horms+renesas@verge.net.au>
Message-ID: <734e2ce38c6aa3e88f0a339f001d272196f26dfa.1381298964.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Add a DT node for the only system DMAC instance on r8a73a4. The RT DMAC
can be added later under the same multiplexer, because they can serve the
same slaves and use the same MID-RID values. Configuration data is
supplied to the driver, using a compatibility match string.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 43 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index a2c9456..8c81a0c 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -78,6 +78,49 @@
 				<0 56 4>, <0 57 4>;
 	};
 
+	dmac: dma-multiplexer at 0 {
+		compatible = "renesas,shdma-mux";
+		#dma-cells = <1>;
+		dma-channels = <20>;
+		dma-requests = <256>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		dma0: dma-controller at e6700020 {
+			compatible = "renesas,shdma-r8a73a4";
+			reg = <0 0xe6700020 0 0x89e0>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 220 4
+					0 200 4
+					0 201 4
+					0 202 4
+					0 203 4
+					0 204 4
+					0 205 4
+					0 206 4
+					0 207 4
+					0 208 4
+					0 209 4
+					0 210 4
+					0 211 4
+					0 212 4
+					0 213 4
+					0 214 4
+					0 215 4
+					0 216 4
+					0 217 4
+					0 218 4
+					0 219 4>;
+			interrupt-names = "error",
+					"ch0", "ch1", "ch2", "ch3",
+					"ch4", "ch5", "ch6", "ch7",
+					"ch8", "ch9", "ch10", "ch11",
+					"ch12", "ch13", "ch14", "ch15",
+					"ch16", "ch17", "ch18", "ch19";
+		};
+	};
+
 	thermal at e61f0000 {
 		compatible = "renesas,rcar-thermal";
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>,
-- 
1.8.4
