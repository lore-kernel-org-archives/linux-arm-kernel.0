From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 28 Oct 2014 17:50:39 +0800
Subject: [PATCH 2/6] ARM: dts: sun9i: Add i2c3 pinmux setting for A80 SoC
In-Reply-To: <1414489843-2680-1-git-send-email-wens@csie.org>
References: <1414489843-2680-1-git-send-email-wens@csie.org>
Message-ID: <1414489843-2680-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i2c3 has only one possible pinmux setting on the A80 SoC.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index b03d791..653bb4d 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -361,6 +361,13 @@
 			#size-cells = <0>;
 			#gpio-cells = <3>;
 
+			i2c3_pins_a: i2c3 at 0 {
+				allwinner,pins = "PG10", "PG11";
+				allwinner,function = "i2c3";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
 			uart0_pins_a: uart0 at 0 {
 				allwinner,pins = "PH12", "PH13";
 				allwinner,function = "uart0";
-- 
2.1.1
