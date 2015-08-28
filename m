From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 28 Aug 2015 17:54:37 +0800
Subject: [PATCH 4/6] ARM: dts: sun6i: Add mmc2 pins for 8 bit emmc
In-Reply-To: <1440755679-8266-1-git-send-email-wens@csie.org>
References: <1440755679-8266-1-git-send-email-wens@csie.org>
Message-ID: <1440755679-8266-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This also includes the reset pin for emmc.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 431c7c884e1c..98359f37bf11 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -691,6 +691,16 @@
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
+			mmc2_8bit_emmc_pins: mmc2 at 0 {
+				allwinner,pins = "PC6", "PC7", "PC8", "PC9",
+						 "PC10", "PC11", "PC12",
+						 "PC13", "PC14", "PC15",
+						 "PC24";
+				allwinner,function = "mmc2";
+				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
 			gmac_pins_mii_a: gmac_mii at 0 {
 				allwinner,pins = "PA0", "PA1", "PA2", "PA3",
 						"PA8", "PA9", "PA11",
-- 
2.5.0
