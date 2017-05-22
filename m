From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 May 2017 15:59:04 +0200
Subject: [PATCH 31/35] arm64: dts: renesas: r8a7795-salvator-x: Add DU
 external dot clocks
In-Reply-To: <cover.1495457812.git.horms+renesas@verge.net.au>
References: <cover.1495457812.git.horms+renesas@verge.net.au>
Message-ID: <68b0a3cde86431285d57f33f34df3fea00584960.1495457812.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The DU1 and DU2 external dot clocks are provided by the fixed frequency
clock generators X21 and X22, while the DU0 and DU3 clocks are provided
by the programmable Versaclock5 clock generator.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 52fce67df341..2a5358b8f229 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -40,6 +40,20 @@
 	};
 };
 
+&du {
+	clocks = <&cpg CPG_MOD 724>,
+		 <&cpg CPG_MOD 723>,
+		 <&cpg CPG_MOD 722>,
+		 <&cpg CPG_MOD 721>,
+		 <&cpg CPG_MOD 727>,
+		 <&versaclock5 1>,
+		 <&x21_clk>,
+		 <&x22_clk>,
+		 <&versaclock5 2>;
+	clock-names = "du.0", "du.1", "du.2", "du.3", "lvds.0",
+		      "dclkin.0", "dclkin.1", "dclkin.2", "dclkin.3";
+};
+
 &ehci2 {
 	status = "okay";
 };
-- 
2.1.4
