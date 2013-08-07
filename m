From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 07 Aug 2013 14:40:11 +0530
Subject: [PATCH V3 2/7] ARM: dts: exynos5420: add i2s controllers
In-Reply-To: <1375866616-5541-1-git-send-email-padma.v@samsung.com>
References: <1375866616-5541-1-git-send-email-padma.v@samsung.com>
Message-ID: <1375866616-5541-3-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Bresticker <abrestic@chromium.org>

This adds device-tree bindings for the i2s controllers on Exynos 5420.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
Reviewed-on: https://gerrit.chromium.org/gerrit/57713
---
 arch/arm/boot/dts/exynos5420.dtsi |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index c2a2bd6..286354e 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -242,4 +242,36 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c3_bus>;
 	};
+
+	i2s_0: i2s at 03830000 {
+		compatible = "samsung,exynos5420-i2s";
+		dmas = <&adma 0
+			&adma 2
+			&adma 1>;
+		dma-names = "tx", "rx", "tx-sec";
+		clocks = <&clock_audss EXYNOS_I2S_BUS>,
+			<&clock_audss EXYNOS_I2S_BUS>,
+			<&clock_audss EXYNOS_SCLK_I2S>;
+		clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s0_bus>;
+		status = "disabled";
+	};
+
+	i2s_1: i2s at 12D60000 {
+		clocks = <&clock 275>, <&clock 138>;
+		clock-names = "iis", "i2s_opclk0";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s1_bus>;
+		status = "disabled";
+	};
+
+	i2s_2: i2s at 12D70000 {
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
