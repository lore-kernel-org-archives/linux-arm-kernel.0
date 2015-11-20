From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 19 Nov 2015 17:05:48 -0800
Subject: [PATCH 4/6] arm64: renesas: r8a7795: enable PFC
In-Reply-To: <cover.1447980335.git.horms+renesas@verge.net.au>
References: <cover.1447980335.git.horms+renesas@verge.net.au>
Message-ID: <9241844a2d3312f3984aacd16ad25fda6e83fc13.1447980335.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Add a PFC node for the on-chip r8a7795 pin controller.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 002b828e8230..e26eecf1230f 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -81,6 +81,11 @@
 			#power-domain-cells = <0>;
 		};
 
+		pfc: pfc at e6060000 {
+			compatible = "renesas,pfc-r8a7795";
+			reg = <0 0xe6060000 0 0x50c>;
+		};
+
 		dmac0: dma-controller at e6700000 {
 			/* Empty node for now */
 		};
-- 
2.1.4
