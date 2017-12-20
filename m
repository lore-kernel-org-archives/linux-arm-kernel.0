From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 20 Dec 2017 20:27:01 +0100
Subject: [PATCH 1/2] arm64: dts: exynos: Use lower case hex addresses in node
 unit addresses
Message-ID: <20171220192702.32515-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert all hex addresses in node unit addresses to lower case to
fix warnings like:
    arch/arm64/boot/dts/exynos/exynos5433-tm2e.dtb: Warning (simple_bus_reg):
      Node /soc/video-scaler at 13C00000 simple-bus unit address format error, expected "13c00000"

Conversion was done using sed:
    $ sed -e 's/@\([a-zA-Z0-9_-]*\) {/@\L\1 {/' -i arch/arm64/boot/dts/exynos/*.dts*

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 8 ++++----
 arch/arm64/boot/dts/exynos/exynos7.dtsi    | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 1962b8074349..0ba5df825eff 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -994,7 +994,7 @@
 			reg = <0x145f0000 0x1038>;
 		};
 
-		gsc_0: video-scaler at 13C00000 {
+		gsc_0: video-scaler at 13c00000 {
 			compatible = "samsung,exynos5433-gsc";
 			reg = <0x13c00000 0x1000>;
 			interrupts = <GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH>;
@@ -1008,7 +1008,7 @@
 			power-domains = <&pd_gscl>;
 		};
 
-		gsc_1: video-scaler at 13C10000 {
+		gsc_1: video-scaler at 13c10000 {
 			compatible = "samsung,exynos5433-gsc";
 			reg = <0x13c10000 0x1000>;
 			interrupts = <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>;
@@ -1022,7 +1022,7 @@
 			power-domains = <&pd_gscl>;
 		};
 
-		gsc_2: video-scaler at 13C20000 {
+		gsc_2: video-scaler at 13c20000 {
 			compatible = "samsung,exynos5433-gsc";
 			reg = <0x13c20000 0x1000>;
 			interrupts = <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>;
@@ -1049,7 +1049,7 @@
 			power-domains = <&pd_mscl>;
 		};
 
-		mfc: codec at 152E0000 {
+		mfc: codec at 152e0000 {
 			compatible = "samsung,exynos5433-mfc";
 			reg = <0x152E0000 0x10000>;
 			interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index 9a3fbed1765a..3504837b1d43 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -103,7 +103,7 @@
 			#size-cells = <1>;
 			ranges;
 
-			pdma0: pdma at 10E10000 {
+			pdma0: pdma at 10e10000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0x10E10000 0x1000>;
 				interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
@@ -114,7 +114,7 @@
 				#dma-requests = <32>;
 			};
 
-			pdma1: pdma at 10EB0000 {
+			pdma1: pdma at 10eb0000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0x10EB0000 0x1000>;
 				interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.11.0
