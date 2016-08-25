From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 25 Aug 2016 15:45:04 +0800
Subject: [PATCH v8 11/11] ARM: at91/dt: sama5d2_xplained: Add act8945a-charger
 node.
In-Reply-To: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
References: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1472111104-22477-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add act8945a-charger as a sub-device node.
Use the "interrupts" property, instead of the "active-semi,irq_gpios"
to denote the act8945a chager's irq.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v8:
 - Add 4 new patches: 1/11, 2/11, 9/11, and 11/11.

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 0b9a59d..87eff10 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -162,14 +162,6 @@
 					compatible = "active-semi,act8945a";
 					reg = <0x5b>;
 					active-semi,vsel-high;
-					active-semi,chglev-gpios = <&pioA 12 GPIO_ACTIVE_HIGH>;
-					active-semi,lbo-gpios = <&pioA 72 GPIO_ACTIVE_LOW>;
-					active-semi,irq_gpios = <&pioA 45 GPIO_ACTIVE_LOW>;
-					active-semi,input-voltage-threshold-microvolt = <6600>;
-					active-semi,precondition-timeout = <40>;
-					active-semi,total-timeout = <3>;
-					pinctrl-names = "default";
-					pinctrl-0 = <&pinctrl_charger_chglev &pinctrl_charger_lbo &pinctrl_charger_irq>;
 					status = "okay";
 
 					regulators {
@@ -222,6 +214,21 @@
 							regulator-always-on;
 						};
 					};
+
+					charger {
+						compatible = "active-semi,act8945a-charger";
+						pinctrl-names = "default";
+						pinctrl-0 = <&pinctrl_charger_chglev &pinctrl_charger_lbo &pinctrl_charger_irq>;
+						interrupt-parent = <&pioA>;
+						interrupts = <45 GPIO_ACTIVE_LOW>;
+
+						active-semi,chglev-gpios = <&pioA 12 GPIO_ACTIVE_HIGH>;
+						active-semi,lbo-gpios = <&pioA 72 GPIO_ACTIVE_LOW>;
+						active-semi,input-voltage-threshold-microvolt = <6600>;
+						active-semi,precondition-timeout = <40>;
+						active-semi,total-timeout = <3>;
+						status = "okay";
+					};
 				};
 			};
 
-- 
2.7.4
