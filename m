From: b20788@freescale.com (Anson Huang)
Date: Thu, 19 Dec 2013 10:02:10 -0500
Subject: [PATCH] ARM: imx: enable cpufreq for i.mx6dl
Message-ID: <1387465330-15667-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds cpufreq dts for i.mx6dl to support cpufreq driver.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/boot/dts/imx6dl.dtsi |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index b2f2699..e2ec0fb 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -23,6 +23,26 @@
 			device_type = "cpu";
 			reg = <0>;
 			next-level-cache = <&L2>;
+			operating-points = <
+				/* kHz    uV */
+				996000  1275000
+				792000  1175000
+				396000  1075000
+			>;
+			fsl,soc-operating-points = <
+				/* ARM kHz  SOC-PU uV */
+				996000	1175000
+				792000	1175000
+				396000	1175000
+			>;
+			clock-latency = <61036>; /* two CLK32 periods */
+			clocks = <&clks 104>, <&clks 6>, <&clks 16>,
+				 <&clks 17>, <&clks 170>;
+			clock-names = "arm", "pll2_pfd2_396m", "step",
+				      "pll1_sw", "pll1_sys";
+			arm-supply = <&reg_arm>;
+			pu-supply = <&reg_pu>;
+			soc-supply = <&reg_soc>;
 		};
 
 		cpu at 1 {
-- 
1.7.9.5
