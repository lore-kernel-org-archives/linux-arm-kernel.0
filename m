From: kbingham@kernel.org (Kieran Bingham)
Date: Tue, 13 Feb 2018 19:30:35 +0000
Subject: [PATCH v2 2/4] arm64: dts: renesas: r8a77995: add VSP instances
In-Reply-To: <1518550237-16753-1-git-send-email-kbingham@kernel.org>
References: <1518550237-16753-1-git-send-email-kbingham@kernel.org>
Message-ID: <1518550237-16753-3-git-send-email-kbingham@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

The r8a77995 has a VSPBS to support image processing such as blending of
two input images, and has two VSPDs to handle display pipelines with a
DU.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

---
v2:
 - Fix VSPD register map size
 - Squash VSPBS and VSPD patches together

 arch/arm64/boot/dts/renesas/r8a77995.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index 196a917afea6..19bd8be9926a 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -692,6 +692,16 @@
 			status = "disabled";
 		};
 
+		vspbs: vsp at fe960000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfe960000 0 0x4000>;
+			interrupts = <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 627>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 627>;
+			renesas,fcp = <&fcpvb0>;
+		};
+
 		fcpvb0: fcp at fe96f000 {
 			compatible = "renesas,fcpv";
 			reg = <0 0xfe96f000 0 0x200>;
@@ -701,6 +711,16 @@
 			iommus = <&ipmmu_vp0 5>;
 		};
 
+		vspd0: vsp at fea20000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfea20000 0 0x8000>;
+			interrupts = <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 623>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 623>;
+			renesas,fcp = <&fcpvd0>;
+		};
+
 		fcpvd0: fcp at fea27000 {
 			compatible = "renesas,fcpv";
 			reg = <0 0xfea27000 0 0x200>;
@@ -710,6 +730,16 @@
 			iommus = <&ipmmu_vi0 8>;
 		};
 
+		vspd1: vsp at fea80000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfea28000 0 0x8000>;
+			interrupts = <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 622>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 622>;
+			renesas,fcp = <&fcpvd1>;
+		};
+
 		fcpvd1: fcp at fea2f000 {
 			compatible = "renesas,fcpv";
 			reg = <0 0xfea2f000 0 0x200>;
-- 
2.7.4
