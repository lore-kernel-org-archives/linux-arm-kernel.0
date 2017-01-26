From: jonathan.richardson@broadcom.com (Jonathan Richardson)
Date: Wed, 25 Jan 2017 16:26:59 -0800
Subject: [PATCH v3 1/4] dt-bindings: Document Broadcom iProc mailbox
 controller driver
In-Reply-To: <1485390422-3984-1-git-send-email-jonathan.richardson@broadcom.com>
References: <1485390422-3984-1-git-send-email-jonathan.richardson@broadcom.com>
Message-ID: <1485390422-3984-2-git-send-email-jonathan.richardson@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding document for brcm,iproc-mailbox.

Reviewed-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
Tested-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
---
 .../devicetree/bindings/mailbox/brcm,iproc-mailbox.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,iproc-mailbox.txt

diff --git a/Documentation/devicetree/bindings/mailbox/brcm,iproc-mailbox.txt b/Documentation/devicetree/bindings/mailbox/brcm,iproc-mailbox.txt
new file mode 100644
index 0000000..a832feb
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/brcm,iproc-mailbox.txt
@@ -0,0 +1,18 @@
+* Broadcom's iProc Mailbox Controller
+
+Broadcom iProc architected SoC's have an always on Cortex-M0 MCU processor that
+handles support for power, clock, and reset management. The iProc mailbox
+controller handles all communication with this processor.
+
+Required properties:
+- compatible: Must be "brcm,iproc-mailbox"
+- reg: Defines the base address of the mailbox controller.
+- #mbox-cells: Must be 1.
+
+Example:
+
+	mailbox: mailbox at 3024024 {
+		compatible = "brcm,iproc-mailbox";
+		reg = <0x03024024 0x8>;
+		#mbox-cells = <1>;
+	};
-- 
1.9.1
