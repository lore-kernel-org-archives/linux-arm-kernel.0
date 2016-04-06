From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Wed,  6 Apr 2016 21:32:06 +0200
Subject: [PATCH] Revert "ARM: dts: porter: Enable SCIF_CLK frequency and pins"
Message-ID: <1459971126-26622-1-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 19417bd9c5112f58ea63e97ba72edabd5e1cc0fe as
according to
http://elinux.org/File:R-CarM2-KOELSCH_PORTER-B_PORTER_C_Comparison.pdf
the external oscilator for SCIF_CLK is not mounted on the porter boards.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

---

 arch/arm/boot/dts/r8a7791-porter.dts | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index 9554d13..dbcf3bb 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -142,19 +142,11 @@
 };
 
 &pfc {
-	pinctrl-0 = <&scif_clk_pins>;
-	pinctrl-names = "default";
-
 	scif0_pins: serial0 {
 		groups = "scif0_data_d";
 		function = "scif0";
 	};
 
-	scif_clk_pins: scif_clk {
-		groups = "scif_clk";
-		function = "scif_clk";
-	};
-
 	ether_pins: ether {
 		groups = "eth_link", "eth_mdio", "eth_rmii";
 		function = "eth";
@@ -228,11 +220,6 @@
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
2.8.0.rc3
