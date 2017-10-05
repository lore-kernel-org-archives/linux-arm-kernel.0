From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  5 Oct 2017 12:49:38 +0200
Subject: [PATCH 03/20] ARM: dts: sun4i: Change framebuffer node names to avoid
 warnings
In-Reply-To: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <a7a00cff95247b2c240473a1a7bacb2bc49db9fd.1507198895.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The simple-framebuffer nodes have a unit address, but no reg property which
generates a warning when compiling it with DTC.

Change the simple-framebuffer node names so that there is no warnings on
this anymore.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 82d4ab6fbbcd..442d46e7cc8b 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -60,7 +60,7 @@
 		#size-cells = <1>;
 		ranges;
 
-		framebuffer at 0 {
+		framebuffer-lcd0-hdmi {
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-hdmi";
@@ -70,7 +70,7 @@
 			status = "disabled";
 		};
 
-		framebuffer at 1 {
+		framebuffer-fe0-lcd0-hdmi {
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_fe0-de_be0-lcd0-hdmi";
@@ -82,7 +82,7 @@
 			status = "disabled";
 		};
 
-		framebuffer at 2 {
+		framebuffer-fe0-lcd0 {
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_fe0-de_be0-lcd0";
@@ -93,7 +93,7 @@
 			status = "disabled";
 		};
 
-		framebuffer at 3 {
+		framebuffer-fe0-lcd0-tve0 {
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_fe0-de_be0-lcd0-tve0";
-- 
git-series 0.9.1
