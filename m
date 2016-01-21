From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 21 Jan 2016 11:41:19 +0900
Subject: [PATCH] ARM: dts: armadillo800eva Correct extal1 frequency to 24 MHz
In-Reply-To: <cover.1453343917.git.horms+renesas@verge.net.au>
References: <cover.1453343917.git.horms+renesas@verge.net.au>
Message-ID: <c61f30a255550bbfc6b83c1ca720661489cac4c0.1453343917.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

On r8a7740/armadillo, actual clock rates are ca. 4% lower than reported
by /sys/kernel/debug/clk/clk_summary. Correct the extal1 frequency from
25 MHz to 24 MHz to fix this.

This matches the Armadillo-800 EVA Product Manual, which claims the main
crystal runs at 24 MHz, and the old legacy/reference board code.

Fixes: 25aa7ba3fdfb ("ARM: shmobile: armadillo800eva: Sync DTS")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index 105d9c95de4a..5c76dcc89df5 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -180,7 +180,7 @@
 };
 
 &extal1_clk {
-	clock-frequency = <25000000>;
+	clock-frequency = <24000000>;
 };
 &extal2_clk {
 	clock-frequency = <48000000>;
-- 
2.1.4
