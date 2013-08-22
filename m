From: punit.agrawal@arm.com (Punit Agrawal)
Date: Thu, 22 Aug 2013 16:02:26 +0100
Subject: [Patch v3 1/3] ARM: dts: Improve CCI bindings documentation.
In-Reply-To: <1377183748-5717-1-git-send-email-punit.agrawal@arm.com>
References: <1377183748-5717-1-git-send-email-punit.agrawal@arm.com>
Message-ID: <1377183748-5717-2-git-send-email-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Improve the description of the value types used in the CCI binding.

Cc: devicetree at vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 Documentation/devicetree/bindings/arm/cci.txt |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cci.txt b/Documentation/devicetree/bindings/arm/cci.txt
index 92d36e2..024c03d 100644
--- a/Documentation/devicetree/bindings/arm/cci.txt
+++ b/Documentation/devicetree/bindings/arm/cci.txt
@@ -36,14 +36,18 @@ specific to ARM.
 
 	- reg
 		Usage: required
-		Value type: <prop-encoded-array>
+		Value type: Integer cells. A register entry, expressed as a pair
+			    of cells, containing base and size.
 		Definition: A standard property. Specifies base physical
 			    address of CCI control registers common to all
 			    interfaces.
 
 	- ranges:
 		Usage: required
-		Value type: <prop-encoded-array>
+		Value type: Integer cells. An array of range entries, expressed
+			    as a tuple of cells, containing child address,
+			    parent address and the size of the region in the
+			    child address space.
 		Definition: A standard property. Follow rules in the ePAPR for
 			    hierarchical bus addressing. CCI interfaces
 			    addresses refer to the parent node addressing
@@ -74,7 +78,9 @@ specific to ARM.
 
 		- reg:
 			Usage: required
-			Value type: <prop-encoded-array>
+			Value type: Integer cells. A register entry, expressed
+				    as a pair of cells, containing base and
+				    size.
 			Definition: the base address and size of the
 				    corresponding interface programming
 				    registers.
-- 
1.7.10.4
