From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 30 Dec 2013 11:25:49 +0800
Subject: [PATCH v2 4/4] ARM: dts: sun7i: Add pin muxing options for clock
 outputs
In-Reply-To: <1388373949-28506-1-git-send-email-wens@csie.org>
References: <1388373949-28506-1-git-send-email-wens@csie.org>
Message-ID: <1388373949-28506-5-git-send-email-wens@csie.org>
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
index f255a49..7b46ce5 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -416,6 +416,20 @@
 				allwinner,drive = <0>;
 				allwinner,pull = <0>;
 			};
+
+			clk_out_a_pins: clk_out_a at 0 {
+				allwinner,pins = "PI12";
+				allwinner,function = "clk_out_a";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			clk_out_b_pins: clk_out_b at 0 {
+				allwinner,pins = "PI13";
+				allwinner,function = "clk_out_b";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		timer at 01c20c00 {
-- 
1.8.5.2
