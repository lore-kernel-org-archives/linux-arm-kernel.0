From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 18 Dec 2014 15:00:57 +0800
Subject: [PATCH v2 10/11] ARM: dts: sun9i: Add 8 bit mmc pinmux setting for
 mmc2
In-Reply-To: <1418886058-8145-1-git-send-email-wens@csie.org>
References: <1418886058-8145-1-git-send-email-wens@csie.org>
Message-ID: <1418886058-8145-11-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mmc2 is available on port C. Add a pinmux setting for 8 bit wide eMMC.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index b42e2e7..7dc09e7 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -474,6 +474,15 @@
 				allwinner,pull = <0>;
 			};
 
+			mmc2_8bit_pins: mmc2_8bit {
+				allwinner,pins = "PC6", "PC7", "PC8", "PC9",
+						 "PC10", "PC11", "PC12",
+						 "PC13", "PC14", "PC15";
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
