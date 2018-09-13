From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2018 11:09:21 +0200
Subject: [PATCH 26/58] arm64: dts: renesas: r8a774a1: Add pinctrl device node
In-Reply-To: <cover.1536828567.git.horms+renesas@verge.net.au>
References: <cover.1536828567.git.horms+renesas@verge.net.au>
Message-ID: <3698dbd02c93545f08dd309d159ef20956e07355.1536828567.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

This patch adds pinctrl device node for R8A774A1 SoC.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index b9a381808417..c956bf7ecde9 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -133,6 +133,11 @@
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
2.11.0
