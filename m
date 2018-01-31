From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 31 Jan 2018 18:24:25 +0000
Subject: [RFC v4 21/26] ARM: dts: r8a7745: Add watchdog support to SoC dtsi
In-Reply-To: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1517423070-24236-22-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds watchdog support to the r8a7745 SoC dtsi.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3->4:
* no change

 arch/arm/boot/dts/r8a7745.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 6bc1cf4..5d1b8f2 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -321,6 +321,16 @@
 			reg = <0 0xe6160000 0 0x100>;
 		};
 
+		rwdt: watchdog at e6020000 {
+			compatible = "renesas,r8a7745-wdt",
+				     "renesas,rcar-gen2-wdt";
+			reg = <0 0xe6020000 0 0x0c>;
+			clocks = <&cpg CPG_MOD 402>;
+			power-domains = <&sysc R8A7745_PD_ALWAYS_ON>;
+			resets = <&cpg 402>;
+			status = "disabled";
+		};
+
 		sysc: system-controller at e6180000 {
 			compatible = "renesas,r8a7745-sysc";
 			reg = <0 0xe6180000 0 0x200>;
-- 
2.7.4
