From: anurupvasu@gmail.com (Anurup M)
Date: Mon,  2 Jan 2017 01:51:17 -0500
Subject: [PATCH v3 10/10] dts: arm64: hip06: Add Hisilicon SoC PMU support
Message-ID: <1483339877-24252-1-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. Add nodes for hip06 L3 cache to support uncore events.
2. Add nodes for hip06 MN to support uncore events.

Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Anurup M <anurup.m@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hip06.dtsi | 72 ++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
index e861698..02ff95f 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
@@ -963,6 +963,78 @@
 			status = "disabled";
 		};
 
+		djtag0: djtag at 60010000 {
+			compatible = "hisilicon,hip06-djtag-v1";
+			reg = <0x0 0x60010000 0x0 0x10000>;
+			hisi-scl-id = <0x02>;
+
+			/* L3 cache bank 0 for socket0 CPU die scl#2 */
+			pmul3c0 {
+				compatible = "hisilicon,hip06-pmu-l3c-v1";
+				hisi-module-id = <0x04 0x02>;
+			};
+
+			/* L3 cache bank 1 for socket0 CPU die scl#2 */
+			pmul3c1 {
+				compatible = "hisilicon,hip06-pmu-l3c-v1";
+				hisi-module-id = <0x04 0x04>;
+			};
+
+			/* L3 cache bank 2 for socket0 CPU die scl#2 */
+			pmul3c2 {
+				compatible = "hisilicon,hip06-pmu-l3c-v1";
+				hisi-module-id = <0x04 0x01>;
+			};
+
+			/* L3 cache bank 3 for socket0 CPU die scl#2 */
+			pmul3c3 {
+				compatible = "hisilicon,hip06-pmu-l3c-v1";
+				hisi-module-id = <0x04 0x08>;
+			};
+
+			/* Miscellaneous node for socket0 CPU die scl#2 */
+			pmumn0 {
+				compatible = "hisilicon,hip06-pmu-mn-v1";
+				hisi-module-id = <0x0b>;
+			};
+		};
+
+		djtag1: djtag at 40010000 {
+			compatible = "hisilicon,hip06-djtag-v1";
+			reg = <0x0 0x40010000 0x0 0x10000>;
+			hisi-scl-id = <0x01>;
+
+			/* L3 cache bank 0 for socket0 CPU die scl#1 */
+			pmul3c0 {
+				compatible = "hisilicon,hip06-pmu-l3c-v1";
+				hisi-module-id = <0x04 0x02>;
+			};
+
+			/* L3 cache bank 1 for socket0 CPU die scl#1 */
+			pmul3c1 {
+				compatible = "hisilicon,hip06-pmu-l3c-v1";
+				hisi-module-id = <0x04 0x04>;
+			};
+
+			/* L3 cache bank 2 for socket0 CPU die scl#1 */
+			pmul3c2 {
+				compatible = "hisilicon,hip06-pmu-l3c-v1";
+				hisi-module-id = <0x04 0x01>;
+			};
+
+			/* L3 cache bank 3 for socket0 CPU die scl#1 */
+			pmul3c3 {
+				compatible = "hisilicon,hip06-pmu-l3c-v1";
+				hisi-module-id = <0x04 0x08>;
+			};
+
+			/* Miscellaneous node for socket0 CPU die scl#1 */
+			pmumn1 {
+				compatible = "hisilicon,hip06-pmu-mn-v1";
+				hisi-module-id = <0x0b>;
+			};
+		};
+
 		sas1: sas at a2000000 {
 			compatible = "hisilicon,hip06-sas-v2";
 			reg = <0 0xa2000000 0 0x10000>;
-- 
2.1.4
