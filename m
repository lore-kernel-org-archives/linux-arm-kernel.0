From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 14 Dec 2017 10:56:16 +0000
Subject: [PATCH 6/6] ARM: dts: r8a7743: Add TPU support
In-Reply-To: <1513248976-26700-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1513248976-26700-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1513248976-26700-7-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add TPU support to SoC DT.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 6766c76..861e76d 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -1157,6 +1157,16 @@
 			status = "disabled";
 		};
 
+		tpu: pwm at e60f0000 {
+			compatible = "renesas,tpu-r8a7743", "renesas,tpu";
+			reg = <0 0xe60f0000 0 0x148>;
+			clocks = <&cpg CPG_MOD 304>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 304>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		sdhi0: sd at ee100000 {
 			compatible = "renesas,sdhi-r8a7743",
 				     "renesas,rcar-gen2-sdhi";
-- 
2.7.4
