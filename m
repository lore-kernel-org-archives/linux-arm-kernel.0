From: balbi@ti.com (Felipe Balbi)
Date: Fri, 8 May 2015 14:57:29 -0500
Subject: [PATCH 1/2] arm: boot: dts: am4372: add operating points
Message-ID: <1431115050-23693-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By adding operating points, cpufreq-dt has a
chance of running and doing something useful.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index c80a3e233792..ea1db20f64fc 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -38,6 +38,15 @@
 			clocks = <&dpll_mpu_ck>;
 			clock-names = "cpu";
 
+			operating-points = <
+				/* kHz		uV */
+				1000000		1325000 /* OPP_NITRO */
+				 800000		1260000 /* OPP_TURBO */
+				 720000		1200000 /* OPP_120 */
+				 600000		1100000 /* OPP_100 */
+				 300000		 950000 /* OPP_50 */
+			>;
+
 			clock-latency = <300000>; /* From omap-cpufreq driver */
 		};
 	};
-- 
2.4.0.rc3
