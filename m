From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 21 Mar 2017 16:36:02 +0100
Subject: [PATCH v3 02/11] ARM: sun8i: a33: add all operating points
In-Reply-To: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
Message-ID: <20170321153611.16228-3-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds almost all operating points allowed for the A33 as defined by
fex files available at:
https://github.com/linux-sunxi/sunxi-boards/tree/master/sys_config/a33

There are more possible frequencies in this patch than there are in the
fex files because the fex files only give an interval of possible
frequencies for a given voltage. All supported frequencies are defined
in the original driver code in Allwinner vendor tree.

There are two missing frequencies though: 1104MHz and 1200MHz which
require the CPU to have 1.32V supplied, which is higher than the default
voltage.

Without all A33 boards defining the CPU regulator, we cannot have these
two frequencies as it would cause the CPU to try to run a higher
frequency without "overvolting" which is very likely to crash the CPU.

Therefore, these two frequencies must be enabled on a per-board basis.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

v2:
  - updated commit log,
  - removed 1.1GHz as it requires overvolting the CPU which need the CPU
  regulator to be set which is set on a per-board basis,

 arch/arm/boot/dts/sun8i-a33.dtsi | 54 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 39b2d78..b1cdff66 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -49,18 +49,72 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
+		opp at 120000000 {
+			opp-hz = /bits/ 64 <120000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp at 240000000 {
+			opp-hz = /bits/ 64 <240000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp at 312000000 {
+			opp-hz = /bits/ 64 <312000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp at 408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp at 480000000 {
+			opp-hz = /bits/ 64 <480000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp at 504000000 {
+			opp-hz = /bits/ 64 <504000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp at 600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <1040000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
 		opp at 648000000 {
 			opp-hz = /bits/ 64 <648000000>;
 			opp-microvolt = <1040000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
+		opp at 720000000 {
+			opp-hz = /bits/ 64 <720000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
 		opp at 816000000 {
 			opp-hz = /bits/ 64 <816000000>;
 			opp-microvolt = <1100000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
+		opp at 912000000 {
+			opp-hz = /bits/ 64 <912000000>;
+			opp-microvolt = <1200000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
 		opp at 1008000000 {
 			opp-hz = /bits/ 64 <1008000000>;
 			opp-microvolt = <1200000>;
-- 
2.9.3
