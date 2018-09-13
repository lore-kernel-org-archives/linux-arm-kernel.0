From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2018 11:09:53 +0200
Subject: [PATCH 58/58] arm64: dts: r8a77965: add FDP1 device nodes
In-Reply-To: <cover.1536828567.git.horms+renesas@verge.net.au>
References: <cover.1536828567.git.horms+renesas@verge.net.au>
Message-ID: <450d6079e8d3c40c7ce67ac8bb4a2da9baf56613.1536828567.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hoan Nguyen An <na-hoan@jinso.co.jp>

The r8a77965 has a single FDP1 instance.

Signed-off-by: Hoan Nguyen An <na-hoan@jinso.co.jp>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 77fb909cc839..3437d5e34f6a 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -1667,6 +1667,16 @@
 			status = "disabled";
 		};
 
+		fdp1 at fe940000 {
+			compatible = "renesas,fdp1";
+			reg = <0 0xfe940000 0 0x2400>;
+			interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 119>;
+			power-domains = <&sysc R8A77965_PD_A3VP>;
+			resets = <&cpg 119>;
+			renesas,fcp = <&fcpf0>;
+		};
+
 		fcpf0: fcp at fe950000 {
 			compatible = "renesas,fcpf";
 			reg = <0 0xfe950000 0 0x200>;
-- 
2.11.0
