From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Nov 2014 10:20:05 +0900
Subject: [PATCH 2/2] ARM: shmobile: r8a7740 dtsi: Correct IIC0 parent clock
In-Reply-To: <cover.1415756961.git.horms+renesas@verge.net.au>
References: <cover.1415756961.git.horms+renesas@verge.net.au>
Message-ID: <b89ff7c3c2dee189489a5f45eb8d72e106179299.1415756961.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

According to the datasheet, the operating clock for IIC0 is the HPP
(RT Peri) clock, not the SUB (Peri) clock. Both clocks run at the same
speed (50 Mhz).

This is consistent with IIC0 being located in the A4R PM domain, and
IIC1 in the A3SP PM domain.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index d46c213..eed697a 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -433,7 +433,7 @@
 			clocks = <&cpg_clocks R8A7740_CLK_S>,
 				 <&cpg_clocks R8A7740_CLK_S>, <&sub_clk>,
 				 <&cpg_clocks R8A7740_CLK_B>,
-				 <&sub_clk>, <&sub_clk>,
+				 <&cpg_clocks R8A7740_CLK_HPP>, <&sub_clk>,
 				 <&cpg_clocks R8A7740_CLK_B>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
-- 
2.1.1
