From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 20 Jul 2017 14:17:06 +0200
Subject: [PATCH 07/10] arm64: zynqmp: Add support for RTC
In-Reply-To: <cover.1500552941.git.michal.simek@xilinx.com>
References: <cover.1500552941.git.michal.simek@xilinx.com>
Message-ID: <54962e4d16d6566b8d25a479868ec0edfe5f3bc6.1500552941.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for RTC.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index e7d1815c114b..1272fa6d4f99 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -300,6 +300,16 @@
 			};
 		};
 
+		rtc: rtc at ffa60000 {
+			compatible = "xlnx,zynqmp-rtc";
+			status = "disabled";
+			reg = <0x0 0xffa60000 0x0 0x100>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 26 4>, <0 27 4>;
+			interrupt-names = "alarm", "sec";
+			calibration = <0x8000>;
+		};
+
 		sata: ahci at fd0c0000 {
 			compatible = "ceva,ahci-1v84";
 			status = "disabled";
-- 
1.9.1
