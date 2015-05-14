From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 14 May 2015 10:06:50 +0900
Subject: [PATCH 21/31] ARM: shmobile: lager dts: Add "nor-jedec" compatible
 value
In-Reply-To: <cover.1431565427.git.horms+renesas@verge.net.au>
References: <cover.1431565427.git.horms+renesas@verge.net.au>
Message-ID: <7821637c4da224bdcca54421d07a0bb43e6955a9.1431565427.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Spansion s25fl512s is compatible with "nor-jedec". Hence add the
"nor-jedec" compatible value, so the driver can bind against the generic
name, cfr. commit 8ff16cf77ce314c2 ("Documentation: devicetree: m25p80:
add "nor-jedec" binding").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index aaa4f258e279..a6c793de8d80 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -429,7 +429,7 @@
 	flash: flash at 0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spansion,s25fl512s";
+		compatible = "spansion,s25fl512s", "nor-jedec";
 		reg = <0>;
 		spi-max-frequency = <30000000>;
 		spi-tx-bus-width = <4>;
-- 
2.1.4
