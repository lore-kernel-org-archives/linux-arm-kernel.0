From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Tue, 20 Mar 2018 11:48:23 +0900
Subject: [PATCH v2 1/2] arm64: dts: uniphier: add syscon property for UniPhier
 sound system
Message-ID: <20180320024824.28902-1-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds syscon property for specifying soc-glue core into
device-tree of LD11/LD20 SoC.

Currently, soc-glue core is used for changing the state of S/PDIF
signal output pin to signal output state or Hi-Z state.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 3 ++-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index efa95573b2aa..e62bda1cf2d9 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -197,6 +197,7 @@
 			reset-names = "aio";
 			resets = <&sys_rst 40>;
 			#sound-dai-cells = <1>;
+			socionext,syscon = <&soc_glue>;
 
 			i2s_port0: port at 0 {
 				i2s_hdmi: endpoint {
@@ -479,7 +480,7 @@
 			};
 		};
 
-		soc-glue at 5f800000 {
+		soc_glue: soc-glue at 5f800000 {
 			compatible = "socionext,uniphier-ld11-soc-glue",
 				     "simple-mfd", "syscon";
 			reg = <0x5f800000 0x2000>;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 19c935688a77..9efe20d07589 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -297,6 +297,7 @@
 			reset-names = "aio";
 			resets = <&sys_rst 40>;
 			#sound-dai-cells = <1>;
+			socionext,syscon = <&soc_glue>;
 
 			i2s_port0: port at 0 {
 				i2s_hdmi: endpoint {
@@ -525,7 +526,7 @@
 			cdns,phy-dll-delay-sdclk-hsmmc = <21>;
 		};
 
-		soc-glue at 5f800000 {
+		soc_glue: soc-glue at 5f800000 {
 			compatible = "socionext,uniphier-ld20-soc-glue",
 				     "simple-mfd", "syscon";
 			reg = <0x5f800000 0x2000>;
-- 
2.16.2
