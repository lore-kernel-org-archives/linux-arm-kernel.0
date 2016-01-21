From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 21 Jan 2016 13:26:35 +0800
Subject: [PATCH RFC 08/15] ARM: dts: sun6i: Add mmc3 pins for 8 bit emmc
In-Reply-To: <1453354002-28366-1-git-send-email-wens@csie.org>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
Message-ID: <1453354002-28366-9-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mmc2 and mmc3 are available on the same pins, with different mux values.
However, only mmc3 supports 8 bit DDR transfer modes.

Since preference for mmc3 over mmc2 is due to DDR transfer modes, just
set the drive strength to 40mA, which is needed for DDR.

This pinmux setting also includes the hardware reset pin for emmc.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index b6ad7850fac6..1867af24ff52 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -709,6 +709,16 @@
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
+			mmc3_8bit_emmc_pins: mmc3 at 1 {
+				allwinner,pins = "PC6", "PC7", "PC8", "PC9",
+						 "PC10", "PC11", "PC12",
+						 "PC13", "PC14", "PC15",
+						 "PC24";
+				allwinner,function = "mmc3";
+				allwinner,drive = <SUN4I_PINCTRL_40_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
 			gmac_pins_mii_a: gmac_mii at 0 {
 				allwinner,pins = "PA0", "PA1", "PA2", "PA3",
 						"PA8", "PA9", "PA11",
-- 
2.7.0.rc3
