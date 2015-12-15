From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 15 Dec 2015 10:55:59 +0100
Subject: [PATCH v2] ARM: psci: Fix indentation in DT bindings
Message-ID: <1450173359-2261-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix bogus indentation of the PSCI compatible values, reformat.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
v2:
  - Add Acked-by,
  - Align second line with first word after colon,
  - Capitalize "For" after colon,
  - Insert linebreak after first sentence.
---
 Documentation/devicetree/bindings/arm/psci.txt | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
index a9adab84e2feb785..a2c4f1d524929bb7 100644
--- a/Documentation/devicetree/bindings/arm/psci.txt
+++ b/Documentation/devicetree/bindings/arm/psci.txt
@@ -23,17 +23,20 @@ Main node required properties:
 
  - compatible    : should contain at least one of:
 
-				 * "arm,psci" : for implementations complying to PSCI versions prior to
-					0.2. For these cases function IDs must be provided.
-
-				 * "arm,psci-0.2" : for implementations complying to PSCI 0.2. Function
-					IDs are not required and should be ignored by an OS with PSCI 0.2
-					support, but are permitted to be present for compatibility with
-					existing software when "arm,psci" is later in the compatible list.
-
-				* "arm,psci-1.0" : for implementations complying to PSCI 1.0. PSCI 1.0 is
-					backward compatible with PSCI 0.2 with minor specification updates,
-					as defined in the PSCI specification[2].
+     * "arm,psci"     : For implementations complying to PSCI versions prior
+			to 0.2.
+			For these cases function IDs must be provided.
+
+     * "arm,psci-0.2" : For implementations complying to PSCI 0.2.
+			Function IDs are not required and should be ignored by
+			an OS with PSCI 0.2 support, but are permitted to be
+			present for compatibility with existing software when
+			"arm,psci" is later in the compatible list.
+
+     * "arm,psci-1.0" : For implementations complying to PSCI 1.0.
+			PSCI 1.0 is backward compatible with PSCI 0.2 with
+			minor specification updates, as defined in the PSCI
+			specification[2].
 
  - method        : The method of calling the PSCI firmware. Permitted
                    values are:
-- 
1.9.1
