From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 30 Jan 2018 20:22:54 +0000
Subject: [RFC v3 21/25] ARM: dts: r8a7790: Add watchdog support to SoC dtsi
In-Reply-To: <1517343778-27902-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1517343778-27902-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1517343778-27902-22-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds watchdog support to the r8a7790 dtsi.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v1->v3:
* rwdt moved before gpio at e6050000

 arch/arm/boot/dts/r8a7790.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index a84bf35..83d6704 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -218,6 +218,16 @@
 		#size-cells = <2>;
 		ranges;
 
+		rwdt: watchdog at e6020000 {
+			compatible = "renesas,r8a7790-wdt",
+				     "renesas,rcar-gen2-wdt";
+			reg = <0 0xe6020000 0 0x0c>;
+			clocks = <&cpg CPG_MOD 402>;
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 402>;
+			status = "disabled";
+		};
+
 		gpio0: gpio at e6050000 {
 			compatible = "renesas,gpio-r8a7790",
 				     "renesas,rcar-gen2-gpio";
-- 
2.7.4
