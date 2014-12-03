From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  3 Dec 2014 14:36:04 +0800
Subject: [PATCH 09/10] ARM: dts: sun9i: Add pinmux settings for mmc2
In-Reply-To: <1417588565-26215-1-git-send-email-wens@csie.org>
References: <1417588565-26215-1-git-send-email-wens@csie.org>
Message-ID: <1417588565-26215-10-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mmc2 is available on port C. Add a pinmux setting for usual 4 bit
wide bus, as well as one with the 4 extra pins for 8 bit wide bus.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index f5b5645..fc866d8 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -466,6 +466,21 @@
 				allwinner,pull = <0>;
 			};
 
+			mmc2_pins: mmc2 {
+				allwinner,pins = "PC6","PC7","PC8","PC9",
+						 "PC10","PC11";
+				allwinner,function = "mmc2";
+				allwinner,drive = <2>;
+				allwinner,pull = <1>;
+			};
+
+			mmc2_8bit_pins: mmc2_8bit {
+				allwinner,pins = "PC12","PC13","PC14","PC15";
+				allwinner,function = "mmc2";
+				allwinner,drive = <2>;
+				allwinner,pull = <1>;
+			};
+
 			uart0_pins_a: uart0 at 0 {
 				allwinner,pins = "PH12", "PH13";
 				allwinner,function = "uart0";
-- 
2.1.3
