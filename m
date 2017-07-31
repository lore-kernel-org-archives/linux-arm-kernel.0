From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:03:15 +0200
Subject: [PATCH 23/31] arm64: dts: r8a7795: salvator-xs: Connect DU dot clocks
 0 and 3
In-Reply-To: <cover.1501509525.git.horms+renesas@verge.net.au>
References: <cover.1501509525.git.horms+renesas@verge.net.au>
Message-ID: <20b9911c40543d80e45299aa95585d373fadc134.1501509526.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The DU dot clocks 0 and 3 are provided by the programmable VC6 clock
generator. Connect them to the clock source node.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
index 6a7d1b22d0fe..7675de5d4f2c 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
@@ -44,10 +44,12 @@
 		 <&cpg CPG_MOD 722>,
 		 <&cpg CPG_MOD 721>,
 		 <&cpg CPG_MOD 727>,
+		 <&versaclock6 1>,
 		 <&x21_clk>,
-		 <&x22_clk>;
+		 <&x22_clk>,
+		 <&versaclock6 2>;
 	clock-names = "du.0", "du.1", "du.2", "du.3", "lvds.0",
-		      "dclkin.1", "dclkin.2";
+		      "dclkin.0", "dclkin.1", "dclkin.2", "dclkin.3";
 };
 
 &ehci2 {
-- 
2.1.4
