From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 18 Dec 2017 18:06:51 +0000
Subject: [PATCH v2 4/4] ARM: dts: r8a7745: Add TPU support
In-Reply-To: <1513620411-17478-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1513620411-17478-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1513620411-17478-5-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add TPU support to SoC DT.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
v1->v2:
* No change

 arch/arm/boot/dts/r8a7745.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index e68e20f..be316ca 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -1045,6 +1045,16 @@
 			status = "disabled";
 		};
 
+		tpu: pwm at e60f0000 {
+			compatible = "renesas,tpu-r8a7745", "renesas,tpu";
+			reg = <0 0xe60f0000 0 0x148>;
+			clocks = <&cpg CPG_MOD 304>;
+			power-domains = <&sysc R8A7745_PD_ALWAYS_ON>;
+			resets = <&cpg 304>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		sdhi0: sd at ee100000 {
 			compatible = "renesas,sdhi-r8a7745",
 				     "renesas,rcar-gen2-sdhi";
-- 
2.7.4
