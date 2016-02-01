From: sushaanth.s@ti.com (Sushaanth Srirangapathi)
Date: Mon, 1 Feb 2016 11:58:48 +0530
Subject: [PATCH 1/3] Input: tps6507x-ts - add support for tps6507x-ts
In-Reply-To: <1454308130-12452-1-git-send-email-sushaanth.s@ti.com>
References: <1454308130-12452-1-git-send-email-sushaanth.s@ti.com>
Message-ID: <1454308130-12452-3-git-send-email-sushaanth.s@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add binding information for tps6507x touchscreen input.

Signed-off-by: Sushaanth Srirangapathi <sushaanth.s@ti.com>
---
 Documentation/devicetree/bindings/mfd/tps6507x.txt |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/tps6507x.txt b/Documentation/devicetree/bindings/mfd/tps6507x.txt
index 8fffa3c..74c768b 100644
--- a/Documentation/devicetree/bindings/mfd/tps6507x.txt
+++ b/Documentation/devicetree/bindings/mfd/tps6507x.txt
@@ -23,6 +23,8 @@ Required properties:
        vindcdc1_2-supply: VDCDC1 and VDCDC2 input.
        vindcdc3-supply  : VDCDC3 input.
        vldo1_2-supply   : VLDO1 and VLDO2 input.
+- touchscreen: This is child node which specify touchscreen
+  properties.
 
 Regulator Optional properties:
 - defdcdc_default: It's property of DCDC2 and DCDC3 regulators.
@@ -30,6 +32,12 @@ Regulator Optional properties:
 			1: If defdcdc pin of DCDC2/DCDC3 is driven HIGH.
   If this property is not defined, it defaults to 0 (not enabled).
 
+Touchscreen Optional properties:
+- ti,min-pressure : pressure level above which the event is considered as a
+		    valid touch.
+This binding was not added as a generic binding because there was no driver
+using such a property.
+
 Example:
 
 	pmu: tps6507x at 48 {
@@ -87,5 +95,7 @@ Example:
 				regulator-boot-on;
 			};
 		};
-
+		touchscreen {
+			ti,min-pressure = <0x30>;
+		};
 	};
-- 
1.7.9.5
