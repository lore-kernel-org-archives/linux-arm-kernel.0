From: jolly.shah@xilinx.com (Jolly Shah)
Date: Wed, 17 Jan 2018 12:20:31 -0800
Subject: [PATCH v2 1/4] dt-bindings: firmware: Add bindings for ZynqMP firmware
In-Reply-To: <1516220434-22204-1-git-send-email-jollys@xilinx.com>
References: <1516220434-22204-1-git-send-email-jollys@xilinx.com>
Message-ID: <1516220434-22204-2-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation to describe Xilinx ZynqMP firmware driver
bindings. Firmware driver provides an interface to firmware
APIs. Interface APIs can be used by any driver to communicate
to PMUFW (Platform Management Unit).

Signed-off-by: Jolly Shah <jollys@xilinx.com>
Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
---
 .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
new file mode 100644
index 0000000..a7aaf56
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -0,0 +1,16 @@
+Xilinx Zynq MPSoC Firmware Device Tree Bindings
+
+The zynqmp-firmware node describes the interface to platform firmware.
+
+Required properties:
+ - compatible: Must contain:  "xlnx,zynqmp-firmware"
+ - method:     The method of calling the PM-API firmware layer.
+               Permitted values are:
+                - "smc" : To be used in configurations without a hypervisor
+                - "hvc" : To be used when hypervisor is present
+
+Examples:
+       zynqmp_firmware: zynqmp-firmware {
+               compatible = "xlnx,zynqmp-firmware";
+               method = "smc";
+       };
--
2.7.4

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
