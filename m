From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 27 Nov 2014 12:20:52 +0100
Subject: [PATCH v4 6/7] mfd/regulator: dt-bindings: max77686: Document gpio
 properties
In-Reply-To: <1417087253-12306-1-git-send-email-k.kozlowski@samsung.com>
References: <1417087253-12306-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1417087253-12306-7-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document usage of ena-gpios properties which turn on external/GPIO
control over regulator.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 Documentation/devicetree/bindings/mfd/max77686.txt | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/max77686.txt b/Documentation/devicetree/bindings/mfd/max77686.txt
index 75fdfaf41831..93c4cd07ffc8 100644
--- a/Documentation/devicetree/bindings/mfd/max77686.txt
+++ b/Documentation/devicetree/bindings/mfd/max77686.txt
@@ -37,8 +37,12 @@ to get matched with their hardware counterparts as follow:
   Regulators which can be turned off during system suspend:
 	-LDOn	:	2, 6-8, 10-12, 14-16,
 	-BUCKn	:	1-4.
-  Use standard regulator bindings for it ('regulator-off-in-suspend').
 
+  Regulators which can be configured for GPIO enable control:
+	-LDOn	:	20, 21, 22
+	-BUCKn	:	8, 9
+  Use standard regulator bindings for these ('regulator-off-in-suspend',
+  'ena-gpios').
 
 Example:
 
@@ -65,4 +69,12 @@ Example:
 				regulator-always-on;
 				regulator-boot-on;
 			};
+
+			buck9_reg {
+				regulator-compatible = "BUCK9";
+				regulator-name = "CAM_ISP_CORE_1.2V";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1200000>;
+				ena-gpios = <&gpm0 3 GPIO_ACTIVE_HIGH>;
+			};
 	}
-- 
1.9.1
