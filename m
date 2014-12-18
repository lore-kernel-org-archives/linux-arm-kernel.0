From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 18 Dec 2014 15:00:58 +0800
Subject: [PATCH v2 11/11] ARM: dts: sun9i: Enable mmc2 on A80 Optimus Board
In-Reply-To: <1418886058-8145-1-git-send-email-wens@csie.org>
References: <1418886058-8145-1-git-send-email-wens@csie.org>
Message-ID: <1418886058-8145-12-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A80 Optimus Board has a 16GB eMMC connected to mmc2, with 8 bit
wide data bus.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index 4c94aff..2d0d490 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -70,6 +70,15 @@
 			status = "okay";
 		};
 
+		mmc2: mmc at 01c11000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc2_8bit_pins>;
+			vmmc-supply = <&reg_vcc3v0>;
+			bus-width = <8>;
+			non-removable;
+			status = "okay";
+		};
+
 		pio: pinctrl at 06000800 {
 			i2c3_pins_a: i2c3 at 0 {
 				/* Enable internal pull-up */
-- 
2.1.3
