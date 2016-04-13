From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Wed, 13 Apr 2016 10:12:03 +0530
Subject: [PATCH v2] arm64: dts: Add nodes for pdma0 and pdam1 for exynos7
Message-ID: <1460522523-7429-1-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree nodes for pdma0 and pdma1 controllers
found on exynos7 SoCs.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos7.dtsi |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index 93108f1..a1a3dba 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -95,6 +95,35 @@
 				<0x11006000 0x2000>;
 		};
 
+		amba {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			pdma0: pdma at 10E10000 {
+				compatible = "arm,pl330", "arm,primecell";
+				reg = <0x10E10000 0x1000>;
+				interrupts = <0 225 0>;
+				clocks = <&clock_fsys0 ACLK_PDMA0>;
+				clock-names = "apb_pclk";
+				#dma-cells = <1>;
+				#dma-channels = <8>;
+				#dma-requests = <32>;
+			};
+
+			pdma1: pdma at 10EB0000 {
+				compatible = "arm,pl330", "arm,primecell";
+				reg = <0x10EB0000 0x1000>;
+				interrupts = <0 226 0>;
+				clocks = <&clock_fsys0 ACLK_PDMA1>;
+				clock-names = "apb_pclk";
+				#dma-cells = <1>;
+				#dma-channels = <8>;
+				#dma-requests = <32>;
+			};
+		};
+
 		clock_topc: clock-controller at 10570000 {
 			compatible = "samsung,exynos7-clock-topc";
 			reg = <0x10570000 0x10000>;
-- 
1.7.10.4
