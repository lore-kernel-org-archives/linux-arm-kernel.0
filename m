From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun,  7 Apr 2013 21:56:45 +0200
Subject: [PATCH] ARM: dts: imx51 cpu node
Message-ID: <1365364605-10087-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a cpus/cpu at 0 node for imx51 with default operating
points for the cpufreq-cpu0 driver. There is currently no regulator
support, so the voltages are 0 here.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx51.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index fcf035b..0c7ac0d 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -55,6 +55,24 @@
 		};
 	};
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a8";
+			reg = <0>;
+			clock-latency = <61036>; /* two CLK32 periods */
+			clocks = <&clks 24>;
+			clock-names = "cpu";
+			operating-points = <
+				/* kHz  uV (No regulator support) */
+				160000  0
+				800000  0
+			>;
+		};
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.8.1.5
