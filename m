From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  4 Dec 2017 16:44:01 +0800
Subject: [PATCH] ARM: dts: sunxi: Convert to CCU index macros for HDMI
 controller
Message-ID: <20171204084401.2646-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the HDMI controller device node was added, the needed PLL clock
macros were not exported. A separate patch addresses that, but it is
merged through a different tree.

Now that both patches are in mainline proper, we can convert the raw
numbers to proper macros.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

This is the remain bits of the HDMI series, converting raw index
numbers in the device tree to ccu macros. This is a fix for 4.15.
I've put all the platforms in one patch, though we should have done
sun5i for the previous release.

---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 4 ++--
 arch/arm/boot/dts/sun5i-a10s.dtsi | 4 ++--
 arch/arm/boot/dts/sun6i-a31.dtsi  | 4 ++--
 arch/arm/boot/dts/sun7i-a20.dtsi  | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index b91300d49a31..5840f5c75c3b 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -502,8 +502,8 @@
 			reg = <0x01c16000 0x1000>;
 			interrupts = <58>;
 			clocks = <&ccu CLK_AHB_HDMI0>, <&ccu CLK_HDMI>,
-				 <&ccu 9>,
-				 <&ccu 18>;
+				 <&ccu CLK_PLL_VIDEO0_2X>,
+				 <&ccu CLK_PLL_VIDEO1_2X>;
 			clock-names = "ahb", "mod", "pll-0", "pll-1";
 			dmas = <&dma SUN4I_DMA_NORMAL 16>,
 			       <&dma SUN4I_DMA_NORMAL 16>,
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 6ae4d95e230e..316cb8b2945b 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -82,8 +82,8 @@
 			reg = <0x01c16000 0x1000>;
 			interrupts = <58>;
 			clocks = <&ccu CLK_AHB_HDMI>, <&ccu CLK_HDMI>,
-				 <&ccu 9>,
-				 <&ccu 16>;
+				 <&ccu CLK_PLL_VIDEO0_2X>,
+				 <&ccu CLK_PLL_VIDEO1_2X>;
 			clock-names = "ahb", "mod", "pll-0", "pll-1";
 			dmas = <&dma SUN4I_DMA_NORMAL 16>,
 			       <&dma SUN4I_DMA_NORMAL 16>,
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 8bfa12b548e0..72d3fe44ecaf 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -429,8 +429,8 @@
 			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_AHB1_HDMI>, <&ccu CLK_HDMI>,
 				 <&ccu CLK_HDMI_DDC>,
-				 <&ccu 7>,
-				 <&ccu 13>;
+				 <&ccu CLK_PLL_VIDEO0_2X>,
+				 <&ccu CLK_PLL_VIDEO1_2X>;
 			clock-names = "ahb", "mod", "ddc", "pll-0", "pll-1";
 			resets = <&ccu RST_AHB1_HDMI>;
 			reset-names = "ahb";
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 68dfa82544fc..59655e42e4b0 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -581,8 +581,8 @@
 			reg = <0x01c16000 0x1000>;
 			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_AHB_HDMI0>, <&ccu CLK_HDMI>,
-				 <&ccu 9>,
-				 <&ccu 18>;
+				 <&ccu CLK_PLL_VIDEO0_2X>,
+				 <&ccu CLK_PLL_VIDEO1_2X>;
 			clock-names = "ahb", "mod", "pll-0", "pll-1";
 			dmas = <&dma SUN4I_DMA_NORMAL 16>,
 			       <&dma SUN4I_DMA_NORMAL 16>,
-- 
2.15.0
