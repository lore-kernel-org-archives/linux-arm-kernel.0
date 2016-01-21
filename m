From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 21 Jan 2016 13:26:40 +0800
Subject: [PATCH RFC 13/15] ARM: dts: sun9i: Include SDC2_RST pin in
 mmc2_8bit_pins
In-Reply-To: <1453354002-28366-1-git-send-email-wens@csie.org>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
Message-ID: <1453354002-28366-14-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mmc2_8bit_pins is used with eMMC chips, which also have a reset pin.
The MMC controller also has a reset output that is supported.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index f4f61b02be1a..f68b3242b33a 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -704,7 +704,8 @@
 			mmc2_8bit_pins: mmc2_8bit {
 				allwinner,pins = "PC6", "PC7", "PC8", "PC9",
 						 "PC10", "PC11", "PC12",
-						 "PC13", "PC14", "PC15";
+						 "PC13", "PC14", "PC15",
+						 "PC16";
 				allwinner,function = "mmc2";
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-- 
2.7.0.rc3
