From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2018 11:09:31 +0200
Subject: [PATCH 36/58] arm64: dts: renesas: r8a774a1: Add FCPF and FCPV
 instances
In-Reply-To: <cover.1536828567.git.horms+renesas@verge.net.au>
References: <cover.1536828567.git.horms+renesas@verge.net.au>
Message-ID: <282419526ad7ba3d0ff5e53c20a5f4f5a273197f.1536828567.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Add FCPF and FCPV instances to the r8a774a1 dtsi, similarly
to what was done for the r8a7796 with commit 41dbbf0c5b4e
("arm64: dts: r8a7796: Add FCPF and FCPV instances"),
commit 69490bc9665d ("arm64: dts: renesas: r8a7796: Point
FDP1 via FCPF to IPMMU-VI0"), and commit cef942d0bd89 ("arm64:
dts: renesas: r8a7796: Point VSPI via FCPVI to IPMMU-VC0").

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 52 +++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index 50c9265aa1c4..5d0109a376c2 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -1385,6 +1385,58 @@
 			resets = <&cpg 408>;
 		};
 
+		fcpf0: fcp at fe950000 {
+			compatible = "renesas,fcpf";
+			reg = <0 0xfe950000 0 0x200>;
+			clocks = <&cpg CPG_MOD 615>;
+			power-domains = <&sysc 14>;
+			resets = <&cpg 615>;
+		};
+
+		fcpvb0: fcp at fe96f000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xfe96f000 0 0x200>;
+			clocks = <&cpg CPG_MOD 607>;
+			power-domains = <&sysc 14>;
+			resets = <&cpg 607>;
+		};
+
+		fcpvd0: fcp at fea27000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xfea27000 0 0x200>;
+			clocks = <&cpg CPG_MOD 603>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 603>;
+			iommus = <&ipmmu_vi0 8>;
+		};
+
+		fcpvd1: fcp at fea2f000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xfea2f000 0 0x200>;
+			clocks = <&cpg CPG_MOD 602>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 602>;
+			iommus = <&ipmmu_vi0 9>;
+		};
+
+		fcpvd2: fcp at fea37000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xfea37000 0 0x200>;
+			clocks = <&cpg CPG_MOD 601>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 601>;
+			iommus = <&ipmmu_vi0 10>;
+		};
+
+		fcpvi0: fcp at fe9af000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xfe9af000 0 0x200>;
+			clocks = <&cpg CPG_MOD 611>;
+			power-domains = <&sysc 14>;
+			resets = <&cpg 611>;
+			iommus = <&ipmmu_vc0 19>;
+		};
+
 		prr: chipid at fff00044 {
 			compatible = "renesas,prr";
 			reg = <0 0xfff00044 0 4>;
-- 
2.11.0
