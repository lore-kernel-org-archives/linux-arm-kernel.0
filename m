From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 26 Mar 2018 13:20:43 -0300
Subject: [PATCH v2 2/2] Revert "dt-bindings: ifc: Fix the unit address format
 in the examples"
In-Reply-To: <1522081243-30871-1-git-send-email-festevam@gmail.com>
References: <1522081243-30871-1-git-send-email-festevam@gmail.com>
Message-ID: <1522081243-30871-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

This reverts commit 4e017f1419397473cf3db6e9fa020013998b1aa4.

As explained by Rob Herring:

"This "fix" is wrong. Memory controllers with chip selects should have
the chip select in the unit-address. The correct fix here is you should drop
"simple-bus"."

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Only send the revert patches for now.

 Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt b/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
index a4d4b6a..89427b0 100644
--- a/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
@@ -43,7 +43,7 @@ Example:
 			  0x1 0x0 0x0 0xffa00000 0x00010000
 			  0x3 0x0 0x0 0xffb00000 0x00020000>;
 
-		flash at 0 {
+		flash at 0,0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "cfi-flash";
@@ -58,7 +58,7 @@ Example:
 			};
 		};
 
-		flash at 100000000 {
+		flash at 1,0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "fsl,ifc-nand";
@@ -73,7 +73,7 @@ Example:
 			};
 		};
 
-		cpld@@300000000 {
+		cpld at 3,0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "fsl,p1010rdb-cpld";
-- 
2.7.4
