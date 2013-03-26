From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 26 Mar 2013 18:43:39 +0100
Subject: [PATCH v2 07/10] arm: zynq: Add support for pmu
In-Reply-To: <1364319822-5504-1-git-send-email-michal.simek@xilinx.com>
References: <1364319822-5504-1-git-send-email-michal.simek@xilinx.com>
Message-ID: <15c64fc9174ed6b39ae847fad3d78601d50e6049.1364319776.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Zynq is standard PMU with 2 interrupt per core.
There is also access via register which is not used right now.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 arch/arm/boot/dts/zynq-7000.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 51243db..748fc34 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -15,6 +15,13 @@
 / {
 	compatible = "xlnx,zynq-7000";
 
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts = <0 5 4>, <0 6 4>;
+		interrupt-parent = <&intc>;
+		reg = < 0xf8891000 0x1000 0xf8893000 0x1000 >;
+	};
+
 	amba {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
1.7.9.7
