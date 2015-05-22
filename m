From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Fri, 22 May 2015 11:03:10 -0700
Subject: [PATCHv1 1/2] dts: Adding docs for Xilinx LogiCORE IP mailbox driver.
In-Reply-To: <1432317791-26851-1-git-send-email-moritz.fischer@ettus.com>
References: <1432317791-26851-1-git-send-email-moritz.fischer@ettus.com>
Message-ID: <1432317791-26851-2-git-send-email-moritz.fischer@ettus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
---
 .../bindings/mailbox/xilinx-mailbox.txt         | 40 ++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt b/Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt
new file mode 100644
index 0000000..b735105
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt
@@ -0,0 +1,40 @@
+Xilinx Mailbox Driver
+=====================
+
+Required properties:
+- compatible       : "xlnx,mailbox-2.1".
+- reg              :  physical base address of the mailbox and length of
+                      memory mapped region.
+- #mbox-cells      :  Common mailbox binding property to identify the number
+                      of cells required for the mailbox specifier. Should be 1.
+
+Optional properties:
+- interrupt-parent : interrupt source phandle.
+- interrupts       : interrupt number. The interrupt specifier format
+                     depends on the interrupt controller parent.
+
+Example:
+	mbox: mailbox at 40400000 {
+		compatible = "xlnx,axi-mailbox-2.1";
+		reg = <0x40400000 0x3c>;
+		interrupt-parent = <&intc>;
+		interrupts = <5>;
+		#mbox-cells = <1>;
+	};
+
+Mailbox client
+===============
+"mboxes" and the optional "mbox-names" (please see
+Documentation/devicetree/bindings/mailbox/mailbox.txt for details). Each value
+of the mboxes property should contain a phandle to the mailbox controller
+device node and second argument is the channel index. It must be 0 (hardware
+support only one channel). The equivalent "mbox-names" property value can be
+used to give a name to the communication channel to be used by the client user.
+
+Example:
+	mclient0: mclient0 at 400 {
+		compatible = "client-1.0";
+		reg = <0x400 0x10>;
+		mbox-names = "mbox";
+		mboxes = <&mbox 0>;
+	};
-- 
2.4.1
