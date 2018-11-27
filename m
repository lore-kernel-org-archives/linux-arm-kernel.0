From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:04 +0100
Subject: [PATCH 03/77] ARM: dts: sun5i: Change framebuffer node names to avoid
 warnings
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <de87f16f4ed19e130aa451c82f8665e6cb484305.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The simple-framebuffer nodes have a unit address, but no reg property which
generates a warning when compiling it with DTC.

Change the simple-framebuffer node names so that there is no warnings on
this anymore.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 2 +-
 arch/arm/boot/dts/sun5i.dtsi      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 316cb8b2945b..7f76250f4228 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -60,7 +60,7 @@
 		#size-cells = <1>;
 		ranges;
 
-		framebuffer at 2 {
+		framebuffer-lcd0-hdmi {
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-hdmi";
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 9cd65c46720b..14a7d1cf89b4 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -68,7 +68,7 @@
 		#size-cells = <1>;
 		ranges;
 
-		framebuffer at 0 {
+		framebuffer-lcd0 {
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0";
@@ -77,7 +77,7 @@
 			status = "disabled";
 		};
 
-		framebuffer at 1 {
+		framebuffer-lcd0-tve0 {
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-tve0";
-- 
git-series 0.9.1
