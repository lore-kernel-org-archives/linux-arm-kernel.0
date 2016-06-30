From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:15:25 +0200
Subject: [PATCH 05/41] ARM: dts: marzen: Name serial port pfc subnodes after
 device names
In-Reply-To: <cover.1467294011.git.horms+renesas@verge.net.au>
References: <cover.1467294011.git.horms+renesas@verge.net.au>
Message-ID: <46344361f5cdffac3c42b9651595f6e0bd609885.1467294011.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Name the Pin Function Controller subnodes for SCIF2 and SCIF4 after
their device names, instead of using some arbitrary names that look like
serial port aliases, but differ from the actual aliases.

This avoids conflicts when enabling support for more serial ports later,
either here or in a DT overlay.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index cec79a6347c0..013e6f510b0f 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -195,12 +195,12 @@
 		};
 	};
 
-	scif2_pins: serial2 {
+	scif2_pins: scif2 {
 		groups = "scif2_data_c";
 		function = "scif2";
 	};
 
-	scif4_pins: serial4 {
+	scif4_pins: scif4 {
 		groups = "scif4_data";
 		function = "scif4";
 	};
-- 
2.7.0.rc3.207.g0ac5344
