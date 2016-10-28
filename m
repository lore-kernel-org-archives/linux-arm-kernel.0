From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 28 Oct 2016 18:11:52 +0800
Subject: [PATCH 1/3] ARM: dts: sun9i: Add mmc1 pinmux setting
In-Reply-To: <20161028101154.7350-1-wens@csie.org>
References: <20161028101154.7350-1-wens@csie.org>
Message-ID: <20161028101154.7350-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the A80, mmc1 is available on pingroup G. Designs mostly use this
to connect to an SDIO WiFi chip.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 3c5214cbe4e6..ab6a221027ef 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -700,6 +700,14 @@
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
+			mmc1_pins: mmc1 {
+				allwinner,pins = "PG0", "PG1" ,"PG2", "PG3",
+						 "PG4", "PG5";
+				allwinner,function = "mmc1";
+				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
 			mmc2_8bit_pins: mmc2_8bit {
 				allwinner,pins = "PC6", "PC7", "PC8", "PC9",
 						 "PC10", "PC11", "PC12",
-- 
2.9.3
