From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  8 Jun 2016 15:36:26 +0800
Subject: [PATCH] ARM: dts: sun8i-h3: sinovoip-bpi-m2-plus: Fix LED and switch
 labels
Message-ID: <1465371386-14479-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The switch is clearly labeled "power" on the board.

The LED is red, and is lit by default through an external pull up.
Label it as "pwr" even though there is no explicit marking.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Hi Maxime,

This patch fixes 2 copy paste errors in the bpi-m2+ dts that slipped
through. Can you squash it into my original patch?


Thanks
ChenYu

---
 arch/arm/boot/dts/sun8i-h3-sinovoip-bpi-m2-plus.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-sinovoip-bpi-m2-plus.dts b/arch/arm/boot/dts/sun8i-h3-sinovoip-bpi-m2-plus.dts
index 8a19b4b44f1f..8387c458d615 100644
--- a/arch/arm/boot/dts/sun8i-h3-sinovoip-bpi-m2-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-sinovoip-bpi-m2-plus.dts
@@ -67,7 +67,7 @@
 		pinctrl-0 = <&pwr_led_bpi_m2p>;
 
 		pwr_led {
-			label = "orangepi:green:pwr";
+			label = "bpi-m2+:red:pwr";
 			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>; /* PL10 */
 			default-state = "on";
 		};
@@ -79,7 +79,7 @@
 		pinctrl-0 = <&sw_r_bpi_m2p>;
 
 		sw4 {
-			label = "sw4";
+			label = "power";
 			linux,code = <BTN_0>;
 			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
 		};
-- 
2.8.1
