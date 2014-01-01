From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  1 Jan 2014 10:30:50 +0800
Subject: [PATCH v3 5/5] ARM: dts: sun7i: Add pin muxing options for clock
 outputs
In-Reply-To: <1388543450-16741-1-git-send-email-wens@csie.org>
References: <1388543450-16741-1-git-send-email-wens@csie.org>
Message-ID: <1388543450-16741-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the clock output pin options on the A20.
The 2 pins can output a configurable clock to be used by
external modules. This is used on the CubieTruck, to supply
a 32768 Hz low power clock to the onboard Wifi+BT module.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index e192c99..0062811 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -418,6 +418,20 @@
 				allwinner,drive = <0>;
 				allwinner,pull = <0>;
 			};
+
+			clk_out_a_pins_a: clk_out_a at 0 {
+				allwinner,pins = "PI12";
+				allwinner,function = "clk_out_a";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			clk_out_b_pins_a: clk_out_b at 0 {
+				allwinner,pins = "PI13";
+				allwinner,function = "clk_out_b";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		timer at 01c20c00 {
-- 
1.8.5.2
