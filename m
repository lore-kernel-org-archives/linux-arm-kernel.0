From: pchiu@nvidia.com (Penny Chiu)
Date: Fri, 22 Apr 2016 18:31:10 +0800
Subject: [PATCH 10/11] arm64: tegra: Add clock properties on cpu0 for Tegra210
In-Reply-To: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
References: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
Message-ID: <1461321071-6431-11-git-send-email-pchiu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clocks, clock-names, and clock-latency into cpu0 node.
These properties will be used by cpufreq driver.

Signed-off-by: Penny Chiu <pchiu@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 204d9cd..1a85857 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -782,6 +782,12 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a57";
 			reg = <0>;
+			clocks = <&tegra_car TEGRA210_CLK_CCLK_G>,
+				 <&tegra_car TEGRA210_CLK_PLL_X>,
+				 <&tegra_car TEGRA210_CLK_PLL_P_OUT4>,
+				 <&dfll>;
+			clock-names = "cpu_g", "pll_x", "pll_p", "dfll";
+			clock-latency = <300000>;
 		};
 
 		cpu at 1 {
-- 
2.8.1
