From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Sep 2014 09:55:21 +0900
Subject: [PATCH v2 3/3] clocksource: sh_tmu: Document r8a7779 binding
In-Reply-To: <1409792121-28912-1-git-send-email-horms+renesas@verge.net.au>
References: <1409792121-28912-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1409792121-28912-4-git-send-email-horms+renesas@verge.net.au>
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
to update the Renesas R-Car Timer Unit (TMU) driver to follow this
convention.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
* I plan to follow up with a patch patch to use the new binding in the
  dtsi files for the r8a7779 SoC.
commit 471269b790aec03385dc4fb127ed7094ff83c16d

v2
* Suggestions by Mark Rutland and Sergei Shtylyov
  - Compatible strings should be "one or more" not "one" of those listed
  - Describe the generic binding as covering any MTU2 device
  - Re-order compat strings from most to least specific
---
 Documentation/devicetree/bindings/timer/renesas,tmu.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.txt b/Documentation/devicetree/bindings/timer/renesas,tmu.txt
index 425d0c5..f9a9545 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.txt
@@ -8,7 +8,9 @@ are independent. The TMU hardware supports up to three channels.
 
 Required Properties:
 
-  - compatible: must contain "renesas,tmu"
+  - compatible: must contain one or more of the following:
+    - "renesas,tmu-r8a7779" R8A7779 TMU
+    - "renesas,tmu" any TMU
 
   - reg: base address and length of the registers block for the timer module.
 
@@ -27,7 +29,7 @@ Optional Properties:
 Example: R8A7779 (R-Car H1) TMU0 node
 
 	tmu0: timer at ffd80000 {
-		compatible = "renesas,tmu";
+		compatible = "renesas,tmu-r8a7779", "renesas,tmu";
 		reg = <0xffd80000 0x30>;
 		interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 33 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.0.1
