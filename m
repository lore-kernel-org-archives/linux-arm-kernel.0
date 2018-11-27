From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:24 +0100
Subject: [PATCH 23/77] ARM: dts: sun6i: Change framebuffer node names to avoid
 warnings
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <92add4869d5738cf12766e3ca7ee379d3177397b.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The simple-framebuffer nodes have a unit address, but no reg property which
generates a warning when compiling it with DTC.

Change the simple-framebuffer node names so that there is no warnings on
this anymore.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index b60aaacbab5e..42a963975bde 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -62,7 +62,7 @@
 		#size-cells = <1>;
 		ranges;
 
-		simplefb_hdmi: framebuffer at 0 {
+		simplefb_hdmi: framebuffer-lcd0-hdmi {
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-hdmi";
@@ -73,7 +73,7 @@
 			status = "disabled";
 		};
 
-		simplefb_lcd: framebuffer at 1 {
+		simplefb_lcd: framebuffer-lcd0 {
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0";
-- 
git-series 0.9.1
