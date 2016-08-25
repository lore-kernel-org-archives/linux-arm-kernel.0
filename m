From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 25 Aug 2016 15:38:35 +0800
Subject: [PATCH v8 09/11] doc: bindings: mfd: act8945a: Update the example
In-Reply-To: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
References: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1472110715-22242-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the act8945a-charger is regarded as a sub-device and it using
"interrupts" property, update the examples section.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/mfd/act8945a.txt | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/act8945a.txt b/Documentation/devicetree/bindings/mfd/act8945a.txt
index f712830..462819a 100644
--- a/Documentation/devicetree/bindings/mfd/act8945a.txt
+++ b/Documentation/devicetree/bindings/mfd/act8945a.txt
@@ -14,13 +14,6 @@ Example:
 		reg = <0x5b>;
 		status = "okay";
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_charger_chglev>;
-		active-semi,chglev-gpio = <&pioA 12 GPIO_ACTIVE_HIGH>;
-		active-semi,input-voltage-threshold-microvolt = <6600>;
-		active-semi,precondition-timeout = <40>;
-		active-semi,total-timeout = <3>;
-
 		active-semi,vsel-high;
 
 		regulators {
@@ -73,4 +66,19 @@ Example:
 				regulator-always-on;
 			};
 		};
+
+		charger {
+			compatible = "active-semi,act8945a-charger";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_charger_chglev &pinctrl_charger_lbo &pinctrl_charger_irq>;
+			interrupt-parent = <&pioA>;
+			interrupts = <45 GPIO_ACTIVE_LOW>;
+
+			active-semi,chglev-gpios = <&pioA 12 GPIO_ACTIVE_HIGH>;
+			active-semi,lbo-gpios = <&pioA 72 GPIO_ACTIVE_LOW>;
+			active-semi,input-voltage-threshold-microvolt = <6600>;
+			active-semi,precondition-timeout = <40>;
+			active-semi,total-timeout = <3>;
+			status = "okay";
+		};
 	};
-- 
2.7.4
