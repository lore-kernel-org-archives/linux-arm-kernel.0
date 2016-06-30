From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:15:21 +0200
Subject: [PATCH 01/41] ARM: dts: ape6evm: Name serial port pfc subnode after
 device name
In-Reply-To: <cover.1467294011.git.horms+renesas@verge.net.au>
References: <cover.1467294011.git.horms+renesas@verge.net.au>
Message-ID: <94f58eb2a8e840f5ffe06c8392ca96140fb9390e.1467294011.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Name the Pin Function Controller subnode for SCIFA0 after its device
name, instead of after the serial port alias.

This avoids conflicts when enabling support for more serial ports later,
either here or in a DT overlay.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index 740e5d23f7c7..5bccc7d229d7 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -188,7 +188,7 @@
 };
 
 &pfc {
-	scifa0_pins: serial0 {
+	scifa0_pins: scifa0 {
 		groups = "scifa0_data";
 		function = "scifa0";
 	};
-- 
2.7.0.rc3.207.g0ac5344
