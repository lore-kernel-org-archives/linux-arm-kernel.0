From: manabian@gmail.com (Joachim Eastwood)
Date: Mon, 27 Apr 2015 23:04:52 +0200
Subject: [PATCH v2 4/7] ARM: dts: Add base DT for NXP LPC18xx
In-Reply-To: <1430168695-21248-1-git-send-email-manabian@gmail.com>
References: <1430168695-21248-1-git-send-email-manabian@gmail.com>
Message-ID: <1430168695-21248-5-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NXP LPC18xx/43xx SoCs are very similar devices and should be able to
share a common base (lpc18xx.dtsi). Diffences between the devices are
put in a dtsi which is specific to that device.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 114 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 arch/arm/boot/dts/lpc18xx.dtsi

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
new file mode 100644
index 000000000000..204da5b52ef9
--- /dev/null
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -0,0 +1,114 @@
+/*
+ * Common base for NXP LPC18xx and LPC43xx devices.
+ *
+ * Copyright 2015 Joachim Eastwood <manabian@gmail.com>
+ *
+ * This code is released using a dual license strategy: BSD/GPL
+ * You can choose the licence that better fits your requirements.
+ *
+ * Released under the terms of 3-clause BSD License
+ * Released under the terms of GNU General Public License Version 2.0
+ *
+ */
+
+#include "armv7-m.dtsi"
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "arm,cortex-m3";
+			device_type = "cpu";
+			reg = <0x0>;
+		};
+	};
+
+	clocks {
+		xtal: xtal {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <12000000>;
+		};
+
+		/* Temporary hardcode PLL1 until clk drivers are merged */
+		pll1: pll1 {
+			compatible = "fixed-factor-clock";
+			clocks = <&xtal>;
+			#clock-cells = <0>;
+			clock-div = <1>;
+			clock-mult = <12>;
+		};
+	};
+
+	soc {
+		uart0: serial at 40081000 {
+			compatible = "ns16550a";
+			reg = <0x40081000 0x1000>;
+			reg-shift = <2>;
+			interrupts = <24>;
+			clocks = <&pll1>;
+			status = "disabled";
+		};
+
+		uart1: serial at 40082000 {
+			compatible = "ns16550a";
+			reg = <0x40082000 0x1000>;
+			reg-shift = <2>;
+			interrupts = <25>;
+			clocks = <&pll1>;
+			status = "disabled";
+		};
+
+		timer0: timer at 40084000 {
+			compatible = "nxp,lpc3220-timer";
+			reg = <0x40084000 0x1000>;
+			interrupts = <12>;
+			clocks = <&pll1>;
+			clock-names = "timerclk";
+		};
+
+		timer1: timer at 40085000 {
+			compatible = "nxp,lpc3220-timer";
+			reg = <0x40085000 0x1000>;
+			interrupts = <13>;
+			clocks = <&pll1>;
+			clock-names = "timerclk";
+		};
+
+		uart2: serial at 400c1000 {
+			compatible = "ns16550a";
+			reg = <0x400c1000 0x1000>;
+			reg-shift = <2>;
+			interrupts = <26>;
+			clocks = <&pll1>;
+			status = "disabled";
+		};
+
+		uart3: serial at 400c2000 {
+			compatible = "ns16550a";
+			reg = <0x400c2000 0x1000>;
+			reg-shift = <2>;
+			interrupts = <27>;
+			clocks = <&pll1>;
+			status = "disabled";
+		};
+
+		timer2: timer at 400c3000 {
+			compatible = "nxp,lpc3220-timer";
+			reg = <0x400c3000 0x1000>;
+			interrupts = <14>;
+			clocks = <&pll1>;
+			clock-names = "timerclk";
+		};
+
+		timer3: timer at 400c4000 {
+			compatible = "nxp,lpc3220-timer";
+			reg = <0x400c4000 0x1000>;
+			interrupts = <15>;
+			clocks = <&pll1>;
+			clock-names = "timerclk";
+		};
+	};
+};
-- 
1.8.0
