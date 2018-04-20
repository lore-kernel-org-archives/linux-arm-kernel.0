From: dev@pascalroeleven.nl (Pascal Roeleven)
Date: Fri, 20 Apr 2018 11:18:10 +0200
Subject: [PATCH] ARM: dts: sun4i: Fix incorrect clocks for displays
Message-ID: <20180420091810.2130-1-dev@pascalroeleven.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some displays on SUN4i devices wouldn't properly stay on unless 'clk_ignore_unused' is used.

Change the duplicate clocks to the probably intended ones.

Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 77e8436b..3a1c6b45 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -76,7 +76,7 @@
 			allwinner,pipeline = "de_fe0-de_be0-lcd0-hdmi";
 			clocks = <&ccu CLK_AHB_LCD0>, <&ccu CLK_AHB_HDMI0>,
 				 <&ccu CLK_AHB_DE_BE0>, <&ccu CLK_AHB_DE_FE0>,
-				 <&ccu CLK_DE_BE0>, <&ccu CLK_AHB_DE_FE0>,
+				 <&ccu CLK_DE_BE0>, <&ccu CLK_DE_FE0>,
 				 <&ccu CLK_TCON0_CH1>, <&ccu CLK_HDMI>,
 				 <&ccu CLK_DRAM_DE_FE0>, <&ccu CLK_DRAM_DE_BE0>;
 			status = "disabled";
@@ -88,7 +88,7 @@
 			allwinner,pipeline = "de_fe0-de_be0-lcd0";
 			clocks = <&ccu CLK_AHB_LCD0>, <&ccu CLK_AHB_DE_BE0>,
 				 <&ccu CLK_AHB_DE_FE0>, <&ccu CLK_DE_BE0>,
-				 <&ccu CLK_AHB_DE_FE0>, <&ccu CLK_TCON0_CH0>,
+				 <&ccu CLK_DE_FE0>, <&ccu CLK_TCON0_CH0>,
 				 <&ccu CLK_DRAM_DE_FE0>, <&ccu CLK_DRAM_DE_BE0>;
 			status = "disabled";
 		};
@@ -99,7 +99,7 @@
 			allwinner,pipeline = "de_fe0-de_be0-lcd0-tve0";
 			clocks = <&ccu CLK_AHB_TVE0>, <&ccu CLK_AHB_LCD0>,
 				 <&ccu CLK_AHB_DE_BE0>, <&ccu CLK_AHB_DE_FE0>,
-				 <&ccu CLK_DE_BE0>, <&ccu CLK_AHB_DE_FE0>,
+				 <&ccu CLK_DE_BE0>, <&ccu CLK_DE_FE0>,
 				 <&ccu CLK_TCON0_CH1>, <&ccu CLK_DRAM_TVE0>,
 				 <&ccu CLK_DRAM_DE_FE0>, <&ccu CLK_DRAM_DE_BE0>;
 			status = "disabled";
-- 
2.14.1
