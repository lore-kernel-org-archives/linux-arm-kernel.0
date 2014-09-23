From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Tue, 23 Sep 2014 11:55:20 -0700
Subject: [PATCH] ARM: zynq: DT: Remove 222 MHz OPP
Message-ID: <1411498520-8117-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to dependencies between timer and CPU frequency, only changes by
powers of two are allowed. The clocksource driver prevents other
changes, but with cpufreq and its governors it can result in being
spammed with error messages constantly. Hence, remove the 222 MHz OPP.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/boot/dts/zynq-7000.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 6cc83d4c6c76..a0ed01d68328 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -30,7 +30,6 @@
 				/* kHz    uV */
 				666667  1000000
 				333334  1000000
-				222223  1000000
 			>;
 		};
 
-- 
2.1.0.1.g27b9230
