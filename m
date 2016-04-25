From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Apr 2016 14:27:38 +1000
Subject: [PATCH 20/22] ARM: dts: r8a7790: fix max-frequency for SDHI
In-Reply-To: <cover.1461558315.git.horms+renesas@verge.net.au>
References: <cover.1461558315.git.horms+renesas@verge.net.au>
Message-ID: <21c7d0fcbe10a1a81fb791a9bdcca2381bc16c15.1461558315.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The wrong values come from an old datasheet (H2 v0.6). Anything later
has the fixed value of 195MHz (H2 v0.7 up to Gen2-common V2.0).

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index b920facb0c3b..776a2aed81d2 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -589,7 +589,7 @@
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
 		dmas = <&dmac1 0xcd>, <&dmac1 0xce>;
 		dma-names = "tx", "rx";
-		max-frequency = <156000000>;
+		max-frequency = <195000000>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -601,7 +601,7 @@
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI1>;
 		dmas = <&dmac1 0xc9>, <&dmac1 0xca>;
 		dma-names = "tx", "rx";
-		max-frequency = <156000000>;
+		max-frequency = <195000000>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
-- 
2.7.0.rc3.207.g0ac5344
