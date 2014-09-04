From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Sep 2014 09:55:20 +0900
Subject: [PATCH v2 2/3] clocksource: sh_mtu2: Document r7s72100 binding
In-Reply-To: <1409792121-28912-1-git-send-email-horms+renesas@verge.net.au>
References: <1409792121-28912-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1409792121-28912-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In general Renesas hardware is not documented to the extent
where the relationship between IP blocks on different SoCs can be assumed
although they may appear to operate the same way. Furthermore the
documentation typically does not specify a version for individual
IP blocks. For these reasons a convention of using the SoC name in place
of a version and providing SoC-specific compat strings has been adopted.

Although not universally liked this convention is used in the bindings
for a number of drivers for Renesas hardware. The purpose of this patch is
to update the Renesas R-Car Multi-Function Timer Pulse Unit 2 (MTU2) driver
to follow this convention.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
* I plan to follow up with a patch patch to use the new binding in the
  dtsi files for the r7s72100 SoC.

v2
* Suggestions by Mark Rutland and Sergei Shtylyov
  - Compatible strings should be "one or more" not "one" of those listed
  - Describe the generic binding as covering any MTU2 device
  - Re-order compat strings from most to least specific
---
 Documentation/devicetree/bindings/timer/renesas,mtu2.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,mtu2.txt b/Documentation/devicetree/bindings/timer/renesas,mtu2.txt
index 917453f..defe2a1 100644
--- a/Documentation/devicetree/bindings/timer/renesas,mtu2.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,mtu2.txt
@@ -8,7 +8,9 @@ are independent. The MTU2 hardware supports five channels indexed from 0 to 4.
 
 Required Properties:
 
-  - compatible: must contain "renesas,mtu2"
+  - compatible: must be one or more of the following:
+    - "renesas,mtu2-r7s72100" for R7S72100 MTU2
+    - "renesas,mtu2" for any MTU2
 
   - reg: base address and length of the registers block for the timer module.
 
@@ -26,7 +28,7 @@ Required Properties:
 Example: R7S72100 (RZ/A1H) MTU2 node
 
 	mtu2: timer at fcff0000 {
-		compatible = "renesas,mtu2";
+		compatible = "renesas,mtu2-r7s72100", "renesas,mtu2";
 		reg = <0xfcff0000 0x400>;
 		interrupts = <0 139 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 146 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.0.1
