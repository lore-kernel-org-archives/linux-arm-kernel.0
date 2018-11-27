From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:58 +0100
Subject: [PATCH 57/77] ARM: dts: sun8i: a23/a33: Change framebuffer node names
 to avoid warnings
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <5581c89e3dc87081d16f869b0340cc5d62865965.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The simple-framebuffer nodes have a unit address, but no reg property which
generates a warning when compiling it with DTC.

Change the simple-framebuffer node names so that there is no warnings on
this anymore.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 5d79860bef88..b76b88a45e99 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -57,7 +57,7 @@
 		#size-cells = <1>;
 		ranges;
 
-		simplefb_lcd: framebuffer at 0 {
+		simplefb_lcd: framebuffer-lcd0 {
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0";
-- 
git-series 0.9.1
