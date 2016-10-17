From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Oct 2016 13:49:03 +0200
Subject: [PATCH 6/6] ARM: sun5i: chip: Add optional buses
In-Reply-To: <cover.92d041a0a6fe40f1c8839cabb70247445eaffdfb.1476704881.git-series.maxime.ripard@free-electrons.com>
References: <cover.92d041a0a6fe40f1c8839cabb70247445eaffdfb.1476704881.git-series.maxime.ripard@free-electrons.com>
Message-ID: <54f17420e7532087c4c63db46a282bfc1678d39e.1476704881.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2C1 and SPI2 buses are exposed on the CHIP headers, and are not
explicitly dedicated to anything.

Add them to the DTS with the muxing already set, but keep them disabled.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-r8-chip.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
index 059d86865b73..c6da5ad37152 100644
--- a/arch/arm/boot/dts/sun5i-r8-chip.dts
+++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
@@ -56,9 +56,11 @@
 
 	aliases {
 		i2c0 = &i2c0;
+		i2c1 = &i2c1;
 		i2c2 = &i2c2;
 		serial0 = &uart1;
 		serial1 = &uart3;
+		spi0 = &spi2;
 	};
 
 	chosen {
@@ -126,6 +128,12 @@
 
 #include "axp209.dtsi"
 
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+	status = "disabled";
+};
+
 &i2c2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c2_pins_a>;
@@ -257,6 +265,12 @@
 	status = "okay";
 };
 
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2_pins_a>;
+	status = "disabled";
+};
+
 &tcon0 {
 	status = "okay";
 };
-- 
git-series 0.8.10
