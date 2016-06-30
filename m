From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:15:30 +0200
Subject: [PATCH 10/41] ARM: dts: koelsch: Name spi pfc subnodes after device
 names
In-Reply-To: <cover.1467294011.git.horms+renesas@verge.net.au>
References: <cover.1467294011.git.horms+renesas@verge.net.au>
Message-ID: <a4d98bed5e697333e5dcf74503cdf560229f69bc.1467294011.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Name the Pin Function Controller subnodes for QSPI and MSIOF0 after
their device names, instead of after the spi interface aliases.

This avoids conflicts when enabling support for more spi interfaces
later, either here or in a DT overlay.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 73e5ecf036e1..f8a7d090fd01 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -372,12 +372,12 @@
 		function = "sdhi2";
 	};
 
-	qspi_pins: spi0 {
+	qspi_pins: qspi {
 		groups = "qspi_ctrl", "qspi_data4";
 		function = "qspi";
 	};
 
-	msiof0_pins: spi1 {
+	msiof0_pins: msiof0 {
 		groups = "msiof0_clk", "msiof0_sync", "msiof0_rx",
 				 "msiof0_tx";
 		function = "msiof0";
-- 
2.7.0.rc3.207.g0ac5344
