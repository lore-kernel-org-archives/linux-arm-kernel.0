From: open.sudheer@gmail.com (sudheer.v)
Date: Wed, 17 Oct 2018 09:41:01 +0530
Subject: [[PATCH] 4/9] Documentation-DTbindings-DMA-controller-of-AST2500
In-Reply-To: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
References: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
Message-ID: <1539749466-3912-5-git-send-email-open.sudheer@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: sudheer.v <open.sudheer@gmail.com>
---
 .../devicetree/bindings/dma/ast-uart-sdma.txt      | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/ast-uart-sdma.txt

diff --git a/Documentation/devicetree/bindings/dma/ast-uart-sdma.txt b/Documentation/devicetree/bindings/dma/ast-uart-sdma.txt
new file mode 100644
index 0000000..e770df2
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ast-uart-sdma.txt
@@ -0,0 +1,23 @@
+* Aspeed Direct Memory Access (DMA) Controller for AST25XX
+
+
+* DMA controller
+
+Required properties:
+- compatible : Should be "aspeed,ast-uart-sdma"
+- reg : Should contain SDMA registers location and length
+- interrupts : Should contain SDMA interrupt
+- dma-channels: number of DMA channels in DMA controller
+
+Optional properties:
+
+Example
+                        ast_uart_sdma: uart_sdma at 1e79e000 {
+                                compatible = "aspeed,ast-uart-sdma";
+                                reg = <0x1e79e000 0x400>;
+                                interrupts = <50>;
+                                #dma-cells = <1>;
+                                dma-channels = <8>;
+                                status = "disabled";
+                        };
+
-- 
1.9.1
