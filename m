From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue,  5 Jun 2018 10:17:49 +0530
Subject: [PATCH V2 2/2] arm: dts: sunxi: Add missing cooling device properties
 for CPUs
In-Reply-To: <d894f425b7c32bce4dc4a982db8f4dface2db31d.1528173943.git.viresh.kumar@linaro.org>
References: <20180601151701.sshwfdbflic6mybv@flea>
 <d894f425b7c32bce4dc4a982db8f4dface2db31d.1528173943.git.viresh.kumar@linaro.org>
Message-ID: <a313ec0be4104494de319e8318e05614fb97b2fd.1528173943.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cooling device properties, like "#cooling-cells" and
"dynamic-power-coefficient", should either be present for all the CPUs
of a cluster or none. If these are present only for a subset of CPUs of
a cluster then things will start falling apart as soon as the CPUs are
brought online in a different order. For example, this will happen
because the operating system looks for such properties in the CPU node
it is trying to bring up, so that it can register a cooling device.

Add such missing properties.

Fix other missing properties (clocks, OPP, clock latency) as well to
make it all work.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2:
- Separated patch for h3
- Fixed subject s/sun/sunxi/

 arch/arm/boot/dts/sun6i-a31.dtsi | 30 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi | 13 +++++++++++++
 arch/arm/boot/dts/sun8i-a33.dtsi |  9 +++++++++
 3 files changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index c72992556a86..debc0bf22ea3 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -119,18 +119,48 @@
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <1>;
+			clocks = <&ccu CLK_CPU>;
+			clock-latency = <244144>; /* 8 32k periods */
+			operating-points = <
+				/* kHz	  uV */
+				1008000	1200000
+				864000	1200000
+				720000	1100000
+				480000	1000000
+				>;
+			#cooling-cells = <2>;
 		};
 
 		cpu at 2 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <2>;
+			clocks = <&ccu CLK_CPU>;
+			clock-latency = <244144>; /* 8 32k periods */
+			operating-points = <
+				/* kHz	  uV */
+				1008000	1200000
+				864000	1200000
+				720000	1100000
+				480000	1000000
+				>;
+			#cooling-cells = <2>;
 		};
 
 		cpu at 3 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <3>;
+			clocks = <&ccu CLK_CPU>;
+			clock-latency = <244144>; /* 8 32k periods */
+			operating-points = <
+				/* kHz	  uV */
+				1008000	1200000
+				864000	1200000
+				720000	1100000
+				480000	1000000
+				>;
+			#cooling-cells = <2>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index e529e4ff2174..35372a0cfc8d 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -122,6 +122,19 @@
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <1>;
+			clocks = <&ccu CLK_CPU>;
+			clock-latency = <244144>; /* 8 32k periods */
+			operating-points = <
+				/* kHz	  uV */
+				960000	1400000
+				912000	1400000
+				864000	1300000
+				720000	1200000
+				528000	1100000
+				312000	1000000
+				144000	1000000
+				>;
+			#cooling-cells = <2>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 8d278ee001e9..4e92741b24a7 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -132,21 +132,30 @@
 		};
 
 		cpu at 1 {
+			clocks = <&ccu CLK_CPUX>;
+			clock-names = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu at 2 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <2>;
+			clocks = <&ccu CLK_CPUX>;
+			clock-names = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu at 3 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <3>;
+			clocks = <&ccu CLK_CPUX>;
+			clock-names = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 	};
 
-- 
2.15.0.194.g9af6a3dea062
