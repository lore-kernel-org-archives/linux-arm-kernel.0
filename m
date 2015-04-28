From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 28 Apr 2015 12:12:57 +0200
Subject: [PATCH 4/5] ARM: shmobile: bockw-reference dts: Add "nor-jedec"
 compatible value
In-Reply-To: <1430215978-31087-1-git-send-email-geert+renesas@glider.be>
References: <1430215978-31087-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1430215978-31087-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Spansion s25fl008k is compatible with "nor-jedec". Hence add the
"nor-jedec" compatible value, so the driver can bind against the generic
name, cfr. commit 8ff16cf77ce314c2 ("Documentation: devicetree: m25p80:
add "nor-jedec" binding").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7778-bockw-reference.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
index 04c0c37bb7843997..f9422d887b4441c3 100644
--- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -119,7 +119,7 @@
 	flash: flash at 0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spansion,s25fl008k";
+		compatible = "spansion,s25fl008k", "nor-jedec";
 		reg = <0>;
 		spi-max-frequency = <104000000>;
 		m25p,fast-read;
-- 
1.9.1
