From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  9 Mar 2017 18:05:34 +0800
Subject: [PATCH 11/11] ARM: dts: sun6i: Enable tcon0 by default
In-Reply-To: <20170309100534.14023-1-wens@csie.org>
References: <20170309100534.14023-1-wens@csie.org>
Message-ID: <20170309100534.14023-12-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tcon0 contains a muxing register used to mux tcon output to downstream
hdmi or mipi dsi encoders. tcon0 must be available for the mux to be
configured.

Whether the display subsystem is enabled or not is now solely controlled
by the display-engine node.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 1 -
 arch/arm/boot/dts/sun6i-a31.dtsi            | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index f094eeb6c499..fb237ce60198 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -320,7 +320,6 @@
 &tcon0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&lcd0_rgb888_pins>;
-	status = "okay";
 };
 
 &tcon0_out {
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 40f020824ccc..0ddcffab594e 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -265,7 +265,6 @@
 				      "tcon-ch0",
 				      "tcon-ch1";
 			clock-output-names = "tcon0-pixel-clock";
-			status = "disabled";
 
 			ports {
 				#address-cells = <1>;
-- 
2.11.0
