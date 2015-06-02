From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  2 Jun 2015 18:04:01 +0800
Subject: [PATCH 1/3] ARM: dts: sun8i: Add pinmux setting for 8bit mmc2
In-Reply-To: <1433239443-738-1-git-send-email-wens@csie.org>
References: <1433239443-738-1-git-send-email-wens@csie.org>
Message-ID: <1433239443-738-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mmc2 is mostly used with eMMC flash chips, as an alternative to
raw NAND flash chips. 8 bit mmc is commonly used.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index faea94e45eeb..7abd0ae3143d 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -366,6 +366,16 @@
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
+			mmc2_8bit_pins: mmc2_8bit {
+				allwinner,pins = "PC5", "PC6", "PC8",
+						 "PC9", "PC10", "PC11",
+						 "PC12", "PC13", "PC14",
+						 "PC15";
+				allwinner,function = "mmc2";
+				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
 			i2c0_pins_a: i2c0 at 0 {
 				allwinner,pins = "PH2", "PH3";
 				allwinner,function = "i2c0";
-- 
2.1.4
