From: anurupvasu@gmail.com (Anurup M)
Date: Thu,  3 Nov 2016 01:42:07 -0400
Subject: [RESEND PATCH v1 11/11] dts: arm64: hip06: Add Hisilicon SoC PMU
 support
In-Reply-To: <1478151727-20250-1-git-send-email-anurup.m@huawei.com>
References: <1478151727-20250-1-git-send-email-anurup.m@huawei.com>
Message-ID: <1478151727-20250-12-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	1. Add nodes for hip06 L3 cache to support uncore events.
	2. Add nodes for hip06 MN to support uncore events.
	3. Add nodes for hip06 DDRC to support uncore events.

Signed-off-by: Anurup M <anurup.m@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hip06.dtsi | 116 +++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
index cb9e018..9ff3afe 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
@@ -980,6 +980,122 @@
 			status = "disabled";
 		};
 
+		djtag0: djtag at 60010000 {
+			compatible = "hisilicon,hip06-cpu-djtag-v1";
+			reg = <0x0 0x60010000 0x0 0x10000>;
+
+			/* L3 cache for socket0 CPU die scl#2 */
+			pmul3c0 {
+				compatible = "hisilicon,hisi-pmu-l3c-v1";
+				scl-id = <0x02>;
+				num-events = <0x16>;
+				num-counters = <0x08>;
+				module-id = <0x04 0x04 0x04 0x04>;
+				num-banks = <0x04>;
+				cfgen-map = <0x02 0x04 0x01 0x08>;
+				counter-reg = <0x170>;
+				evctrl-reg = <0x04>;
+				event-en = <0x1000000>;
+				evtype-reg = <0x140>;
+			};
+
+			/* Miscellaneous node for socket0
+			 * CPU die scl#2
+			 */
+			pmumn0 {
+				compatible = "hisilicon,hisi-pmu-mn-v1";
+				scl-id = <0x02>;
+				num-events = <0x09>;
+				num-counters = <0x04>;
+				module-id = <0x0b>;
+				cfgen-map = <0x01>;
+				counter-reg = <0x30>;
+				evctrl-reg = <0x40>;
+				event-en = <0x01>;
+				evtype-reg = <0x48>;
+			};
+		};
+
+		djtag1: djtag at 40010000 {
+			compatible = "hisilicon,hip06-cpu-djtag-v1";
+			reg = <0x0 0x40010000 0x0 0x10000>;
+
+			/* L3 cache for socket0 CPU die scl#1 */
+			pmul3c1 {
+				compatible = "hisilicon,hisi-pmu-l3c-v1";
+				scl-id = <0x01>;
+				num-events = <0x16>;
+				num-counters = <0x08>;
+				module-id = <0x04 0x04 0x04 0x04>;
+				num-banks = <0x04>;
+				cfgen-map = <0x02 0x04 0x01 0x08>;
+				counter-reg = <0x170>;
+				evctrl-reg = <0x04>;
+				event-en = <0x1000000>;
+				evtype-reg = <0x140>;
+			};
+
+			/* Miscellaneous node for socket0
+			 * CPU die scl#1
+			 */
+			pmumn1 {
+				compatible = "hisilicon,hisi-pmu-mn-v1";
+				scl-id = <0x01>;
+				num-events = <0x09>;
+				num-counters = <0x04>;
+				module-id = <0x0b>;
+				cfgen-map = <0x01>;
+				counter-reg = <0x30>;
+				evctrl-reg = <0x40>;
+				event-en = <0x01>;
+				evtype-reg = <0x48>;
+			};
+		};
+
+		/* DDRC for CPU die scl #1 Channel #0 */
+		pmu_sccl0_ddrc0: pmu_ddrc0 at 40348000 {
+			compatible = "hisilicon,hisi-pmu-ddrc-v1";
+			scl-id = <0x01>;
+			ch-id = <0x0>;
+			num-events = <0x0d>;
+			num-counters = <0x04>;
+			reg = <0x0 0x40348000 0x0 0x10000>; /* TOTEMA DDRC0 */
+			status = "okay";
+		};
+
+		/* DDRC for CPU die scl #1 Channel #1 */
+		pmu_sccl0_ddrc1: pmu_ddrc1 at 40358000 {
+			compatible = "hisilicon,hisi-pmu-ddrc-v1";
+			scl-id = <0x01>;
+			ch-id = <0x01>;
+			num-events = <0x0d>;
+			num-counters = <0x04>;
+			reg = <0x0 0x40358000 0x0 0x10000>; /* TOTEMA DDRC1 */
+			status = "okay";
+		};
+
+		/* DDRC for CPU die scl #2 Channel #0 */
+		pmu_sccl1_ddrc0: pmu_ddrc0 at 60348000 {
+			compatible = "hisilicon,hisi-pmu-ddrc-v1";
+			scl-id = <0x02>;
+			ch-id = <0x0>;
+			num-events = <0x0d>;
+			num-counters = <0x04>;
+			reg = <0x0 0x60348000 0x0 0x10000>; /* TOTEMC DDRC0 */
+			status = "okay";
+		};
+
+		/* DDRC for CPU die scl #2 Channel #1 */
+		pmu_sccl1_ddrc1: pmu_ddrc1 at 60358000 {
+			compatible = "hisilicon,hisi-pmu-ddrc-v1";
+			scl-id = <0x02>;
+			ch-id = <0x01>;
+			num-events = <0x0d>;
+			num-counters = <0x04>;
+			reg = <0x0 0x60358000 0x0 0x10000>; /* TOTEMC DDRC1 */
+			status = "okay";
+		};
+
 		sas1: sas at a2000000 {
 			compatible = "hisilicon,hip06-sas-v2";
 			reg = <0 0xa2000000 0 0x10000>;
-- 
2.1.4
