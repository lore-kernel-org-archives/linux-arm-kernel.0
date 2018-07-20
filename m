From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Fri, 20 Jul 2018 18:11:50 +0800
Subject: [PATCH v2] ARM: dts: berlin: Add missing OPP properties for CPUs
In-Reply-To: <20180720130838.187becb9@xhacker.debian>
References: <20180720130838.187becb9@xhacker.debian>
Message-ID: <20180720181150.15a2aa71@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Viresh Kumar <viresh.kumar@linaro.org>

The OPP properties, like "operating-points", should either be present
for all the CPUs of a cluster or none. If these are present only for a
subset of CPUs of a cluster then things will start falling apart as soon
as the CPUs are brought online in a different order. For example, this
will happen because the operating system looks for such properties in
the CPU node it is trying to bring up, so that it can create an OPP
table.

Add such missing properties.

Fix other missing properties (clocks, clock latency) as well to
make it all work.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
Since v1:
 - fix author, it's from Viresh. Sorry for making this mistake

 arch/arm/boot/dts/berlin2.dtsi  | 10 ++++++++++
 arch/arm/boot/dts/berlin2q.dtsi | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index db67377af266..d2f7d984bba5 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -50,6 +50,16 @@
 			device_type = "cpu";
 			next-level-cache = <&l2>;
 			reg = <1>;
+
+			clocks = <&chip_clk CLKID_CPU>;
+			clock-latency = <100000>;
+			operating-points = <
+				/* kHz    uV */
+				1200000 1200000
+				1000000 1200000
+				800000  1200000
+				600000  1200000
+			>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 516a7ce25791..99d6872a6dfc 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -45,6 +45,17 @@
 			device_type = "cpu";
 			next-level-cache = <&l2>;
 			reg = <1>;
+
+			clocks = <&chip_clk CLKID_CPU>;
+			clock-latency = <100000>;
+			/* Can be modified by the bootloader */
+			operating-points = <
+				/* kHz    uV */
+				1200000 1200000
+				1000000 1200000
+				800000  1200000
+				600000  1200000
+			>;
 		};
 
 		cpu2: cpu at 2 {
@@ -52,6 +63,17 @@
 			device_type = "cpu";
 			next-level-cache = <&l2>;
 			reg = <2>;
+
+			clocks = <&chip_clk CLKID_CPU>;
+			clock-latency = <100000>;
+			/* Can be modified by the bootloader */
+			operating-points = <
+				/* kHz    uV */
+				1200000 1200000
+				1000000 1200000
+				800000  1200000
+				600000  1200000
+			>;
 		};
 
 		cpu3: cpu at 3 {
@@ -59,6 +81,17 @@
 			device_type = "cpu";
 			next-level-cache = <&l2>;
 			reg = <3>;
+
+			clocks = <&chip_clk CLKID_CPU>;
+			clock-latency = <100000>;
+			/* Can be modified by the bootloader */
+			operating-points = <
+				/* kHz    uV */
+				1200000 1200000
+				1000000 1200000
+				800000  1200000
+				600000  1200000
+			>;
 		};
 	};
 
-- 
2.18.0
