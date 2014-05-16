From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 16 May 2014 13:28:53 +0200
Subject: [PATCH] ARM: dts: Add audio subsystem nodes to exynos4.dtsi
Message-ID: <1400239733-11782-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the audio subsystem clock controller and the I2S
IP block nodes for Exynos4 SoC series.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 58ff8e2..0eb768c 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -20,6 +20,7 @@
  */

 #include <dt-bindings/clock/exynos4.h>
+#include <dt-bindings/clock/exynos-audss-clk.h>
 #include "skeleton.dtsi"

 / {
@@ -45,6 +46,23 @@
 		fimc3 = &fimc_3;
 	};

+	clock_audss: clock-controller at 03810000 {
+		compatible = "samsung,exynos4210-audss-clock";
+		reg = <0x03810000 0x0C>;
+		#clock-cells = <1>;
+	};
+
+	i2s0: i2s at 03830000 {
+		compatible = "samsung,s5pv210-i2s";
+		reg = <0x03830000 0x100>;
+		clocks = <&clock_audss EXYNOS_I2S_BUS>;
+		clock-names = "iis";
+		dmas = <&pdma0 12>, <&pdma0 11>, <&pdma0 10>;
+		dma-names = "tx", "rx", "tx-sec";
+		samsung,idma-addr = <0x03000000>;
+		status = "disabled";
+	};
+
 	chipid at 10000000 {
 		compatible = "samsung,exynos4210-chipid";
 		reg = <0x10000000 0x100>;
@@ -289,6 +307,26 @@
 		status = "disabled";
 	};

+	i2s1: i2s at 13960000 {
+		compatible = "samsung,s5pv210-i2s";
+		reg = <0x13960000 0x100>;
+		clocks = <&clock CLK_I2S1>;
+		clock-names = "iis";
+		dmas = <&pdma1 12>, <&pdma1 11>;
+		dma-names = "tx", "rx";
+		status = "disabled";
+	};
+
+	i2s2: i2s at 13970000 {
+		compatible = "samsung,s5pv210-i2s";
+		reg = <0x13970000 0x100>;
+		clocks = <&clock CLK_I2S2>;
+		clock-names = "iis";
+		dmas = <&pdma0 14>, <&pdma0 13>;
+		dma-names = "tx", "rx";
+		status = "disabled";
+	};
+
 	mfc: codec at 13400000 {
 		compatible = "samsung,mfc-v5";
 		reg = <0x13400000 0x10000>;
--
1.7.9.5
