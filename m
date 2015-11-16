From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Nov 2015 00:38:25 +0800
Subject: [PATCH v3 6/9] ARM: dts: sun8i: Add simplefb node labels to reference
 at board level
In-Reply-To: <1447691908-25456-1-git-send-email-wens@csie.org>
References: <1447691908-25456-1-git-send-email-wens@csie.org>
Message-ID: <1447691908-25456-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some boards, such as tablets, have regulators providing power to parts
of the display pipeline, like signal converters and LCD panels.

Add labels to the simplefb device nodes so that we can reference them
in the board dts files to add regulator supply properties.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 0c0964d4fa1f..6f88fb0ddbc7 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -56,7 +56,7 @@
 		#size-cells = <1>;
 		ranges;
 
-		framebuffer at 0 {
+		simplefb_lcd: framebuffer at 0 {
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0";
-- 
2.6.2
