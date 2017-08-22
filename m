From: andy.yan@rock-chips.com (Andy Yan)
Date: Tue, 22 Aug 2017 21:11:55 +0800
Subject: [PATCH v2 1/3] ARM: dts: rockchip: add cpu opp table for rv1108
Message-ID: <1503407515-13943-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add cpu opp table for rv1108 to support frequency
from 408MHZ to 1008MHZ.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v2:
- switch to operating-points-v2
- split cpu-supply to a separate patch

 arch/arm/boot/dts/rv1108.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 064cec3..1b854e1 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -69,6 +69,33 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0xf00>;
+			operating-points-v2 = <&cpu_opp_table>;
+			clocks = <&cru ARMCLK>;
+		};
+	};
+
+	cpu_opp_table: opp_table {
+		compatible = "operating-points-v2";
+
+		opp-408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <975000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <975000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <1025000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <1150000>;
+			clock-latency-ns = <40000>;
 		};
 	};
 
-- 
2.7.4
