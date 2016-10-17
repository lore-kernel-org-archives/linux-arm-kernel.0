From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Oct 2016 13:49:00 +0200
Subject: [PATCH 3/6] ARM: sun5i: Rename A10s pins
In-Reply-To: <cover.92d041a0a6fe40f1c8839cabb70247445eaffdfb.1476704881.git-series.maxime.ripard@free-electrons.com>
References: <cover.92d041a0a6fe40f1c8839cabb70247445eaffdfb.1476704881.git-series.maxime.ripard@free-electrons.com>
Message-ID: <926093bcce58496cdb5cea55aaa65e958d36cb76.1476704881.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SPI2 pins on the sun5i PB bank are only available on the A10s. Rename
the A10s only bank so that it doesn't confuse people on the other SoCs
whose indexing would start at b.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 4 ++--
 arch/arm/boot/dts/sun5i-a10s.dtsi                | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index aef91476f9ae..0684d7930d65 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -250,8 +250,8 @@
 
 &spi2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spi2_pins_a>,
-		    <&spi2_cs0_pins_a>;
+	pinctrl-0 = <&spi2_pins_b>,
+		    <&spi2_cs0_pins_b>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index c41a2ba34dde..7aa8c7aa0153 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -243,14 +243,14 @@
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
-	spi2_pins_a: spi2 at 0 {
+	spi2_pins_b: spi2 at 1 {
 		allwinner,pins = "PB12", "PB13", "PB14";
 		allwinner,function = "spi2";
 		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
-	spi2_cs0_pins_a: spi2_cs0 at 0 {
+	spi2_cs0_pins_b: spi2_cs0 at 1 {
 		allwinner,pins = "PB11";
 		allwinner,function = "spi2";
 		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-- 
git-series 0.8.10
