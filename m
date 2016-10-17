From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Oct 2016 13:49:02 +0200
Subject: [PATCH 5/6] ARM: sun5i: Add RGB 565 LCD pins
In-Reply-To: <cover.92d041a0a6fe40f1c8839cabb70247445eaffdfb.1476704881.git-series.maxime.ripard@free-electrons.com>
References: <cover.92d041a0a6fe40f1c8839cabb70247445eaffdfb.1476704881.git-series.maxime.ripard@free-electrons.com>
Message-ID: <46596d638c314a117c55e6a9086669358b121f2b.1476704881.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some boards use the LCD in RGB565. Enable the pin muxing option.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 245cee14cf1d..b4ccee8cfb02 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -574,6 +574,16 @@
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
+			lcd_rgb565_pins: lcd_rgb565 at 0 {
+				allwinner,pins = "PD3", "PD4", "PD5", "PD6", "PD7",
+						 "PD10", "PD11", "PD12", "PD13", "PD14", "PD15",
+						 "PD19", "PD20", "PD21", "PD22", "PD23",
+						 "PD24", "PD25", "PD26", "PD27";
+				allwinner,function = "lcd0";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
 			mmc0_pins_a: mmc0 at 0 {
 				allwinner,pins = "PF0", "PF1", "PF2", "PF3",
 						 "PF4", "PF5";
-- 
git-series 0.8.10
