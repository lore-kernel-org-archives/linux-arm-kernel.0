From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 25 Apr 2018 16:50:40 +0200
Subject: [PATCH 2/2] arm: dts: imx[35]*: declare flexcan devices to be
 compatible to imx25's flexcan
In-Reply-To: <20180425145040.22031-1-u.kleine-koenig@pengutronix.de>
References: <20180425145040.22031-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20180425145040.22031-3-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit d50f4630c2e1 ("arm: dts: Remove p1010-flexcan compatible from imx
series dts") removed the fallback compatible "fsl,p1010-flexcan" from
the imx device trees. As the flexcan cores on i.MX25, i.MX35 and i.MX53
are identical, introduce the first as fallback for the two latter ones.

Fixes: d50f4630c2e1 ("arm: dts: Remove p1010-flexcan compatible from imx series dts")
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/imx35.dtsi | 4 ++--
 arch/arm/boot/dts/imx53.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index bf343195697e..54111ed218b1 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -303,7 +303,7 @@
 			};
 
 			can1: can at 53fe4000 {
-				compatible = "fsl,imx35-flexcan";
+				compatible = "fsl,imx35-flexcan", "fsl,imx25-flexcan";
 				reg = <0x53fe4000 0x1000>;
 				clocks = <&clks 33>, <&clks 33>;
 				clock-names = "ipg", "per";
@@ -312,7 +312,7 @@
 			};
 
 			can2: can at 53fe8000 {
-				compatible = "fsl,imx35-flexcan";
+				compatible = "fsl,imx35-flexcan", "fsl,imx25-flexcan";
 				reg = <0x53fe8000 0x1000>;
 				clocks = <&clks 34>, <&clks 34>;
 				clock-names = "ipg", "per";
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 7d647d043f52..3d65c0192f69 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -551,7 +551,7 @@
 			};
 
 			can1: can at 53fc8000 {
-				compatible = "fsl,imx53-flexcan";
+				compatible = "fsl,imx53-flexcan", "fsl,imx25-flexcan";
 				reg = <0x53fc8000 0x4000>;
 				interrupts = <82>;
 				clocks = <&clks IMX5_CLK_CAN1_IPG_GATE>,
@@ -561,7 +561,7 @@
 			};
 
 			can2: can at 53fcc000 {
-				compatible = "fsl,imx53-flexcan";
+				compatible = "fsl,imx53-flexcan", "fsl,imx25-flexcan";
 				reg = <0x53fcc000 0x4000>;
 				interrupts = <83>;
 				clocks = <&clks IMX5_CLK_CAN2_IPG_GATE>,
-- 
2.17.0
