From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 16 Jan 2017 17:56:59 +0100
Subject: [PATCH v3 9/13] arm64: allwinner: a64: Add MMC pinctrl nodes
In-Reply-To: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
References: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
Message-ID: <dad93c772cf4d0410ec389152863b4e6ac7dd38f.1484585798.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A64 only has a single set of pins for each MMC controller. Since we
already have boards that require all of them, let's add them to the DTSI.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 25 ++++++++++++++++++++-
 1 file changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 143e9706438f..8e149498e096 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -205,6 +205,31 @@
 				function = "i2c1";
 			};
 
+			mmc0_pins: mmc0-pins {
+				pins = "PF0", "PF1", "PF2", "PF3",
+				       "PF4", "PF5";
+				function = "mmc0";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+
+			mmc1_pins: mmc1-pins {
+				pins = "PG0", "PG1", "PG2", "PG3",
+				       "PG4", "PG5";
+				function = "mmc1";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+
+			mmc2_pins: mmc2-pins {
+				pins = "PC1", "PC5", "PC6", "PC8", "PC9",
+				       "PC10","PC11", "PC12", "PC13",
+				       "PC14", "PC15", "PC16";
+				function = "mmc2";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+
 			uart0_pins_a: uart0 at 0 {
 				pins = "PB8", "PB9";
 				function = "uart0";
-- 
git-series 0.8.11
