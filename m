From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 26 May 2014 12:15:08 +0200
Subject: [PATCH 4/4] ARM: imx53: add basic cpufreq properties to dtsi
In-Reply-To: <1401099308-9658-1-git-send-email-l.stach@pengutronix.de>
References: <1401099308-9658-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1401099308-9658-4-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only thing missing is the vddgp regulator, which is board
specific.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx53.dtsi | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index b57ab57740f6..8f005919cf6c 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -45,10 +45,24 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a8";
 			reg = <0x0>;
+			clocks = <&clks IMX5_CLK_CPU_PODF>,
+			         <&clks IMX5_CLK_PLL1_SW>,
+			         <&clks IMX5_CLK_STEP_SEL>,
+			         <&clks IMX5_CLK_LP_APM>;
+			clock-names = "cpu", "pll1", "step", "lp_apm";
+			vddgp-supply-max-microvolt = <1400000>;
+			operating-points = <
+				/* kHz     uV */
+				 166666  850000
+				 400000  900000
+				 800000 1050000
+				1000000 1200000
+				1200000 1300000
+			>;
 		};
 	};
 
-- 
2.0.0.rc2
