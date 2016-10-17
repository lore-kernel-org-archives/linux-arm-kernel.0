From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Oct 2016 13:49:01 +0200
Subject: [PATCH 4/6] ARM: sun5i: Add SPI2 pins
In-Reply-To: <cover.92d041a0a6fe40f1c8839cabb70247445eaffdfb.1476704881.git-series.maxime.ripard@free-electrons.com>
References: <cover.92d041a0a6fe40f1c8839cabb70247445eaffdfb.1476704881.git-series.maxime.ripard@free-electrons.com>
Message-ID: <2a041979c4cc262535d204e6519d8a25fbbc3a94.1476704881.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the sun5i have the SPI2 pins exposed on the PE bank. Add them to the
DT.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index e374f4fc8073..245cee14cf1d 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -591,6 +591,20 @@
 				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 			};
 
+			spi2_pins_a: spi2 at 0 {
+				allwinner,pins = "PE1", "PE2", "PE3";
+				allwinner,function = "spi2";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			spi2_cs0_pins_a: spi2-cs0 at 0 {
+				allwinner,pins = "PE0";
+				allwinner,function = "spi2";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
 			uart3_pins_a: uart3 at 0 {
 				allwinner,pins = "PG9", "PG10";
 				allwinner,function = "uart3";
-- 
git-series 0.8.10
