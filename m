From: biju.das@bp.renesas.com (Biju Das)
Date: Fri,  7 Jul 2017 14:12:44 +0100
Subject: [PATCH v 1/2] ARM: dts: r8a7743: Add Ethernet AVB support
In-Reply-To: <1499433165-62475-1-git-send-email-biju.das@bp.renesas.com>
References: <1499433165-62475-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1499433165-62475-2-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Ethernet AVB support for r8a7743 SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 8380859..ec8657f 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -605,6 +605,19 @@
 			#size-cells = <0>;
 			status = "disabled";
 		};
+
+		avb: ethernet at e6800000 {
+			compatible = "renesas,etheravb-r8a7743",
+				     "renesas,etheravb-rcar-gen2";
+			reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
+			interrupts = <0 163 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 812>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 812>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 	};
 
 	/* External root clock */
-- 
1.9.1
