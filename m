From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 24 Oct 2018 17:33:52 +0200
Subject: [PATCH 1/2] arm64: tegra: Add PWM controllers on Tegra194
Message-ID: <20181024153353.15745-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Tegra194 has eight single-channel PWM controllers, one of them in the
AON partition.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 96 ++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 9fc14bb9a0af..c2091bb16546 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -209,6 +209,90 @@
 			status = "disabled";
 		};
 
+		pwm1: pwm at 3280000 {
+			compatible = "nvidia,tegra194-pwm",
+				     "nvidia,tegra186-pwm";
+			reg = <0x3280000 0x10000>;
+			clocks = <&bpmp TEGRA194_CLK_PWM1>;
+			clock-names = "pwm";
+			resets = <&bpmp TEGRA194_RESET_PWM1>;
+			reset-names = "pwm";
+			status = "disabled";
+			#pwm-cells = <2>;
+		};
+
+		pwm2: pwm at 3290000 {
+			compatible = "nvidia,tegra194-pwm",
+				     "nvidia,tegra186-pwm";
+			reg = <0x3290000 0x10000>;
+			clocks = <&bpmp TEGRA194_CLK_PWM2>;
+			clock-names = "pwm";
+			resets = <&bpmp TEGRA194_RESET_PWM2>;
+			reset-names = "pwm";
+			status = "disabled";
+			#pwm-cells = <2>;
+		};
+
+		pwm3: pwm at 32a0000 {
+			compatible = "nvidia,tegra194-pwm",
+				     "nvidia,tegra186-pwm";
+			reg = <0x32a0000 0x10000>;
+			clocks = <&bpmp TEGRA194_CLK_PWM3>;
+			clock-names = "pwm";
+			resets = <&bpmp TEGRA194_RESET_PWM3>;
+			reset-names = "pwm";
+			status = "disabled";
+			#pwm-cells = <2>;
+		};
+
+		pwm5: pwm at 32c0000 {
+			compatible = "nvidia,tegra194-pwm",
+				     "nvidia,tegra186-pwm";
+			reg = <0x32c0000 0x10000>;
+			clocks = <&bpmp TEGRA194_CLK_PWM5>;
+			clock-names = "pwm";
+			resets = <&bpmp TEGRA194_RESET_PWM5>;
+			reset-names = "pwm";
+			status = "disabled";
+			#pwm-cells = <2>;
+		};
+
+		pwm6: pwm at 32d0000 {
+			compatible = "nvidia,tegra194-pwm",
+				     "nvidia,tegra186-pwm";
+			reg = <0x32d0000 0x10000>;
+			clocks = <&bpmp TEGRA194_CLK_PWM6>;
+			clock-names = "pwm";
+			resets = <&bpmp TEGRA194_RESET_PWM6>;
+			reset-names = "pwm";
+			status = "disabled";
+			#pwm-cells = <2>;
+		};
+
+		pwm7: pwm at 32e0000 {
+			compatible = "nvidia,tegra194-pwm",
+				     "nvidia,tegra186-pwm";
+			reg = <0x32e0000 0x10000>;
+			clocks = <&bpmp TEGRA194_CLK_PWM7>;
+			clock-names = "pwm";
+			resets = <&bpmp TEGRA194_RESET_PWM7>;
+			reset-names = "pwm";
+			status = "disabled";
+			#pwm-cells = <2>;
+		};
+
+		pwm8: pwm at 32f0000 {
+			compatible = "nvidia,tegra194-pwm",
+				     "nvidia,tegra186-pwm";
+			reg = <0x32f0000 0x10000>;
+			clocks = <&bpmp TEGRA194_CLK_PWM8>;
+			clock-names = "pwm";
+			resets = <&bpmp TEGRA194_RESET_PWM8>;
+			reset-names = "pwm";
+			status = "disabled";
+			#pwm-cells = <2>;
+		};
+
 		sdmmc1: sdhci at 3400000 {
 			compatible = "nvidia,tegra194-sdhci", "nvidia,tegra186-sdhci";
 			reg = <0x03400000 0x10000>;
@@ -313,6 +397,18 @@
 			status = "disabled";
 		};
 
+		pwm4: pwm at c340000 {
+			compatible = "nvidia,tegra194-pwm",
+				     "nvidia,tegra186-pwm";
+			reg = <0xc340000 0x10000>;
+			clocks = <&bpmp TEGRA194_CLK_PWM4>;
+			clock-names = "pwm";
+			resets = <&bpmp TEGRA194_RESET_PWM4>;
+			reset-names = "pwm";
+			status = "disabled";
+			#pwm-cells = <2>;
+		};
+
 		pmc at c360000 {
 			compatible = "nvidia,tegra194-pmc";
 			reg = <0x0c360000 0x10000>,
-- 
2.19.1
