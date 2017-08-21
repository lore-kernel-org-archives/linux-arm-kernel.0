From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Mon, 21 Aug 2017 20:55:04 +0900
Subject: [PATCH] arm64: dts: uniphier: add reset controller node of analog
 amplifier
Message-ID: <20170821115504.27276-1-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds reset controller node of analog signal amplifier
core (ADAMV) for UniPhier LD11/LD20 SoCs.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 11 +++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index bdce5b89baec..35ffea71bc55 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -150,6 +150,17 @@
 			clocks = <&peri_clk 3>;
 		};
 
+		adamv at 57920000 {
+			compatible = "socionext,uniphier-ld11-adamv",
+				     "simple-mfd", "syscon";
+			reg = <0x57920000 0x1000>;
+
+			adamv_rst: reset {
+				compatible = "socionext,uniphier-ld11-adamv-reset";
+				#reset-cells = <1>;
+			};
+		};
+
 		i2c0: i2c at 58780000 {
 			compatible = "socionext,uniphier-fi2c";
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index de1e75362817..b21b8bf523ff 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -219,6 +219,17 @@
 			clocks = <&peri_clk 3>;
 		};
 
+		adamv at 57920000 {
+			compatible = "socionext,uniphier-ld20-adamv",
+				     "simple-mfd", "syscon";
+			reg = <0x57920000 0x1000>;
+
+			adamv_rst: reset {
+				compatible = "socionext,uniphier-ld20-adamv-reset";
+				#reset-cells = <1>;
+			};
+		};
+
 		i2c0: i2c at 58780000 {
 			compatible = "socionext,uniphier-fi2c";
 			status = "disabled";
-- 
2.13.2
