From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:15:22 +0200
Subject: [PATCH 02/41] ARM: dts: ape6evm: Name mmc pfc subnode after device
 name
In-Reply-To: <cover.1467294011.git.horms+renesas@verge.net.au>
References: <cover.1467294011.git.horms+renesas@verge.net.au>
Message-ID: <8b68d53ec2c1b4106c3d07781c7773ff3e61c0bf.1467294011.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Name the Pin Function Controller subnode for MMC0 after its device name,
instead of using the generic and indexless "mmc".

This avoids conflicts when enabling support for more MMC interfaces
later, either here or in a DT overlay.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index 5bccc7d229d7..ec7c86e06538 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -193,7 +193,7 @@
 		function = "scifa0";
 	};
 
-	mmc0_pins: mmc {
+	mmc0_pins: mmc0 {
 		groups = "mmc0_data8", "mmc0_ctrl";
 		function = "mmc0";
 	};
-- 
2.7.0.rc3.207.g0ac5344
