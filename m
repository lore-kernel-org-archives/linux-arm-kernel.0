From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 30 Oct 2014 12:20:41 +0100
Subject: [PATCH v3 02/14] mfd/regulator: dt-bindings: max77686: Document
 of_compatible for regulator
In-Reply-To: <1414668053-31370-1-git-send-email-k.kozlowski@samsung.com>
References: <1414668053-31370-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1414668053-31370-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document new required property for regulator driver: of_compatible. The
property allows MFD core to bind the driver to node with regulators and
this simplifies parsing regulators init data from DTS

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 Documentation/devicetree/bindings/mfd/max77686.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/max77686.txt b/Documentation/devicetree/bindings/mfd/max77686.txt
index 75fdfaf41831..f4010a9f66eb 100644
--- a/Documentation/devicetree/bindings/mfd/max77686.txt
+++ b/Documentation/devicetree/bindings/mfd/max77686.txt
@@ -18,8 +18,11 @@ Required properties:
 
 Optional node:
 - voltage-regulators : The regulators of max77686 have to be instantiated
-  under subnode named "voltage-regulators" using the following format.
+  under subnode named "voltage-regulators".
+  Required property:
+  - compatible : Must be "maxim,max77686-pmic"
 
+  Optional properties: For each regulator use following format:
 	regulator_name {
 		regulator-compatible = LDOn/BUCKn
 		standard regulator constraints....
@@ -49,6 +52,8 @@ Example:
 		reg = <0x09>;
 
 		voltage-regulators {
+			compatible = "maxim,max77686-pmic";
+
 			ldo11_reg {
 				regulator-compatible = "LDO11";
 				regulator-name = "vdd_ldo11";
-- 
1.9.1
