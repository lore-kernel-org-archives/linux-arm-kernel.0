From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 24 Aug 2017 14:45:59 +0100
Subject: [PATCH resend] ARM: dts: r8a7745: Add Ethernet AVB support
In-Reply-To: <1503388405-48325-1-git-send-email-biju.das@bp.renesas.com>
References: <1503388405-48325-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1503582359-43820-1-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Ethernet AVB support for r8a7745 SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
It is applying cleanly on renesas-devel branch tag
renesas-devel-20170824-v4.13-rc6.

It is tested against renesas-devel branch tag
renesas-devel-20170824-v4.13-rc6.

 arch/arm/boot/dts/r8a7745.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 7fd2967..c34f88e 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -707,6 +707,19 @@
 			status = "disabled";
 		};
 
+		avb: ethernet at e6800000 {
+			compatible = "renesas,etheravb-r8a7745",
+				     "renesas,etheravb-rcar-gen2";
+			reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
+			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 812>;
+			power-domains = <&sysc R8A7745_PD_ALWAYS_ON>;
+			resets = <&cpg 812>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		mmcif0: mmc at ee200000 {
 			compatible = "renesas,mmcif-r8a7745",
 				     "renesas,sh-mmcif";
-- 
1.9.1
