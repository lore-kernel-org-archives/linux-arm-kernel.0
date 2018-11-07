From: anson.huang@nxp.com (Anson Huang)
Date: Wed, 7 Nov 2018 08:51:07 +0000
Subject: [PATCH] ARM: dts: imx6sx: specify proper clock for nodes with dummy
 clock
Message-ID: <1541580363-3968-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From i.MX6SX reference manual CCM chapter, KPP and
WDOGn use IPG clock as their clock, specify IPG
clock for KPP and WDOGn instead of DUMMY clock.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 84b7687..07ea7d9 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -558,7 +558,7 @@
 				compatible = "fsl,imx6sx-kpp", "fsl,imx21-kpp";
 				reg = <0x020b8000 0x4000>;
 				interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6SX_CLK_DUMMY>;
+				clocks = <&clks IMX6SX_CLK_IPG>;
 				status = "disabled";
 			};
 
@@ -566,14 +566,14 @@
 				compatible = "fsl,imx6sx-wdt", "fsl,imx21-wdt";
 				reg = <0x020bc000 0x4000>;
 				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6SX_CLK_DUMMY>;
+				clocks = <&clks IMX6SX_CLK_IPG>;
 			};
 
 			wdog2: wdog at 20c0000 {
 				compatible = "fsl,imx6sx-wdt", "fsl,imx21-wdt";
 				reg = <0x020c0000 0x4000>;
 				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6SX_CLK_DUMMY>;
+				clocks = <&clks IMX6SX_CLK_IPG>;
 				status = "disabled";
 			};
 
@@ -1270,7 +1270,7 @@
 				compatible = "fsl,imx6sx-wdt", "fsl,imx21-wdt";
 				reg = <0x02288000 0x4000>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6SX_CLK_DUMMY>;
+				clocks = <&clks IMX6SX_CLK_IPG>;
 				status = "disabled";
 			};
 
-- 
2.7.4
