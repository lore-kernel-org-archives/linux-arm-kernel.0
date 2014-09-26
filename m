From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 26 Sep 2014 15:41:03 +0200
Subject: [PATCH v2 5/6] ARM: dts: imx53: add cpufreq-dt support
In-Reply-To: <1411738864-26549-1-git-send-email-l.stach@pengutronix.de>
References: <1411738864-26549-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1411738864-26549-5-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add all required properties for the cpufreq-dt driver.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
v2:
- split out device instantiation
---
 arch/arm/boot/dts/imx53.dtsi | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index c6c58c1c00e3..aa2fb2f3616d 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -46,10 +46,21 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a8";
 			reg = <0x0>;
+			clocks = <&clks IMX5_CLK_ARM>;
+			clock-latency = <61036>;
+			voltage-tolerance = <5>;
+			operating-points = <
+				/* kHz */
+				 166666  850000
+				 400000  900000
+				 800000 1050000
+				1000000 1200000
+				1200000 1300000
+			>;
 		};
 	};
 
-- 
2.1.0
