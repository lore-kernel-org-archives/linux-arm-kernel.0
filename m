From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon,  8 Feb 2016 10:16:07 +0100
Subject: [PATCH 2/6] Documentation: bindings: document the Alpine MSIX driver
In-Reply-To: <1454922971-17405-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1454922971-17405-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1454922971-17405-3-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following the addition of the Alpine MSIX driver, this patch adds the
corresponding bindings documentation.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Signed-off-by: Tsahee Zidenberg <tsahee@annapurnalabs.com>
---
 .../interrupt-controller/al,alpine-msix.txt        | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/al,alpine-msix.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/al,alpine-msix.txt b/Documentation/devicetree/bindings/interrupt-controller/al,alpine-msix.txt
new file mode 100644
index 000000000000..a77d5a76e8d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/al,alpine-msix.txt
@@ -0,0 +1,22 @@
+Alpine MSIX controller
+
+Required properties:
+
+- compatible: should be "al,alpine-msix"
+- reg: physical base address and size of the registers
+- interrupt-controller: identifies the node as an interrupt controller
+- msi-controller: identifies the node as an PCI Message Signaled Interrupt
+		  controller
+- al,msi-base-spi: SPI base of the MSI frame
+- al,msi-num-spis: number of SPIs assigned to the MSI frame
+
+Example:
+
+msix: msix {
+	compatible = "al,alpine-msix";
+	reg = <0x0 0xfbe00000 0x0 0x100000>;
+	interrupt-controller;
+	msi-controller;
+	al,msi-base-spi = <160>;
+	al,msi-num-spis = <160>;
+};
-- 
2.7.0
