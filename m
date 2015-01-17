From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 17 Jan 2015 09:58:41 +0900
Subject: [PATCH 08/11] ARM: shmobile: r8a73a4 dtsi: Add memory-controller nodes
In-Reply-To: <cover.1421380713.git.horms+renesas@verge.net.au>
References: <cover.1421380713.git.horms+renesas@verge.net.au>
Message-ID: <35dd549cb300e346e2f2ec1f12dd9cd245b3276b.1421380713.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add device nodes for the two DDR Bus State Controllers (DBSC).
The DBSCs are located in the A3BC PM domain, which must not be powered
down, else the system will crash.

A reference to the A3BC PM domain will be added later.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 5ac57ba..38136d9 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -38,6 +38,16 @@
 			     <1 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
+	dbsc1: memory-controller at e6790000 {
+		compatible = "renesas,dbsc-r8a73a4";
+		reg = <0 0xe6790000 0 0x10000>;
+	};
+
+	dbsc2: memory-controller at e67a0000 {
+		compatible = "renesas,dbsc-r8a73a4";
+		reg = <0 0xe67a0000 0 0x10000>;
+	};
+
 	dmac: dma-multiplexer {
 		compatible = "renesas,shdma-mux";
 		#dma-cells = <1>;
-- 
2.1.4
