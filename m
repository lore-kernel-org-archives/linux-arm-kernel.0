From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  7 Dec 2017 10:53:07 +0100
Subject: [PATCH 04/54] arm64: dts: renesas: r8a77970: Add RWDT node
In-Reply-To: <cover.1512640145.git.horms+renesas@verge.net.au>
References: <cover.1512640145.git.horms+renesas@verge.net.au>
Message-ID: <206d082e55850797b7152a7c56ccc5c4a41b72ee.1512640145.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the Watchdog Timer (WDT) controller on the
Renesas R-Car V3M (r8a77970) SoC.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970.dtsi b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
index 97e6981938e7..75d09f1724f0 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -103,6 +103,16 @@
 						  IRQ_TYPE_LEVEL_LOW)>;
 		};
 
+		rwdt: watchdog at e6020000 {
+			compatible = "renesas,r8a77970-wdt",
+				     "renesas,rcar-gen3-wdt";
+			reg = <0 0xe6020000 0 0x0c>;
+			clocks = <&cpg CPG_MOD 402>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 402>;
+			status = "disabled";
+		};
+
 		cpg: clock-controller at e6150000 {
 			compatible = "renesas,r8a77970-cpg-mssr";
 			reg = <0 0xe6150000 0 0x1000>;
-- 
2.11.0
