From: ttynkkynen@nvidia.com (Tuomas Tynkkynen)
Date: Thu, 21 Aug 2014 00:04:42 +0300
Subject: [PATCH v4 14/16] ARM: tegra: Add entries for cpufreq on Tegra124
In-Reply-To: <1408568684-11016-1-git-send-email-ttynkkynen@nvidia.com>
References: <1408568684-11016-1-git-send-email-ttynkkynen@nvidia.com>
Message-ID: <1408568684-11016-15-git-send-email-ttynkkynen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Tegra124 cpufreq driver relies on certain clocks being present
in the /cpus/cpu at 0 node.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 608fa29..62f8778 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -829,10 +829,19 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0>;
+
+			clocks = <&tegra_car TEGRA124_CLK_CCLK_G>,
+				 <&tegra_car TEGRA124_CLK_CCLK_LP>,
+				 <&tegra_car TEGRA124_CLK_PLL_X>,
+				 <&tegra_car TEGRA124_CLK_PLL_P>,
+				 <&dfll>;
+			clock-names = "cpu_g", "cpu_lp", "pll_x", "pll_p", "dfll";
+			/* FIXME: what's the actual transition time? */
+			clock-latency = <300000>;
 		};
 
 		cpu at 1 {
-- 
1.8.1.5
