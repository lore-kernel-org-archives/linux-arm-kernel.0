From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 12 Mar 2017 00:13:50 +0100
Subject: [PATCH 1/4] irqchip: augment Gemini bindings to reflect Faraday origin
Message-ID: <20170311231350.15857-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we merged the Gemini interrupt controller it was not yet
discovered that this IP block is actually a standard Faraday
Technology interrupt controller.

As the IP block will probably appear in other designs as well,
let's augment the DT bindings to reflect that it is first and
foremost a standard Faraday part with a function name (FTINTC010)
so that people reusing the IP easily find the driver they need.

Sorry for the mistakes due to lack of information.

Greentime Hu <green.hu@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 ...,gemini-interrupt-controller.txt => faraday,ftintc010.txt} | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)
 rename Documentation/devicetree/bindings/interrupt-controller/{cortina,gemini-interrupt-controller.txt => faraday,ftintc010.txt} (63%)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/cortina,gemini-interrupt-controller.txt b/Documentation/devicetree/bindings/interrupt-controller/faraday,ftintc010.txt
similarity index 63%
rename from Documentation/devicetree/bindings/interrupt-controller/cortina,gemini-interrupt-controller.txt
rename to Documentation/devicetree/bindings/interrupt-controller/faraday,ftintc010.txt
index 97c1167fa533..24428d47f487 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/cortina,gemini-interrupt-controller.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/faraday,ftintc010.txt
@@ -1,9 +1,12 @@
-* Cortina Systems Gemini interrupt controller
+* Faraday Technologt FTINTC010 interrupt controller
 
-This interrupt controller is found on the Gemini SoCs.
+This interrupt controller is a stock IP block from Faraday Technology found
+in the Gemini SoCs and other designs.
 
 Required properties:
-- compatible: must be "cortina,gemini-interrupt-controller"
+- compatible: must be one of
+  "faraday,ftintc010"
+  "cortina,gemini-interrupt-controller" (deprecated)
 - reg: The register bank for the interrupt controller.
 - interrupt-controller: Identifies the node as an interrupt controller
 - #interrupt-cells: The number of cells to define the interrupts.
@@ -15,7 +18,7 @@ Required properties:
 Example:
 
 interrupt-controller at 48000000 {
-	compatible = "cortina,gemini-interrupt-controller";
+	compatible = "faraday,ftintc010"
 	reg = <0x48000000 0x1000>;
 	interrupt-controller;
 	#interrupt-cells = <2>;
-- 
2.9.3
