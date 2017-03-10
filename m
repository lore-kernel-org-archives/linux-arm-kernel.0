From: anurupvasu@gmail.com (Anurup M)
Date: Fri, 10 Mar 2017 01:29:09 -0500
Subject: [PATCH v6 11/11] dts: arm64: hip07: Add Hisilicon SoC PMU support
Message-ID: <1489127349-112951-1-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for djtag, L3 cache and MN to support uncore events.

Signed-off-by: Anurup M <anurup.m@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hip07.dtsi | 79 ++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hip07.dtsi b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
index 5144eb1..3155ee3 100644
--- a/arch/arm64/boot/dts/hisilicon/hip07.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
@@ -1056,4 +1056,83 @@
 			status = "disabled";
 		};
 	};
+
+	djtag0: djtag at 60010000 {
+		compatible = "hisilicon,hip07-cpu-djtag-v2";
+		reg = <0x0 0x60010000 0x0 0x10000>;
+		hisilicon,scl-id = <0x03>;
+
+		/* L3 cache bank 0 for socket0 CPU die scl#3 */
+		pmul3c0 {
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x01 0x01>;
+		};
+
+		/* L3 cache bank 1 for socket0 CPU die scl#3 */
+		pmul3c1 {
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x02 0x01>;
+		};
+
+		/* L3 cache bank 2 for socket0 CPU die scl#3 */
+		pmul3c2 {
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x03 0x01>;
+		};
+
+		/* L3 cache bank 3 for socket0 CPU die scl#3 */
+		pmul3c3 {
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x04 0x01>;
+		};
+
+		/*
+		 * Miscellaneous node for socket0
+		 * CPU die scl#2
+		 */
+		pmumn0 {
+			compatible = "hisilicon,hip07-pmu-mn-v2";
+			hisilicon,module-id = <0x21>;
+		};
+	};
+
+	djtag1: djtag at 40010000 {
+		compatible = "hisilicon,hip07-cpu-djtag-v2";
+		reg = <0x0 0x40010000 0x0 0x10000>;
+		hisilicon,scl-id = <0x01>;
+
+		/* L3 cache bank 0 for socket0 CPU die scl#1 */
+		pmul3c0 {
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x01 0x01>;
+		};
+
+		/* L3 cache bank 1 for socket0 CPU die scl#1 */
+		pmul3c1 {
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x02 0x01>;
+		};
+
+		/* L3 cache bank 2 for socket0 CPU die scl#1 */
+		pmul3c2 {
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x03 0x01>;
+		};
+
+		/* L3 cache bank 3 for socket0 CPU die scl#1 */
+		pmul3c3 {
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x04 0x01>;
+		};
+
+		/*
+		 * Miscellaneous node for socket0
+		 * CPU die scl#1
+		 */
+		pmumn1 {
+			compatible = "hisilicon,hip07-pmu-mn-v2";
+			hisilicon,module-id = <0x21>;
+		};
+	};
+
 };
-- 
2.1.4
