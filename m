From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 23 Aug 2018 15:13:16 +0100
Subject: [PATCH] arm64: dts: renesas: r8a774a1: Add pinctrl device node
Message-ID: <1535033596-22351-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds pinctrl device node for R8A774A1 SoC.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---

This patch depends on:
https://www.mail-archive.com/linux-renesas-soc at vger.kernel.org/msg30339.html
https://www.mail-archive.com/linux-renesas-soc at vger.kernel.org/msg30539.html

 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index 5b2ee60..b9d2da4 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -200,6 +200,11 @@
 			status = "disabled";
 		};
 
+		pfc: pin-controller at e6060000 {
+			compatible = "renesas,pfc-r8a774a1";
+			reg = <0 0xe6060000 0 0x50c>;
+		};
+
 		cpg: clock-controller at e6150000 {
 			compatible = "renesas,r8a774a1-cpg-mssr";
 			reg = <0 0xe6150000 0 0x0bb0>;
-- 
2.7.4
