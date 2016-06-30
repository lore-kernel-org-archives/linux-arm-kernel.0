From: kieran@bingham.xyz (Kieran Bingham)
Date: Thu, 30 Jun 2016 14:32:43 +0100
Subject: [PATCH 2/2] arm64: dts: r8a7795: add FDP1 device nodes
In-Reply-To: <1467293563-940-1-git-send-email-kieran@bingham.xyz>
References: <1467293563-940-1-git-send-email-kieran@bingham.xyz>
Message-ID: <1467293563-940-3-git-send-email-kieran@bingham.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Kieran Bingham <kieran@bingham.xyz>
--
changes for v2
 - channel labels dropped

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index a451bd217f05..8bc87e09efd7 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -1443,5 +1443,32 @@
 			clocks = <&cpg CPG_MOD 613>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
 		};
+
+		fdp1 at fe940000 {
+			compatible = "renesas,fdp1";
+			reg = <0 0xfe940000 0 0x2400>;
+			interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 119>;
+			power-domains = <&sysc R8A7795_PD_A3VP>;
+			renesas,fcp = <&fcpf0>;
+		};
+
+		fdp1 at fe944000 {
+			compatible = "renesas,fdp1";
+			reg = <0 0xfe944000 0 0x2400>;
+			interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 118>;
+			power-domains = <&sysc R8A7795_PD_A3VP>;
+			renesas,fcp = <&fcpf1>;
+		};
+
+		fdp1 at fe948000 {
+			compatible = "renesas,fdp1";
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
