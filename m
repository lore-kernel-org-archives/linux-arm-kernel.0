From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  3 Dec 2014 14:36:02 +0800
Subject: [PATCH 07/10] ARM: dts: sun9i: Add pinmux setting for mmc0
In-Reply-To: <1417588565-26215-1-git-send-email-wens@csie.org>
References: <1417588565-26215-1-git-send-email-wens@csie.org>
Message-ID: <1417588565-26215-8-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mmc0 is only available on port F, and is always used with a 4 bit wide
bus for the onboard micro-sd slot.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index c766698..f5b5645 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -458,6 +458,14 @@
 				allwinner,pull = <0>;
 			};
 
+			mmc0_pins: mmc0 {
+				allwinner,pins = "PF0","PF1","PF2","PF3",
+						 "PF4","PF5";
+				allwinner,function = "mmc0";
+				allwinner,drive = <2>;
+				allwinner,pull = <0>;
+			};
+
 			uart0_pins_a: uart0 at 0 {
 				allwinner,pins = "PH12", "PH13";
 				allwinner,function = "uart0";
-- 
2.1.3
