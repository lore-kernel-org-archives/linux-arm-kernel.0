From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Fri, 21 Jun 2013 00:39:50 +0200
Subject: [PATCH v5 1/3] arm: Add basic clocks for Rockchip rk3066a SoCs
In-Reply-To: <201306210039.14740.heiko@sntech.de>
References: <201306210039.14740.heiko@sntech.de>
Message-ID: <201306210039.51030.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a basic clock setup for rk3066a SoCs, currently only using
dummy clocks to satisfy drivers requiring clocks..

Clocks whose rates need to be known are supplied by fixed-rate
"dummy"-clocks that provide the correct rate. This is uncritical insofar
that the only bootloader currently in existence for Rockchip devices
is the propietary Rockchip one that always setups the clocks in the
necessary and same way.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a-clocks.dtsi |   52 +++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3066a-clocks.dtsi

diff --git a/arch/arm/boot/dts/rk3066a-clocks.dtsi b/arch/arm/boot/dts/rk3066a-clocks.dtsi
new file mode 100644
index 0000000..4db426b
--- /dev/null
+++ b/arch/arm/boot/dts/rk3066a-clocks.dtsi
@@ -0,0 +1,51 @@
+/*
+ * Copyright (c) 2013 MundoReader S.L.
+ * Author: Heiko Stuebner <heiko@sntech.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/ {
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		/*
+		 * These are dummy clock, to be used as placeholder when
+		 * a specific clock is not yet implemented. It should be
+		 * dropped when the driver is complete.
+		 */
+		dummy: dummy {
+			compatible = "fixed-clock";
+			clock-frequency = <0>;
+			#clock-cells = <0>;
+		};
+
+		xin24m: xin24m {
+			compatible = "fixed-clock";
+			clock-frequency = <24000000>;
+			#clock-cells = <0>;
+		};
+
+		dummy48m: dummy48m {
+			compatible = "fixed-clock";
+			clock-frequency = <48000000>;
+			#clock-cells = <0>;
+		};
+
+		dummy150m: dummy150m {
+			compatible = "fixed-clock";
+			clock-frequency = <150000000>;
+			#clock-cells = <0>;
+		};
+	};
+};
-- 
1.7.10.4
