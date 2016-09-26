From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 26 Sep 2016 03:03:41 +0300
Subject: [PATCH v2 2/4] ARM: dts: imx31: move CCM device node to AIPS2 bus
 devices
In-Reply-To: <1474848223-19728-1-git-send-email-vz@mleia.com>
References: <1474848223-19728-1-git-send-email-vz@mleia.com>
Message-ID: <1474848223-19728-3-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX31 Clock Control Module controller is found on AIPS2 bus, move it
there from SPBA bus to avoid a conflict of device IO space mismatch.

Fixes: ef0e4a606fb6 ("ARM: mx31: Replace clk_register_clkdev with clock DT lookup")
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
Changes from v1 to v2:
* new change in the series

 arch/arm/boot/dts/imx31.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/imx31.dtsi
index 3e0893e..8d4c0e3 100644
--- a/arch/arm/boot/dts/imx31.dtsi
+++ b/arch/arm/boot/dts/imx31.dtsi
@@ -118,13 +118,6 @@
 				interrupts = <19>;
 				clocks = <&clks 25>;
 			};
-
-			clks: ccm at 53f80000{
-				compatible = "fsl,imx31-ccm";
-				reg = <0x53f80000 0x4000>;
-				interrupts = <31>, <53>;
-				#clock-cells = <1>;
-			};
 		};
 
 		aips at 53f00000 { /* AIPS2 */
@@ -134,6 +127,13 @@
 			reg = <0x53f00000 0x100000>;
 			ranges;
 
+			clks: ccm at 53f80000{
+				compatible = "fsl,imx31-ccm";
+				reg = <0x53f80000 0x4000>;
+				interrupts = <31>, <53>;
+				#clock-cells = <1>;
+			};
+
 			gpt: timer at 53f90000 {
 				compatible = "fsl,imx31-gpt";
 				reg = <0x53f90000 0x4000>;
-- 
2.8.1
