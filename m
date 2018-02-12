From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 12 Feb 2018 17:44:32 +0000
Subject: [PATCH v5 23/26] ARM: dts: r8a7791: Add watchdog support to SoC dtsi
In-Reply-To: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1518457475-4480-24-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds watchdog support to the r8a7791 dtsi.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v4->v5:
* no change

 arch/arm/boot/dts/r8a7791.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index d2a4546..80e20ecd 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -142,6 +142,16 @@
 		#size-cells = <2>;
 		ranges;
 
+		rwdt: watchdog at e6020000 {
+			compatible = "renesas,r8a7791-wdt",
+				     "renesas,rcar-gen2-wdt";
+			reg = <0 0xe6020000 0 0x0c>;
+			clocks = <&cpg CPG_MOD 402>;
+			power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+			resets = <&cpg 402>;
+			status = "disabled";
+		};
+
 		gpio0: gpio at e6050000 {
 			compatible = "renesas,gpio-r8a7791",
 				     "renesas,rcar-gen2-gpio";
-- 
2.7.4
