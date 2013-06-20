From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 20 Jun 2013 16:50:14 +0200
Subject: [PATCH 5/6] ARM: dts: imx27 cpufreq-cpu0 frequencies
In-Reply-To: <1371739815-6666-1-git-send-email-mpa@pengutronix.de>
References: <1371739815-6666-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1371739815-6666-6-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set operating-points for imx27. There is no regulator support, so the
voltages are 0. The frequencies should be the same for all imx27 boards,
so it is defined here and can be overwritten if necessary.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx27.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index e883e77..3ebd98a 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -47,6 +47,25 @@
 		};
 	};
 
+	cpus {
+		#size-cells = <0>;
+		#address-cells = <1>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "fsl,imx27", "arm,arm926ejs";
+			reg = <0>;
+			operating-points = <
+				/* kHz  uV (No regulator support) */
+				133000  0
+				399000  0
+			>;
+			clock-latency = <61036>; /* two CLK32 periods */
+			clocks = <&clks 18>;
+			clock-names = "cpu";
+		};
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.8.2.1
