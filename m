From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 30 Aug 2014 22:03:05 +0200
Subject: [PATCH v2 06/12] ARM: sunxi: dt: Switch to the new mbus compatible
In-Reply-To: <1409428991-2442-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1409428991-2442-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1409428991-2442-7-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a compatible of its own for the mbus clock, switch to it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi  | 2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index d73a2287b37a..531272c0e526 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -287,7 +287,7 @@
 
 		mbus_clk: clk at 01c2015c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			compatible = "allwinner,sun5i-a13-mbus-clk";
 			reg = <0x01c2015c 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mbus";
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index c4b5d7825b9f..b131068f4f35 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -285,7 +285,7 @@
 
 		mbus_clk: clk at 01c2015c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			compatible = "allwinner,sun5i-a13-mbus-clk";
 			reg = <0x01c2015c 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mbus";
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index c658e343ce11..ec5603da595e 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -346,7 +346,7 @@
 
 		mbus_clk: clk at 01c2015c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			compatible = "allwinner,sun5i-a13-mbus-clk";
 			reg = <0x01c2015c 0x4>;
 			clocks = <&osc24M>, <&pll6 2>, <&pll5 1>;
 			clock-output-names = "mbus";
-- 
2.0.2
