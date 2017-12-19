From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 19 Dec 2017 13:35:00 +0000
Subject: [PATCH v3 5/5] ARM: dts: r8a7743: Add TPU support
In-Reply-To: <1513690500-12165-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1513690500-12165-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1513690500-12165-6-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add TPU support to SoC DT.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2->v3:
* No change

 arch/arm/boot/dts/r8a7743.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 282ba5a..f24f36d 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -1152,6 +1152,16 @@
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
