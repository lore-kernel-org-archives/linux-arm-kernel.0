From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri,  8 Nov 2013 13:21:12 -0800
Subject: [PATCH 2/7] arm: dt: zynq: Add 'cpus' node
In-Reply-To: <1383945677-29674-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1383945677-29674-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1383945677-29674-3-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a 'cpus' node to describe the CPU cores of Zynq.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Acked-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
---
 arch/arm/boot/dts/zynq-7000.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 27ebc1ba9671..37fc04525142 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -15,6 +15,33 @@
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
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <0x20>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <0x20>;
+		};
+
+		cpu at 1 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			reg = <1>;
+			clocks = <&clkc 3>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <0x20>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <0x20>;
+		};
+	};
+
 	pmu {
 		compatible = "arm,cortex-a9-pmu";
 		interrupts = <0 5 4>, <0 6 4>;
-- 
1.8.4.2
