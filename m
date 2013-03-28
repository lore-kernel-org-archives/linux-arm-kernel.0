From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 28 Mar 2013 17:38:08 +0100
Subject: [PATCH v3 08/12] arm: zynq: Add support for pmu
In-Reply-To: <1364488692-18709-1-git-send-email-michal.simek@xilinx.com>
References: <1364488692-18709-1-git-send-email-michal.simek@xilinx.com>
Message-ID: <d743f638a40f4b3bb2c4ba78d7296c6815d91003.1364488495.git.michal.simek@xilinx.com>
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
