From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 22 Feb 2014 22:35:59 +0100
Subject: [PATCH 7/7] ARM: dts: sun7i: Enable the SPI controllers of the
 A20-olinuxino-micro
In-Reply-To: <1393104959-12831-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1393104959-12831-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1393104959-12831-8-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A20-Olinuxino-micro has two SPI bus exposed on its UEXT connectors, enable
them.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index b02a796..9d98316 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -18,7 +18,24 @@
 	model = "Olimex A20-Olinuxino Micro";
 	compatible = "olimex,a20-olinuxino-micro", "allwinner,sun7i-a20";
 
+	aliases {
+		spi0 = &spi1;
+		spi1 = &spi2;
+	};
+
 	soc at 01c00000 {
+		spi1: spi at 01c06000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi1_pins_a>;
+			status = "okay";
+		};
+
+		spi2: spi at 01c17000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi2_pins_a>;
+			status = "okay";
+		};
+
 		pinctrl at 01c20800 {
 			led_pins_olinuxino: led_pins at 0 {
 				allwinner,pins = "PH2";
-- 
1.9.0
