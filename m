From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  4 Nov 2016 10:44:01 +0100
Subject: [PATCH 06/12] arm64: dts: r8a7796: add SDHI nodes
In-Reply-To: <cover.1478251192.git.horms+renesas@verge.net.au>
References: <cover.1478251192.git.horms+renesas@verge.net.au>
Message-ID: <a513cf1e645785cd119676aea4aa00c4e1e0c7b3.1478251192.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SDHI nodes to the DT of the r8a7796 SoC.

Based on the DT of the r8a7795 SoC.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 40 ++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 9217da983525..6ec988c78ff8 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -251,5 +251,45 @@
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
+
+		sdhi0: sd at ee100000 {
+			compatible = "renesas,sdhi-r8a7796";
+			reg = <0 0xee100000 0 0x2000>;
+			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 314>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		sdhi1: sd at ee120000 {
+			compatible = "renesas,sdhi-r8a7796";
+			reg = <0 0xee120000 0 0x2000>;
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 313>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		sdhi2: sd at ee140000 {
+			compatible = "renesas,sdhi-r8a7796";
+			reg = <0 0xee140000 0 0x2000>;
+			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 312>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		sdhi3: sd at ee160000 {
+			compatible = "renesas,sdhi-r8a7796";
+			reg = <0 0xee160000 0 0x2000>;
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 311>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.7.0.rc3.207.g0ac5344
