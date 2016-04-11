From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 11 Apr 2016 10:52:55 +0900
Subject: [PATCH] Revert "ARM: dts: porter: Enable SCIF_CLK frequency and pins"
In-Reply-To: <cover.1460339328.git.horms+renesas@verge.net.au>
References: <cover.1460339328.git.horms+renesas@verge.net.au>
Message-ID: <e885767418bff0c591cc1e45babdd25d91b4a795.1460339328.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

This reverts commit 19417bd9c511 ("ARM: dts: porter: Enable SCIF_CLK
frequency and pins") as according to
http://elinux.org/File:R-CarM2-KOELSCH_PORTER-B_PORTER_C_Comparison.pdf
the external oscillator for SCIF_CLK is not mounted on the porter boards.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-porter.dts | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index 6c08314427d6..329a9dcc88e9 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -143,19 +143,11 @@
 };
 
 &pfc {
-	pinctrl-0 = <&scif_clk_pins>;
-	pinctrl-names = "default";
-
 	scif0_pins: serial0 {
 		renesas,groups = "scif0_data_d";
 		renesas,function = "scif0";
 	};
 
-	scif_clk_pins: scif_clk {
-		renesas,groups = "scif_clk";
-		renesas,function = "scif_clk";
-	};
-
 	ether_pins: ether {
 		renesas,groups = "eth_link", "eth_mdio", "eth_rmii";
 		renesas,function = "eth";
@@ -229,11 +221,6 @@
 	status = "okay";
 };
 
-&scif_clk {
-	clock-frequency = <14745600>;
-	status = "okay";
-};
-
 &ether {
 	pinctrl-0 = <&ether_pins &phy1_pins>;
 	pinctrl-names = "default";
-- 
2.1.4
