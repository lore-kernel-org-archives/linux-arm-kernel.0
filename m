From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Nov 2016 15:11:20 +0100
Subject: [PATCH 03/31] ARM: dts: r8a7794: Use SYSC "always-on" PM Domain for
 sound
In-Reply-To: <cover.1479391750.git.horms+renesas@verge.net.au>
References: <cover.1479391750.git.horms+renesas@verge.net.au>
Message-ID: <d5ac75dfb3858a443bc69e0ff06ec360755b7421.1479391750.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Hook up the Audio-DMAC and sound device nodes to the SYSC "always-on" PM
Domain, for a more consistent device-power-area description in DT.

Cfr. commit 0761ff2ad0c581f3 ("ARM: dts: r8a7794: Add SYSC PM Domains").

Fixes: 320d6c5a08a4abd3 ("ARM: dts: r8a7794: add sound support")
Fixes: 298e4ee3d213a076 ("ARM: dts: r8a7794: add Audio-DMAC support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 7d9f0601d3ca..364b4aa8d1c1 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -319,7 +319,7 @@
 				  "ch12";
 		clocks = <&mstp5_clks R8A7794_CLK_AUDIO_DMAC0>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
 		dma-channels = <13>;
 	};
@@ -1485,7 +1485,7 @@
 			      "mix.0", "mix.1",
 			      "dvc.0", "dvc.1",
 			      "clk_a", "clk_b", "clk_c", "clk_i";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 
 		status = "disabled";
 
-- 
2.7.0.rc3.207.g0ac5344
