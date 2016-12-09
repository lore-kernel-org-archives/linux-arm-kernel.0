From: woogyom.kim@gmail.com (Milo Kim)
Date: Fri,  9 Dec 2016 15:28:33 +0900
Subject: [PATCH 4/4] dt-bindings: input: Specify the interrupt number of
 TPS65217 power button
In-Reply-To: <20161209062833.5768-1-woogyom.kim@gmail.com>
References: <20161209062833.5768-1-woogyom.kim@gmail.com>
Message-ID: <20161209062833.5768-5-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specify the power button interrupt number which is from the datasheet.

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt b/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
index 3e5b979..8682ab6 100644
--- a/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
+++ b/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
@@ -8,8 +8,9 @@ This driver provides a simple power button event via an Interrupt.
 Required properties:
 - compatible: should be "ti,tps65217-pwrbutton" or "ti,tps65218-pwrbutton"
 
-Required properties for TPS65218:
+Required properties:
 - interrupts: should be one of the following
+   - <2>: For controllers compatible with tps65217
    - <3 IRQ_TYPE_EDGE_BOTH>: For controllers compatible with tps65218
 
 Examples:
@@ -17,6 +18,7 @@ Examples:
 &tps {
 	tps65217-pwrbutton {
 		compatible = "ti,tps65217-pwrbutton";
+		interrupts = <2>;
 	};
 };
 
-- 
2.9.3
