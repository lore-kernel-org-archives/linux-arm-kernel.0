From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:15:31 +0200
Subject: [PATCH 11/41] ARM: dts: porter: Name serial port pfc subnode after
 device name
In-Reply-To: <cover.1467294011.git.horms+renesas@verge.net.au>
References: <cover.1467294011.git.horms+renesas@verge.net.au>
Message-ID: <a1cd3c55d3fcb0003e1dfc5f87131c6689b52944.1467294011.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Name the Pin Function Controller subnode for SCIF0 after its device
name, instead of after the serial port alias.

This avoids conflicts when enabling support for more serial ports later,
either here or in a DT overlay.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-porter.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index e9151e946da8..85d109a5f43c 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -142,7 +142,7 @@
 };
 
 &pfc {
-	scif0_pins: serial0 {
+	scif0_pins: scif0 {
 		groups = "scif0_data_d";
 		function = "scif0";
 	};
-- 
2.7.0.rc3.207.g0ac5344
