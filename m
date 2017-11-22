From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 22 Nov 2017 16:42:03 +0200
Subject: [PATCH 1/3] dt-bindings: thermal/armada: describe AP806 and CP110
Message-ID: <7102bb32704ac9f70ef3ae61682d50de8af61b57.1511361725.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add compatible strings for AP806 and CP110 that are part of the Armada 8k/7k
line of SoCs.

Add a note on the difference in the size of the control area in different
bindings. This is an existing difference between the Armada 375 binding and
the rest. The new AP806 and CP110 bindings are similar to the existing Armada
375 in this regard.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 Documentation/devicetree/bindings/thermal/armada-thermal.txt | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
index 24aacf8948c5..5ec944d4138b 100644
--- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
@@ -7,12 +7,20 @@ Required properties:
 		marvell,armada375-thermal
 		marvell,armada380-thermal
 		marvell,armadaxp-thermal
+		marvell,armada-ap806-thermal
+		marvell,armada-cp110-thermal
 
 - reg:		Device's register space.
 		Two entries are expected, see the examples below.
 		The first one is required for the sensor register;
-		the second one is required for the control register
+		the second one is required for the control area
 		to be used for sensor initialization (a.k.a. calibration).
+		The size of the control area must be 4 for
+		marvell,armada370-thermal, marvell,armada380-thermal, and
+		marvell,armadaxp-thermal. The size must be 8 for
+		marvell,armada375-thermal, marvell,armada-ap806-thermal, and
+		marvell,armada-cp110-thermal.
+
 
 Example:
 
-- 
2.15.0
