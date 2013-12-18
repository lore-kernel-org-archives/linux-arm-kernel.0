From: john.tobias.ph@gmail.com (John Tobias)
Date: Wed, 18 Dec 2013 15:50:53 -0800
Subject: [PATCH 1/4] ARM: dts: imx6sl: Adding cpu frequency table
Message-ID: <1387410656-36053-1-git-send-email-john.tobias.ph@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device tree for iMX6SL doesn't have an existing cpu frequency table.

Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
---
 arch/arm/boot/dts/imx6sl.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 28558f1..473d54b 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -38,6 +38,21 @@
 			device_type = "cpu";
 			reg = <0x0>;
 			next-level-cache = <&L2>;
+			operating-points = <
+				/* kHz    uV */
+				996000  1275000
+				792000  1175000
+				396000  975000
+			>;
+			clock-latency = <61036>; /* two CLK32 periods */
+			clocks = <&clks IMX6SL_CLK_ARM>, <&clks IMX6SL_CLK_PLL2_PFD2>,
+					<&clks IMX6SL_CLK_STEP>, <&clks IMX6SL_CLK_PLL1_SW>,
+					<&clks IMX6SL_CLK_PLL1_SYS>;
+			clock-names = "arm", "pll2_pfd2_396m", "step",
+				      "pll1_sw", "pll1_sys";
+			arm-supply = <&reg_arm>;
+			pu-supply = <&reg_pu>;
+			soc-supply = <&reg_soc>;
 		};
 	};
 
-- 
1.8.3.2
