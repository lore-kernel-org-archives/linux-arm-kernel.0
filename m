From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 19 Sep 2016 04:54:34 +0300
Subject: [PATCH] ARM: dts: imx31: fix clock control module interrupts
 description
Message-ID: <1474250074-11430-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The type of AVIC interrupt controller found on i.MX31 is one-cell,
namely 31 for CCM DVFS and 53 for CCM, however for clock control
module its interrupts are specified as 3-cells, fix it.

Fixes: ef0e4a606fb6 ("ARM: mx31: Replace clk_register_clkdev with clock DT lookup")
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 Documentation/devicetree/bindings/clock/imx31-clock.txt | 2 +-
 arch/arm/boot/dts/imx31.dtsi                            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/imx31-clock.txt b/Documentation/devicetree/bindings/clock/imx31-clock.txt
index 19df842..8163d56 100644
--- a/Documentation/devicetree/bindings/clock/imx31-clock.txt
+++ b/Documentation/devicetree/bindings/clock/imx31-clock.txt
@@ -77,7 +77,7 @@ Examples:
 clks: ccm at 53f80000{
 	compatible = "fsl,imx31-ccm";
 	reg = <0x53f80000 0x4000>;
-	interrupts = <0 31 0x04 0 53 0x04>;
+	interrupts = <31>, <53>;
 	#clock-cells = <1>;
 };
 
diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/imx31.dtsi
index 1ce7ae9..3e0893e 100644
--- a/arch/arm/boot/dts/imx31.dtsi
+++ b/arch/arm/boot/dts/imx31.dtsi
@@ -122,7 +122,7 @@
 			clks: ccm at 53f80000{
 				compatible = "fsl,imx31-ccm";
 				reg = <0x53f80000 0x4000>;
-				interrupts = <0 31 0x04 0 53 0x04>;
+				interrupts = <31>, <53>;
 				#clock-cells = <1>;
 			};
 		};
-- 
2.8.1
