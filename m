From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Fri,  4 Sep 2015 09:41:47 +0000
Subject: [PATCH v5 3/6] dt/bindings: bcm2835: add binding documentation for
 bcm2835-aux
In-Reply-To: <1441359711-2800-1-git-send-email-kernel@martin.sperl.org>
References: <1441359711-2800-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1441359711-2800-4-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

add binding documentation

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 .../bindings/soc/bcm/brcm,bcm2835-aux.txt          |   27 ++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-aux.txt

diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-aux.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-aux.txt
new file mode 100644
index 0000000..8b79cf3
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-aux.txt
@@ -0,0 +1,27 @@
+Broadcom BCM2835 auxiliar device enable register
+
+the BCM2835 contains 3 auxiliar devices (spi1/spi2/uart1)
+which need to get enabled via a shared register.
+
+Required properties:
+- compatible: Should be "brcm,bcm2835-aux".
+- reg: Should contain register location and length for the
+       enable register
+
+Example:
+
+aux_enable: aux_enable at 0x7e215004 {
+	compatible = "bcrm,bcm2835-aux";
+	reg = <0x7e215004 0x04>;
+};
+
+Typically used in the respective auxiliar device descriptions
+like this:
+
+uart1: uart at 7e215040 {
+	...
+	brcm,aux-enable = <&aux_enable 1>;
+	...
+};
+
+The name of the property can be device/driver specific.
--
1.7.10.4
