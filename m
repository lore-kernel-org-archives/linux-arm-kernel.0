From: kieran@bingham.xyz (Kieran Bingham)
Date: Thu,  9 Jun 2016 17:42:49 +0100
Subject: [PATCH 2/2] arm64: dts: r8a7795: add FDP1 device nodes
In-Reply-To: <1465490569-31177-1-git-send-email-kieran@bingham.xyz>
References: <1465490569-31177-1-git-send-email-kieran@bingham.xyz>
Message-ID: <1465490569-31177-3-git-send-email-kieran@bingham.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Kieran Bingham <kieran@bingham.xyz>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index e63e5f29cceb..0c0aa14f7f4d 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -1244,5 +1244,32 @@
 			clocks = <&cpg CPG_MOD 613>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
 		};
+
+		fdp1ch1: fdp1 at fe940000 {
+			compatible = "renesas,r8a7795-fdp1", "renesas,fdp1";
+			reg = <0 0xfe940000 0 0x2400>;
+			interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 119>;
+			power-domains = <&sysc R8A7795_PD_A3VP>;
+			renesas,fcp = <&fcpf0>;
+		};
+
+		fdp1ch2: fdp1 at fe944000 {
+			compatible = "renesas,r8a7795-fdp1", "renesas,fdp1";
+			reg = <0 0xfe944000 0 0x2400>;
+			interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 118>;
+			power-domains = <&sysc R8A7795_PD_A3VP>;
+			renesas,fcp = <&fcpf1>;
+		};
+
+		fdp1ch3: fdp1 at fe948000 {
+			compatible = "renesas,r8a7795-fdp1", "renesas,fdp1";
+			reg = <0 0xfe948000 0 0x2400>;
+			interrupts = <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 117>;
+			power-domains = <&sysc R8A7795_PD_A3VP>;
+			renesas,fcp = <&fcpf2>;
+		};
 	};
 };
-- 
2.7.4
