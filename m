From: woogyom.kim@gmail.com (Milo Kim)
Date: Fri,  9 Dec 2016 15:28:32 +0900
Subject: [PATCH 3/4] dt-bindings: power/supply: Update TPS65217 properties
In-Reply-To: <20161209062833.5768-1-woogyom.kim@gmail.com>
References: <20161209062833.5768-1-woogyom.kim@gmail.com>
Message-ID: <20161209062833.5768-4-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add interrupt specifiers for USB and AC charger input. Interrupt numbers
are from the datasheet.
Fix wrong property for compatible string.

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 .../devicetree/bindings/power/supply/tps65217_charger.txt          | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt b/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
index 98d131a..a11072c 100644
--- a/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
+++ b/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
@@ -2,11 +2,16 @@ TPS65217 Charger
 
 Required Properties:
 -compatible: "ti,tps65217-charger"
+-interrupts: TPS65217 interrupt numbers for the AC and USB charger input change.
+             Should be <0> for the USB charger and <1> for the AC adapter.
+-interrupt-names: Should be "USB" and "AC"
 
 This node is a subnode of the tps65217 PMIC.
 
 Example:
 
 	tps65217-charger {
-		compatible = "ti,tps65090-charger";
+		compatible = "ti,tps65217-charger";
+		interrupts = <0>, <1>;
+		interrupt-names = "USB", "AC";
 	};
-- 
2.9.3
