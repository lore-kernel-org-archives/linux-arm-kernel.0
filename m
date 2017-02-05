From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  5 Feb 2017 19:49:38 +0100
Subject: [PATCH 2/9] ARM: sun5i: a10s: switch simple framebuffer indices
In-Reply-To: <cover.8519ab0b2252458a322bea5955d191e63f67100b.1486320544.git-series.maxime.ripard@free-electrons.com>
References: <cover.8519ab0b2252458a322bea5955d191e63f67100b.1486320544.git-series.maxime.ripard@free-electrons.com>
Message-ID: <5f1f3913705fecab150e11be06b4e560fe2865e2.1486320544.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Of the three simple framebuffer setups we have in the A10s, two of them can
be shared with the other SoCs from the sun5i family (LCD panel and
composite output).

However, the only one we cannot share is the HDMI, which is the first
listed in the A10s DTSI. In order to make it more logical and so that we
can share the framebuffer nodes in the common DTSI, reorder those nodes.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index df2ba63d4ff9..0c08b6173d9c 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -61,7 +61,7 @@
 		#size-cells = <1>;
 		ranges;
 
-		framebuffer at 0 {
+		framebuffer at 2 {
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-hdmi";
@@ -71,7 +71,7 @@
 			status = "disabled";
 		};
 
-		framebuffer at 1 {
+		framebuffer at 0 {
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0";
@@ -80,7 +80,7 @@
 			status = "disabled";
 		};
 
-		framebuffer at 2 {
+		framebuffer at 1 {
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-tve0";
-- 
git-series 0.8.11
