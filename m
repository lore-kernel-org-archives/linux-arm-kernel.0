From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed, 21 Nov 2018 09:06:46 +0530
Subject: [PATCH v2 09/15] dt-bindings: timer: Document RDA8810PL SoC timer
In-Reply-To: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20181121033652.12247-10-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document RDA Micro RDA8810PL SoC timer.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/timer/rda,8810pl-timer.txt       | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt b/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
new file mode 100644
index 000000000000..06cc2b00be12
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
@@ -0,0 +1,21 @@
+RDA Micro RDA8810PL Timer
+
+Required properties:
+- compatible      :  "rda,8810pl-timer"
+- reg             :  Offset and length of the register set for the device.
+- interrupts      :  Should contain the interrupts.
+- interrupt-names :  Valid names are: "hwtimer", "ostimer".
+                     See ../resource-names.txt
+
+Example:
+
+		apb at 20900000 {
+			compatible = "simple-bus";
+			...
+			timer at 10000 {
+				compatible = "rda,8810pl-timer";
+				reg = <0x10000 0x1000>;
+				interrupts = <16 IRQ_TYPE_LEVEL_HIGH>,
+					     <17 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "hwtimer", "ostimer";
+			};
-- 
2.17.1
