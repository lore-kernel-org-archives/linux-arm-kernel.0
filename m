From: horms@verge.net.au (Simon Horman)
Date: Fri, 8 Apr 2016 15:58:44 +0900
Subject: [PATCH] Revert "ARM: dts: porter: Enable SCIF_CLK frequency and
 pins"
In-Reply-To: <1459971126-26622-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1459971126-26622-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <20160408065844.GA27209@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 06, 2016 at 09:32:06PM +0200, Sjoerd Simons wrote:
> This reverts commit 19417bd9c5112f58ea63e97ba72edabd5e1cc0fe as
> according to
> http://elinux.org/File:R-CarM2-KOELSCH_PORTER-B_PORTER_C_Comparison.pdf
> the external oscilator for SCIF_CLK is not mounted on the porter boards.
> 
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

Thanks, I will queue up the following as a fix for v4.6 based
on v4.6-rc1.

>From e885767418bff0c591cc1e45babdd25d91b4a795 Mon Sep 17 00:00:00 2001
From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Date: Wed, 6 Apr 2016 21:32:06 +0200
Subject: [PATCH] Revert "ARM: dts: porter: Enable SCIF_CLK frequency and pins"

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
