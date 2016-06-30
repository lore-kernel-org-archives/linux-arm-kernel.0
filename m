From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:15:39 +0200
Subject: [PATCH 19/41] ARM: dts: kzm9g: Name serial port pfc subnode after
 device name
In-Reply-To: <cover.1467294011.git.horms+renesas@verge.net.au>
References: <cover.1467294011.git.horms+renesas@verge.net.au>
Message-ID: <970a62e07e5cfba58a571e4ba671f438065fcb19.1467294011.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Name the Pin Function Controller subnode for SCIFA4 after its device
name, instead of after the serial port alias.

This avoids conflicts when adding support for more serial ports later,
either here or in a DT overlay.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/sh73a0-kzm9g.dts
index 36567cbf2e1c..1df68b167033 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
@@ -352,7 +352,7 @@
 		};
 	};
 
-	scifa4_pins: serial4 {
+	scifa4_pins: scifa4 {
 		groups = "scifa4_data", "scifa4_ctrl";
 		function = "scifa4";
 	};
-- 
2.7.0.rc3.207.g0ac5344
