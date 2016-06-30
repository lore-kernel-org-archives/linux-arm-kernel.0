From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:15:35 +0200
Subject: [PATCH 15/41] ARM: dts: alt: Name serial port pfc subnode after
 device name
In-Reply-To: <cover.1467294011.git.horms+renesas@verge.net.au>
References: <cover.1467294011.git.horms+renesas@verge.net.au>
Message-ID: <d88f5bc4a92f3a7a825b83708e38dd5c390cfbc6.1467294011.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Name the Pin Function Controller subnode for SCIF2 after its device
name, instead of using some arbitrary name that looks like a serial port
alias, but differs from the actual alias.

This avoids conflicts when enabling support for more serial ports later,
either here or in a DT overlay.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794-alt.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index 383ad791f1db..1335664b2f88 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -111,7 +111,7 @@
 		function = "du";
 	};
 
-	scif2_pins: serial2 {
+	scif2_pins: scif2 {
 		groups = "scif2_data";
 		function = "scif2";
 	};
-- 
2.7.0.rc3.207.g0ac5344
