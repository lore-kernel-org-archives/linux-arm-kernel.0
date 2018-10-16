From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Tue, 16 Oct 2018 16:13:04 +0200
Subject: [PATCH] arm64: dts: rockchip: Use default brightness table for gru.
Message-ID: <20181016141304.21984-1-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After commit 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED
linearly to human eye") the pwm_bl driver is able to calculate a default
brightness table. The calculated table for this PWM will have more
granularity and will be adjusted to change the brightness linearly to
the human eye. Use that table instead of have a DT-defined table with
less granularity.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Hi Heiko,

Note that the patch was only tested on a Samsung Chromebook Plus
(kevin), will be very interesting if someone can test on other gru-based
devices, like Bob, before apply this patch.

Best regards,
 Enric

 arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
index ae8bb721005e..8dbe2c58b3ce 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
@@ -194,14 +194,6 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		brightness-levels = <0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
-				     17 18 19 20 21 22 23 24 25 26 27 28 29 30
-				     31 32 33 34 35 36 37 38 39 40 41 42 43 44
-				     45 46 47 48 49 50 51 52 53 54 55 56 57 58
-				     59 60 61 62 63 64 65 66 67 68 69 70 71 72
-				     73 74 75 76 77 78 79 80 81 82 83 84 85 86
-				     87 88 89 90 91 92 93 94 95 96 97 98 99 100>;
-		default-brightness-level = <51>;
 		enable-gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
 		power-supply = <&pp3300_disp>;
 		pinctrl-names = "default";
-- 
2.19.1
