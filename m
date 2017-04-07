From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  7 Apr 2017 11:58:06 -0400
Subject: [PATCH 05/22] ARM: dts: r8a7794: Correct clock of DU1
In-Reply-To: <cover.1491580547.git.horms+renesas@verge.net.au>
References: <cover.1491580547.git.horms+renesas@verge.net.au>
Message-ID: <89675f36c9e17512812b9d14d9824f8ef92782c3.1491580547.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The second channel of the display unit uses a different module clock
than the first channel.

Fixes: 46c4f13d04d729fa ("ARM: shmobile: r8a7794: Add DU node to device tree")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index f5f8d1c03ef7..2f6e94fd408c 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -925,7 +925,7 @@
 		interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_DU0>,
-			 <&mstp7_clks R8A7794_CLK_DU0>;
+			 <&mstp7_clks R8A7794_CLK_DU1>;
 		clock-names = "du.0", "du.1";
 		status = "disabled";
 
-- 
2.7.0.rc3.207.g0ac5344
