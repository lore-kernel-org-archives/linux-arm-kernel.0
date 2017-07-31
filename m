From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:03:22 +0200
Subject: [PATCH 30/31] arm64: dts: renesas: r8a7795: add usb-dmac ch2 and ch3
 device nodes
In-Reply-To: <cover.1501509525.git.horms+renesas@verge.net.au>
References: <cover.1501509525.git.horms+renesas@verge.net.au>
Message-ID: <62f40bcfa9a8a360637577fb528872ebcb0937c1.1501509526.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds support for usb-dmac ch2 and ch3 device nodes for
R-Car H3 ES2.0.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi |  3 +++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi     | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
index 1eccc7c795df..9743acad9b9c 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
@@ -25,6 +25,9 @@
 	/delete-node/ usb at ee0e0100;
 	/delete-node/ usb at ee0e0000;
 
+	/delete-node/ dma-controller at e6460000;
+	/delete-node/ dma-controller at e6470000;
+
 	fcpf2: fcp at fe952000 {
 		compatible = "renesas,fcpf";
 		reg = <0 0xfe952000 0 0x200>;
diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index cf9ed0d0a1fb..f9735a3a736e 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -1498,6 +1498,34 @@
 			dma-channels = <2>;
 		};
 
+		usb_dmac2: dma-controller at e6460000 {
+			compatible = "renesas,r8a7795-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe6460000 0 0x100>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&cpg CPG_MOD 326>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 326>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
+		};
+
+		usb_dmac3: dma-controller at e6470000 {
+			compatible = "renesas,r8a7795-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe6470000 0 0x100>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&cpg CPG_MOD 329>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 329>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
+		};
+
 		sdhi0: sd at ee100000 {
 			compatible = "renesas,sdhi-r8a7795";
 			reg = <0 0xee100000 0 0x2000>;
-- 
2.1.4
