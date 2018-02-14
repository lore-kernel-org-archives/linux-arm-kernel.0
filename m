From: clabbe@baylibre.com (Corentin Labbe)
Date: Wed, 14 Feb 2018 08:54:47 +0000
Subject: [PATCH] ARM64: dts: allwinner: sun50i-h5-orangepi-zero-plus2: rename
 mmc0_pins_a to mmc0_pins
Message-ID: <1518598487-29201-1-git-send-email-clabbe@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mmc0_pins_a were renamed in arch/arm but not in arch/arm64 resulting in
a build failure.

Fixes: 813f2c8fa119 ("ARM: dts: sunxi: h3-h5: rename mmc0_pins_a and mmc1_pins_a")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
index feee125a4e9a..87c1a0dace5f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
@@ -82,7 +82,7 @@
 
 &mmc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
+	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	vqmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&wifi_pwrseq>;
-- 
2.13.6
