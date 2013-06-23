From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 23 Jun 2013 10:44:20 +0200
Subject: [PATCH v2 4/5] ARM: dts: imx27 cpufreq-cpu0 frequencies
In-Reply-To: <1371977061-9891-1-git-send-email-mpa@pengutronix.de>
References: <1371977061-9891-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1371977061-9891-5-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set operating-points for imx27. There is no regulator support, so the
voltages are 0. The frequencies should be the same for all imx27 boards,
so it is defined here and can be overwritten if necessary.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---

Notes:
    Changes in v2:
     - Update compatibility list of cpu node
     - Simplify cpu node

 arch/arm/boot/dts/imx27.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index c6a78ba..377b026 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -47,6 +47,24 @@
 		};
 	};
 
+	cpus {
+		#size-cells = <0>;
+		#address-cells = <1>;
+
+		cpu {
+			device_type = "cpu";
+			compatible = "arm,arm926ej-s";
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
