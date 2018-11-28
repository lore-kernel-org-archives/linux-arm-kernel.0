From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed, 28 Nov 2018 19:21:03 +0530
Subject: [PATCH v3 12/15] dt-bindings: serial: Document RDA Micro UART
In-Reply-To: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
References: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20181128135106.9255-13-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andreas F?rber <afaerber@suse.de>

Add an initial binding for the UART in RDA Micro RDA8810PL SoC.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/serial/rda,8810pl-uart.txt           | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt b/Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
new file mode 100644
index 000000000000..ee03116d7415
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
@@ -0,0 +1,15 @@
+RDA Micro UART
+
+Required properties:
+- compatible :  "rda,8810pl-uart" for RDA8810PL SoCs.
+- reg        :  Offset and length of the register set for the device.
+- interrupts :  Should contain UART interrupt.
+
+
+Example:
+
+		uart2: serial at 20a90000 {
+			compatible = "rda,8810pl-uart";
+			reg = <0x20a90000 0x1000>;
+			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
+		};
-- 
2.17.1
