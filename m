From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 12 Feb 2016 17:31:15 +0800
Subject: [PATCH v2 2/2] ARM: dts: sun9i: Fix apbs clock compatible
In-Reply-To: <1455269475-8180-1-git-send-email-wens@csie.org>
References: <1455269475-8180-1-git-send-email-wens@csie.org>
Message-ID: <1455269475-8180-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The APBS clock on A80 is not compatible with A23's APB0 clock. The only
reason it works is becase the lowest and default divider is the same.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index f68b3242b33a..2b4ce813b0ad 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -395,7 +395,7 @@
 		};
 
 		apbs: clk at 0800141c {
-			compatible = "allwinner,sun8i-a23-apb0-clk";
+			compatible = "allwinner,sun9i-a80-apbs-clk";
 			reg = <0x0800141c 0x4>;
 			#clock-cells = <0>;
 			clocks = <&ahbs>;
-- 
2.7.0
