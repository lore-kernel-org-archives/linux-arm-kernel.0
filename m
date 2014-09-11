From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 11 Sep 2014 22:18:20 +0200
Subject: [PATCH v3 06/12] ARM: sunxi: dt: Switch to the new mbus compatible
In-Reply-To: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1410466706-27386-7-git-send-email-maxime.ripard@free-electrons.com>
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
index a96b99465069..82097c905c48 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -382,7 +382,7 @@
 
 		mbus_clk: clk at 01c2015c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			compatible = "allwinner,sun5i-a13-mbus-clk";
 			reg = <0x01c2015c 0x4>;
 			clocks = <&osc24M>, <&pll6 2>, <&pll5 1>;
 			clock-output-names = "mbus";
-- 
2.1.0
