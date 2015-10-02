From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  2 Oct 2015 11:29:37 +0900
Subject: [PATCH 1/2] ARM: shmobile: r8a7790 dtsi: Add CPG/MSTP Clock Domain
 for sound
In-Reply-To: <cover.1443752733.git.horms+renesas@verge.net.au>
References: <cover.1443752733.git.horms+renesas@verge.net.au>
Message-ID: <6507c4efd2ca4a3dccedbc5b4724f9faabf97fca.1443752733.git.horms+renesas@verge.net.au>
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
index a0b2a79cbfbd..4624d0f2a754 100644
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
