From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Tue, 26 Nov 2013 17:04:49 -0800
Subject: [PATCH v2 2/9] arm: dt: zynq: Add 'cpus' node
In-Reply-To: <1385514296-26702-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1385514296-26702-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1385514296-26702-3-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a 'cpus' node to describe the CPU cores of Zynq.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Acked-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
---
v2:
 - remove cache size related properties
---
 arch/arm/boot/dts/zynq-7000.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 605a2d0a39fc..23ba82c205a2 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -15,6 +15,25 @@
 / {
 	compatible = "xlnx,zynq-7000";
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			reg = <0>;
+			clocks = <&clkc 3>;
+		};
+
+		cpu at 1 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			reg = <1>;
+			clocks = <&clkc 3>;
+		};
+	};
+
 	pmu {
 		compatible = "arm,cortex-a9-pmu";
 		interrupts = <0 5 4>, <0 6 4>;
-- 
1.8.4.4
