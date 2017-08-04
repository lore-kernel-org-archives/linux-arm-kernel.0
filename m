From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  4 Aug 2017 12:29:53 +0200
Subject: [PATCH 1/2] devicetree: ARM: zynq: Add DT binding for eFuse controller
Message-ID: <4b4bfaad88f16d7229bf3da58be8f50f9d82a461.1501842586.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT binding for eFuse controller available at Xilinx Zynq
SoC.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
---

 Documentation/devicetree/bindings/arm/zynq/zynq-efuse.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/zynq/zynq-efuse.txt

diff --git a/Documentation/devicetree/bindings/arm/zynq/zynq-efuse.txt b/Documentation/devicetree/bindings/arm/zynq/zynq-efuse.txt
new file mode 100644
index 000000000000..39817e9750c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/zynq/zynq-efuse.txt
@@ -0,0 +1,15 @@
+Device tree bindings for Zynq's eFuse Controller
+
+The Zynq eFuse controller provides the access to the chip efuses which contain
+information about device DNA, security settings and also device status.
+
+Required properties:
+ compatible: Compatibility string. Must be "xlnx,zynq-efuse".
+ reg: Specify the base and size of the EFUSE controller registers
+      in the memory map. E.g.: reg = <0xf800d000 0x20>;
+
+Example:
+efuse: efuse at f800d000 {
+	compatible = "xlnx,zynq-efuse";
+	reg = <0xf800d000 0x20>;
+};
-- 
1.9.1
