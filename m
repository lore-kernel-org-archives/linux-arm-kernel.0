From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:15:26 +0200
Subject: [PATCH 06/41] ARM: dts: lager: Name serial port pfc subnodes after
 device names
In-Reply-To: <cover.1467294011.git.horms+renesas@verge.net.au>
References: <cover.1467294011.git.horms+renesas@verge.net.au>
Message-ID: <ca34829853779da173785b25531630469d0cef99.1467294011.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Name the Pin Function Controller subnodes for SCIF0 and SCIFA1 after
their device names, instead of after the serial port aliases.

This avoids conflicts when enabling support for more serial ports later,
either here or in a DT overlay.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 9d20ace33b01..c6803977b427 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -317,7 +317,7 @@
 		function = "du";
 	};
 
-	scif0_pins: serial0 {
+	scif0_pins: scif0 {
 		groups = "scif0_data";
 		function = "scif0";
 	};
@@ -337,7 +337,7 @@
 		function = "intc";
 	};
 
-	scifa1_pins: serial1 {
+	scifa1_pins: scifa1 {
 		groups = "scifa1_data";
 		function = "scifa1";
 	};
-- 
2.7.0.rc3.207.g0ac5344
