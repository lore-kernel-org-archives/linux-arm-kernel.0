From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 28 Apr 2015 12:12:58 +0200
Subject: [PATCH 5/5] ARM: shmobile: bockw dts: Add "nor-jedec" compatible value
In-Reply-To: <1430215978-31087-1-git-send-email-geert+renesas@glider.be>
References: <1430215978-31087-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1430215978-31087-6-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Spansion s25fl008k is compatible with "nor-jedec". Hence add the
"nor-jedec" compatible value, so the driver can bind against the generic
name, cfr. commit 8ff16cf77ce314c2 ("Documentation: devicetree: m25p80:
add "nor-jedec" binding").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 787fa6f9f46ddf4d..7ebc4a4f4608f0af 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -186,7 +186,7 @@
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
