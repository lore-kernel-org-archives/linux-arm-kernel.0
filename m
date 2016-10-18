From: jonathan.richardson@broadcom.com (Jonathan Richardson)
Date: Tue, 18 Oct 2016 12:00:35 -0700
Subject: [PATCH v1 1/4] dt-bindings: Document Broadcom iProc mailbox
 controller driver
In-Reply-To: <1476817238-1226-1-git-send-email-jonathan.richardson@broadcom.com>
References: <1476817238-1226-1-git-send-email-jonathan.richardson@broadcom.com>
Message-ID: <1476817238-1226-2-git-send-email-jonathan.richardson@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
Tested-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
---
 .../bindings/mailbox/brcm,iproc-mailbox.txt          | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,iproc-mailbox.txt

diff --git a/Documentation/devicetree/bindings/mailbox/brcm,iproc-mailbox.txt b/Documentation/devicetree/bindings/mailbox/brcm,iproc-mailbox.txt
new file mode 100644
index 0000000..a40d810
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/brcm,iproc-mailbox.txt
@@ -0,0 +1,20 @@
+* Broadcom's iProc Mailbox Controller
+
+Required properties:
+- compatible: Must be "brcm,iproc-mailbox"
+- reg: Defines the base address of the mailbox controller.
+- interrupts: The mailbox controller's interrupt.
+- #interrupt-cells: Must be 1.
+- interrupt-controller: Sets device as an interrupt controller.
+- #mbox-cells: Must be 1.
+
+Example:
+
+	mailbox: mailbox at 3024024 {
+		compatible = "brcm,iproc-mailbox";
+		reg = <0x03024024 0x40>;
+		interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		#mbox-cells = <1>;
+	};
-- 
1.9.1
