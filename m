From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 25 Apr 2016 16:38:47 -0300
Subject: [PATCH 1/2] ARM: dts: imx6ul: Fix operating points
Message-ID: <1461613128-24001-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Adjust the VDD_ARM_CAP and VDD_SOC_CAP voltages according to 
Table-11 from MX6UL datasheet:
http://cache.nxp.com/files/32bit/doc/data_sheet/IMX6ULCEC.pdf

(a 25mV offset is added to the minimum allowed values for safety).

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 7177899..4356b65 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -55,15 +55,15 @@
 			clock-latency = <61036>; /* two CLK32 periods */
 			operating-points = <
 				/* kHz	uV */
-				528000	1250000
-				396000	1150000
-				198000	1150000
+				528000	1175000
+				396000	1025000
+				198000	950000
 			>;
 			fsl,soc-operating-points = <
 				/* KHz	uV */
-				528000	1250000
-				396000	1150000
-				198000	1150000
+				528000	1175000
+				396000	1175000
+				198000	1175000
 			>;
 			clocks = <&clks IMX6UL_CLK_ARM>,
 				 <&clks IMX6UL_CLK_PLL2_BUS>,
-- 
1.9.1
