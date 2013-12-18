From: john.tobias.ph@gmail.com (John Tobias)
Date: Tue, 17 Dec 2013 17:17:28 -0800
Subject: [PATCH 1/4] iMX6SL frequency table
Message-ID: <1387329451-17480-1-git-send-email-john.tobias.ph@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    Device tree for iMX6SL doesn't have an existing cpu frequency table.

Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
---
 arch/arm/boot/dts/imx6sl.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 28558f1..0a2c73c 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -38,6 +38,20 @@
 			device_type = "cpu";
 			reg = <0x0>;
 			next-level-cache = <&L2>;
+			operating-points = <
+				/* kHz    uV */
+				996000  1250000 /* for consumer grade only */
+				792000  1150000
+				396000  1050000
+			>;
+			clock-latency = <61036>; /* two CLK32 periods */
+			clocks = <&clks IMX6SL_CLK_ARM>, <&clks IMX6SL_CLK_PLL2_PFD2>, <&clks IMX6SL_CLK_STEP>,
+				 <&clks IMX6SL_CLK_PLL1_SW>, <&clks IMX6SL_CLK_PLL1_SYS>;
+			clock-names = "arm", "pll2_pfd2_396m", "step",
+				      "pll1_sw", "pll1_sys";
+			arm-supply = <&reg_arm>;
+			pu-supply = <&reg_pu>;
+			soc-supply = <&reg_soc>;
 		};
 	};
 
-- 
1.8.3.2
