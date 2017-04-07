From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  7 Apr 2017 11:58:15 -0400
Subject: [PATCH 14/22] ARM: dts: koelsch: Correct clock frequency of X2 DU
 clock input
In-Reply-To: <cover.1491580547.git.horms+renesas@verge.net.au>
References: <cover.1491580547.git.horms+renesas@verge.net.au>
Message-ID: <ebf06af55c7594ed1fc18469a5cddf911c40e687.1491580547.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The X2 crystal oscillator on the Koelsch development board provides a
74.25 MHz clock, not a 148.5 MHz clock.

Fixes: cd21cb46e14aae3a ("ARM: shmobile: koelsch: Add DU external pixel clocks to DT")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 59beb8402a36..001e6116c47c 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -292,7 +292,7 @@
 	x2_clk: x2-clock {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency = <148500000>;
+		clock-frequency = <74250000>;
 	};
 
 	x13_clk: x13-clock {
-- 
2.7.0.rc3.207.g0ac5344
