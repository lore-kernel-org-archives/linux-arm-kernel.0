From: suneel.garapati@xilinx.com (Suneel Garapati)
Date: Thu, 23 Jul 2015 16:21:49 +0530
Subject: [PATCH 1/2] devicetree: bindings: rtc: add bindings for xilinx zynqmp
 rtc
Message-ID: <1437648710-6857-1-git-send-email-suneel.garapati@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

adds file for description on device node bindings for RTC
found on Xilinx Zynq Ultrascale+ MPSoC.

Signed-off-by: Suneel Garapati <suneel.garapati@xilinx.com>
---
 Documentation/devicetree/bindings/rtc/xlnx-rtc.txt | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/xlnx-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/xlnx-rtc.txt b/Documentation/devicetree/bindings/rtc/xlnx-rtc.txt
new file mode 100644
index 0000000..2b05243
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/xlnx-rtc.txt
@@ -0,0 +1,25 @@
+* Xilinx Zynq Ultrascale+ MPSoC Real Time Clock
+
+RTC controller for the Xilinx Zynq MPSoC Real Time Clock
+Separate IRQ lines for seconds and alarm
+
+Required properties:
+- compatible: Should be "xlnx,zynqmp-rtc"
+- reg: Physical base address of the controller and length
+       of memory mapped region.
+- interrupts: IRQ lines for the RTC.
+- interrupt names: Names for interrupt lines
+
+Optional:
+- calibration: calibration value for 1 sec period which will
+		be programmed directly to calibration register
+
+Example:
+rtc: rtc at ffa60000 {
+	compatible = "xlnx,zynqmp-rtc";
+	reg = <0x0 0xffa60000 0x100>;
+	interrupt-parent = <&gic>;
+	interrupts = <0 26 4>, <0 27 4>;
+	interrupt-names = "alm", "sec";
+	calibration = <0x198233>;
+};
--
2.1.2
