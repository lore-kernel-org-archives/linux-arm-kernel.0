From: sravanhome@gmail.com (Saravanan Sekar)
Date: Thu, 28 Jun 2018 21:18:05 +0200
Subject: [PATCH v2 3/3] dt-bindings: clock: Modify Actions Soc clock bindings
In-Reply-To: <20180628191805.3722-1-sravanhome@gmail.com>
References: <20180626192820.28237-3-sravanhome@gmail.com>
 <20180628191805.3722-1-sravanhome@gmail.com>
Message-ID: <20180628191805.3722-4-sravanhome@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modify clock bindings common Actions Semi Soc family S700/S900.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 ...tions,s900-cmu.txt => actions,sx00-cmu.txt} | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)
 rename Documentation/devicetree/bindings/clock/{actions,s900-cmu.txt => actions,sx00-cmu.txt} (71%)

diff --git a/Documentation/devicetree/bindings/clock/actions,s900-cmu.txt b/Documentation/devicetree/bindings/clock/actions,sx00-cmu.txt
similarity index 71%
rename from Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
rename to Documentation/devicetree/bindings/clock/actions,sx00-cmu.txt
index 93e4fb827cd6..8dc7edb4d198 100644
--- a/Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
+++ b/Documentation/devicetree/bindings/clock/actions,sx00-cmu.txt
@@ -1,12 +1,14 @@
-* Actions S900 Clock Management Unit (CMU)
+* Actions S900/S700 Clock Management Unit (CMU)
 
-The Actions S900 clock management unit generates and supplies clock to various
-controllers within the SoC. The clock binding described here is applicable to
-S900 SoC.
+The Actions S900/S700 clock management unit generates and supplies clock to
+various controllers within the SoC. The clock binding described here is
+applicable to S900/S700 SoC.
 
 Required Properties:
 
-- compatible: should be "actions,s900-cmu"
+- compatible: should be one of this
+	"actions,s900-cmu"
+	"actions,s700-cmu"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - clocks: Reference to the parent clocks ("hosc", "losc")
@@ -15,9 +17,9 @@ Required Properties:
 Each clock is assigned an identifier, and client nodes can use this identifier
 to specify the clock which they consume.
 
-All available clocks are defined as preprocessor macros in
-dt-bindings/clock/actions,s900-cmu.h header and can be used in device
-tree sources.
+All available clocks are defined as preprocessor macros in corresponding
+dt-bindings/clock/actions,s900-cmu.h or s700-cmu.h header and can be used in
+device tree sources.
 
 External clocks:
 
-- 
2.18.0
