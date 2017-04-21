From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 21 Apr 2017 16:38:57 +0800
Subject: [PATCH v2 9/9] ARM: dts: sun6i: Enable tcon0 by default
In-Reply-To: <20170421083857.29636-1-wens@csie.org>
References: <20170421083857.29636-1-wens@csie.org>
Message-ID: <20170421083857.29636-10-wens@csie.org>
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
index b4c87a23e3f8..55607208468b 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -319,7 +319,6 @@
 &tcon0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&lcd0_rgb888_pins>;
-	status = "okay";
 };
 
 &tcon0_out {
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index dfcf64515d7f..d0cede5aaeb5 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -264,7 +264,6 @@
 				      "tcon-ch0",
 				      "tcon-ch1";
 			clock-output-names = "tcon0-pixel-clock";
-			status = "disabled";
 
 			ports {
 				#address-cells = <1>;
-- 
2.11.0
