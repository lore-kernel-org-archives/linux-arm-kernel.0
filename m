From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 26 Jul 2013 19:06:50 +0530
Subject: [PATCH V2 6/8] ARM: dts: exynos5420: add i2s controllers
In-Reply-To: <1374845812-7803-1-git-send-email-padma.v@samsung.com>
References: <1374845812-7803-1-git-send-email-padma.v@samsung.com>
Message-ID: <1374845812-7803-7-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Bresticker <abrestic@chromium.org>

This adds device-tree bindings for the i2s controllers on Exynos 5420.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
Reviewed-on: https://gerrit.chromium.org/gerrit/57713
---
 arch/arm/boot/dts/exynos5420.dtsi |   44 +++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index d2fdb87..c9ed8d2 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -242,4 +242,48 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c3_bus>;
 	};
+
+	i2s_0: i2s at 03830000 {
+		compatible = "samsung,exynos5420-i2s";
+		reg = <0x03830000 0x100>;
+		dmas = <&adma 0
+			&adma 2
+			&adma 1>;
+		dma-names = "tx", "rx", "tx-sec";
+		clocks = <&clock_audss EXYNOS_I2S_BUS>,
+			<&clock_audss EXYNOS_I2S_BUS>,
+			<&clock_audss EXYNOS_SCLK_I2S>;
+		clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
+		samsung,idma-addr = <0x03000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s0_bus>;
+		status = "disabled";
+	};
+
+	i2s_1: i2s at 12D60000 {
+		compatible = "samsung,s3c6410-i2s";
+		reg = <0x12D60000 0x100>;
+		dmas = <&pdma1 12
+			&pdma1 11>;
+		dma-names = "tx", "rx";
+		clocks = <&clock 275>, <&clock 138>;
+		clock-names = "iis", "i2s_opclk0";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s1_bus>;
+		status = "disabled";
+	};
+
+	i2s_2: i2s at 12D70000 {
+		compatible = "samsung,s3c6410-i2s";
+		reg = <0x12D70000 0x100>;
+		dmas = <&pdma0 12
+			&pdma0 11>;
+		dma-names = "tx", "rx";
+		clocks = <&clock 276>, <&clock 139>;
+		clock-names = "iis", "i2s_opclk0";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s2_bus>;
+		status = "disabled";
+	};
+
 };
-- 
1.7.4.4
