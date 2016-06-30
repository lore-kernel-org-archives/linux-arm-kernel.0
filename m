From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:15:32 +0200
Subject: [PATCH 12/41] ARM: dts: porter: Name spi pfc subnode after device name
In-Reply-To: <cover.1467294011.git.horms+renesas@verge.net.au>
References: <cover.1467294011.git.horms+renesas@verge.net.au>
Message-ID: <2d3e17013ba58a5f092133794694d2f50a4f0564.1467294011.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Name the Pin Function Controller subnode for QSPI after its device name,
instead of after the spi interface alias.

This avoids conflicts when enabling support for more spi interfaces
later, either here or in a DT overlay.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-porter.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index 85d109a5f43c..6761d11d3f9e 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -167,7 +167,7 @@
 		function = "sdhi2";
 	};
 
-	qspi_pins: spi0 {
+	qspi_pins: qspi {
 		groups = "qspi_ctrl", "qspi_data4";
 		function = "qspi";
 	};
-- 
2.7.0.rc3.207.g0ac5344
