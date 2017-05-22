From: zhangshaokun@hisilicon.com (Shaokun Zhang)
Date: Mon, 22 May 2017 20:48:40 +0800
Subject: [PATCH v8 9/9] dts: arm64: hip07: Add Hisilicon SoC PMU support
Message-ID: <1495457320-239973-1-git-send-email-zhangshaokun@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anurup M <anurup.m@huawei.com>

Add nodes for djtag, L3 cache and MN to support uncore events.

Signed-off-by: Anurup M <anurup.m@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hip07.dtsi | 87 ++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hip07.dtsi b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
index 283d7b5..38bf2e8 100644
--- a/arch/arm64/boot/dts/hisilicon/hip07.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
@@ -1535,4 +1535,91 @@
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
+			hisilicon,module-id = <0x01>;
+			hisilicon,instance-id = <0x01>;
+		};
+
+		/* L3 cache bank 1 for socket0 CPU die scl#3 */
+		pmul3c1 {
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x02>;
+			hisilicon,instance-id = <0x01>;
+		};
+
+		/* L3 cache bank 2 for socket0 CPU die scl#3 */
+		pmul3c2 {
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x03>;
+			hisilicon,instance-id = <0x01>;
+		};
+
+		/* L3 cache bank 3 for socket0 CPU die scl#3 */
+		pmul3c3 {
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x04>;
+			hisilicon,instance-id = <0x01>;
+		};
+
+		/*
+		 * Miscellaneous node for socket0
+		 * CPU die scl#3
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
+			hisilicon,module-id = <0x01>;
+			hisilicon,instance-id = <0x01>;
+		};
+
+		/* L3 cache bank 1 for socket0 CPU die scl#1 */
+		pmul3c1 {
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x02>;
+			hisilicon,instance-id = <0x01>;
+		};
+
+		/* L3 cache bank 2 for socket0 CPU die scl#1 */
+		pmul3c2 {
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x03>;
+			hisilicon,instance-id = <0x01>;
+		};
+
+		/* L3 cache bank 3 for socket0 CPU die scl#1 */
+		pmul3c3 {
+			compatible = "hisilicon,hip07-pmu-l3c-v2";
+			hisilicon,module-id = <0x04>;
+			hisilicon,instance-id = <0x01>;
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
1.9.1
