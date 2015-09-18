From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Sep 2015 09:47:20 +0900
Subject: [PATCH 18/19] ARM: shmobile: r8a7790 dtsi: Add CPG/MSTP Clock Domain
 for sound
In-Reply-To: <cover.1442536920.git.horms+renesas@verge.net.au>
References: <cover.1442536920.git.horms+renesas@verge.net.au>
Message-ID: <ff7273f079953f335cc5a9b3d7b0e7afc586659f.1442536920.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

484adb005886 ("ARM: shmobile: r8a7790 dtsi: Add CPG/MSTP Clock Domain")
added CPG/MSTP clock-cells domain support, but it was missing sound
support. This patch adds it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[horms: Updated commit id referred to in changelog]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index ae5eb281d43a..e07ae5d45e19 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1627,6 +1627,7 @@
 				"mix.0", "mix.1",
 				"dvc.0", "dvc.1",
 				"clk_a", "clk_b", "clk_c", "clk_i";
+		power-domains = <&cpg_clocks>;
 
 		status = "disabled";
 
-- 
2.1.4
