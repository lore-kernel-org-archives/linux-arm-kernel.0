From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:39 +0100
Subject: [PATCH 38/77] ARM: dts: sun7i: Change framebuffer node names to avoid
 warnings
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <bc7833d43f0e28c57ea3414ffe5692255ac1e7ad.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The simple-framebuffer nodes have a unit address, but no reg property which
generates a warning when compiling it with DTC.

Change the simple-framebuffer node names so that there is no warnings on
this anymore.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 9e84dcffc978..c5a6b7a65c52 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -62,7 +62,7 @@
 		#size-cells = <1>;
 		ranges;
 
-		framebuffer at 0 {
+		framebuffer-lcd0-hdmi {
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-hdmi";
@@ -73,7 +73,7 @@
 			status = "disabled";
 		};
 
-		framebuffer at 1 {
+		framebuffer-lcd0 {
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0";
@@ -83,7 +83,7 @@
 			status = "disabled";
 		};
 
-		framebuffer at 2 {
+		framebuffer-lcd0-tve0 {
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-tve0";
-- 
git-series 0.9.1
