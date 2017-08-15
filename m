From: wenyou.yang@microchip.com (Wenyou Yang)
Date: Tue, 15 Aug 2017 14:24:20 +0800
Subject: [PATCH] ARM: dts: at91: sama5d2_xplained: Add charger node
Message-ID: <20170815062420.21644-1-wenyou.yang@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wenyou Yang <wenyou.yang@atmel.com>

Add the charger device node as a sub-device of act8945a mfd, move
the charger's properties in the node, and replace the
"active-semi,irq_gpios" with the "interrupts" property to denote
the act8945a charger's irq.

Signed-off-by: Wenyou Yang <wenyou.yang@microchip.com>
---

 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 2e2c3d1a1fa2..2a0f5f41260f 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -160,14 +160,6 @@
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
@@ -220,6 +212,21 @@
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
2.13.0
