From: rrajk@nvidia.com (Rajkumar Rampelli)
Date: Wed, 21 Feb 2018 12:28:59 +0530
Subject: [PATCH 10/10] arm64: tegra: Add PWM controller on Tegra186 soc
In-Reply-To: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
References: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
Message-ID: <1519196339-9377-11-git-send-email-rrajk@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NVIDIA Tegra186 SoC has a PWM controller which is
used in FAN control use case.

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 37149e9..c6f154e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -1032,6 +1032,17 @@
 		interrupt-parent = <&gic>;
 	};
 
+	pwm at c340000 {
+		compatible = "nvidia,tegra186-pwm";
+		reg = <0x0 0xc340000 0x0 0x10000>;
+		clocks = <&bpmp TEGRA186_CLK_PWM4>;
+		clock-names = "pwm";
+		#pwm-cells = <2>;
+		resets = <&bpmp TEGRA186_RESET_PWM4>;
+		reset-names = "pwm";
+		status = "disabled";
+	};
+
 	tegra_tachometer: tachometer at 39c0000 {
 		compatible = "nvidia,tegra186-pwm-tachometer";
 		reg = <0x0 0x039c0000 0x0 0x10>;
-- 
2.1.4
