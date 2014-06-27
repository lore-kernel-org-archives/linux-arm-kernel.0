From: punnaiah.choudary.kalluri@xilinx.com (Punnaiah Choudary Kalluri)
Date: Fri, 27 Jun 2014 16:53:52 +0530
Subject: [PATCH v2 1/2] usb: chipidea: zynq: Add device tree binding
 information
Message-ID: <6233f866-678d-4a90-a307-debcb848ae76@BN1AFFO11FD023.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document device tree binding information as required by
the ZYNQ USB controller.

Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
---
Changes in v2:
- none
---
 .../devicetree/bindings/usb/ci-hdrc-zynq.txt       |   23 ++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-zynq.txt

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-zynq.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-zynq.txt
new file mode 100644
index 0000000..54bb3b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-zynq.txt
@@ -0,0 +1,23 @@
+Xilinx Zynq usb controller based on synopsys usb IP(v2.20a)
+
+Required properties:
+- compatible:   should contain "xlnx,zynq-usb-2.20a"
+- clocks:       clock provider specifier
+- reg:          offset and length of the register set in the memory map
+- interrupt-parent: the phandle for the interrupt controller that services
+                    interrupts for this device.
+- interrupts:   interrupt-specifier for the controller interrupt.
+- phy_type:     should be "ulpi"
+- dr_mode:      should be "peripheral" or "host"
+
+Examples:
+
+	usb at e0002000 {
+		clocks = <&clkc 28>;
+		compatible = "xlnx,zynq-usb-2.20a";
+		dr_mode = "host";
+		interrupt-parent = <&ps7_scugic_0>;
+		interrupts = <0 21 4>;
+		phy_type = "ulpi";
+		reg = <0xe0002000 0x1000>;
+	} ;
-- 
1.7.4
