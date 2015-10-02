From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  2 Oct 2015 11:29:38 +0900
Subject: [PATCH 2/2] ARM: shmobile: r8a7791 dtsi: Add CPG/MSTP Clock Domain
 for sound
In-Reply-To: <cover.1443752733.git.horms+renesas@verge.net.au>
References: <cover.1443752733.git.horms+renesas@verge.net.au>
Message-ID: <56e86dd4bbeb66a7ad67e20fa045c6f51b4da571.1443752733.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

797a0626e08c ("ARM: shmobile: r8a7791 dtsi: Add CPG/MSTP Clock Domain")
added CPG/MSTP clock-cells domain support, but it was missing sound
support. This patch adds it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[horms: updated commit id referred to in changelog]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 831525dd39a6..1666c8a6b143 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1677,6 +1677,7 @@
 				"mix.0", "mix.1",
 				"dvc.0", "dvc.1",
 				"clk_a", "clk_b", "clk_c", "clk_i";
+		power-domains = <&cpg_clocks>;
 
 		status = "disabled";
 
-- 
2.1.4
