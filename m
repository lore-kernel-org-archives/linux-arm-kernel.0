From: anurupvasu@gmail.com (Anurup M)
Date: Tue, 28 Jun 2016 05:50:22 -0400
Subject: [PATCH 1/8] arm64:perf: Add Devicetree bindings for Hisilicon SoC PMU
In-Reply-To: <1467107429-55477-1-git-send-email-anurup.m@huawei.com>
References: <1467107429-55477-1-git-send-email-anurup.m@huawei.com>
Message-ID: <1467107429-55477-2-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	1) Device tree bindings for Hisilicon PMU.
	2) Add example for Hisilicon LLC PMU.

Signed-off-by: Anurup M <anurup.m@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 .../devicetree/bindings/arm/hisilicon/pmu.txt      | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/pmu.txt

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/pmu.txt b/Documentation/devicetree/bindings/arm/hisilicon/pmu.txt
new file mode 100644
index 0000000..7584a81
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/pmu.txt
@@ -0,0 +1,32 @@
+Hisilicon SoC HIP05 ARMv8 PMU
+
+Required Properties:
+	- compatible : This field contain two values. The first value is
+		always "hisilicon" and second value is the PMU type as shown
+		in below examples:
+		(a) "hisilicon,hip05-llc" for Hisiliocn SoC L3 cache PMU
+		(b) "hisilicon,hip05-ddrc" for Hisiliocn SoC DDRC PMU
+		(c) "hisilicon,hip05-mn" for Hisiliocn SoC MN PMU
+
+Optional Properties:
+
+	- djtag	: Some PMU registers are accessed via the Djtag interface
+		This field contains two values. The first value is the djtag
+		node phandle and second value is the Super CPU Cluster ID.
+
+	- interrupt-parent : A phandle indicating which interrupt controller
+		this PMU signals interrupts to.
+
+	- interrupts : Interrupt lines used by this PMU. If the PMU has
+		multiple banks, then all IRQ lines are listed in this
+		property.
+
+Example:
+	llc0: llc at 0 {
+		compatible = "hisilicon,hip05-llc";
+		djtag = <&djtag0 2>; /* DJTAG node for Super CPU Cluster 2
+				      * (starts from 1) */
+		interrupt-parent = <&mbigen_pc>;
+		interrupts = <141 4>,<142 4>,
+			 <143 4>,<144 4>; /* IRQ lines for 4 L3 cache banks */
+	};
-- 
2.1.4
