From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Thu, 22 Dec 2016 04:02:34 +0800
Subject: [PATCH 2/3] ARM: dts: sun5i: add a pinctrl node for 4bit mmc2
In-Reply-To: <20161221200235.11617-1-icenowy@aosc.xyz>
References: <20161221200235.11617-1-icenowy@aosc.xyz>
Message-ID: <20161221200235.11617-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some board only use 4bit mode of mmc2.

Add a pinctrl node for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun5i.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 54170147040f..c058d37d5433 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -594,6 +594,14 @@
 				bias-pull-up;
 			};
 
+			mmc2_4bit_pins_a: mmc2-4bit at 0 {
+				pins = "PC6", "PC7", "PC8", "PC9",
+				       "PC10", "PC11";
+				function = "mmc2";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+
 			spi2_pins_a: spi2 at 0 {
 				pins = "PE1", "PE2", "PE3";
 				function = "spi2";
-- 
2.11.0
