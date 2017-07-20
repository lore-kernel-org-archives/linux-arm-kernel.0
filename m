From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 20 Jul 2017 15:33:16 +0200
Subject: [PATCH] arm: zynq: Label whole PL part as fpga_full region
Message-ID: <226ad80923aeb24a1654db8414378db08381d10f.1500557594.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will simplify dt overlay structure for the whole PL.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-7000.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index f3ac9bfe580e..0f79fe1ccd9d 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -42,6 +42,14 @@
 		};
 	};
 
+	fpga_full: fpga-full {
+		compatible = "fpga-region";
+		fpga-mgr = <&devcfg>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+	};
+
 	pmu at f8891000 {
 		compatible = "arm,cortex-a9-pmu";
 		interrupts = <0 5 4>, <0 6 4>;
-- 
1.9.1
