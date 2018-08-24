From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 24 Aug 2018 10:30:29 +0100
Subject: [PATCH v2 9/9] arm64: dts: renesas: r8a774a1: Add FCPF and FCPV
 instances
In-Reply-To: <c27a266e-3eaa-a879-85ab-0e0aeb5f8b31@cogentembedded.com>
References: <c27a266e-3eaa-a879-85ab-0e0aeb5f8b31@cogentembedded.com>
Message-ID: <1535103029-10576-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add FCPF and FCPV instances to the r8a774a1 dtsi, similarly
to what was done for the r8a7796 with commits 41dbbf0c5 ("arm64: dts:
r8a7796: Add FCPF and FCPV instances"), 69490bc9665d ("arm64: dts:
renesas: r8a7796: Point FDP1 via FCPF to IPMMU-VI0"), and cef942d0bd89
("arm64: dts: renesas: r8a7796: Point VSPI via FCPVI to IPMMU-VC0").

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
v1->v2:
* moved SHA1 hex to 12 digits as per Sergei comment

 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 52 +++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index f23bbfd..5b2ee60 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -1260,6 +1260,58 @@
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
2.7.4
