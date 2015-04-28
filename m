From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 28 Apr 2015 12:12:54 +0200
Subject: [PATCH 1/5] ARM: shmobile: koelsch dts: Add "nor-jedec" compatible
 value
In-Reply-To: <1430215978-31087-1-git-send-email-geert+renesas@glider.be>
References: <1430215978-31087-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1430215978-31087-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Spansion s25fl512s is compatible with "nor-jedec". Hence add the
"nor-jedec" compatible value, so the driver can bind against the generic
name, cfr. commit 8ff16cf77ce314c2 ("Documentation: devicetree: m25p80:
add "nor-jedec" binding").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 74c3212f1f11e47e..70e9d5e9afddc546 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -474,7 +474,7 @@
 	flash: flash at 0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spansion,s25fl512s";
+		compatible = "spansion,s25fl512s", "nor-jedec";
 		reg = <0>;
 		spi-max-frequency = <30000000>;
 		spi-tx-bus-width = <4>;
-- 
1.9.1
