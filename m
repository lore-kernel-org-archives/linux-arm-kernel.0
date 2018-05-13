From: hernan@vanguardiasur.com.ar (=?UTF-8?q?Hern=C3=A1n=20Gonzalez?=)
Date: Sun, 13 May 2018 20:22:04 -0300
Subject: [PATCH] ARM: dts: at91-sama5d2_xplained: Use IRQ_TYPE specifier
Message-ID: <1526253724-3596-1-git-send-email-hernan@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO_ACTIVE_LOW was being used to specify an interrupt, use
IRQ_TYPE_EDGE_RISING instead. This improves DT readability.

Signed-off-by: Hern?n Gonzalez <hernan@vanguardiasur.com.ar>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index e4bbb7e..fcc85d7 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -232,7 +232,7 @@
 						pinctrl-names = "default";
 						pinctrl-0 = <&pinctrl_charger_chglev &pinctrl_charger_lbo &pinctrl_charger_irq>;
 						interrupt-parent = <&pioA>;
-						interrupts = <PIN_PB13 GPIO_ACTIVE_LOW>;
+						interrupts = <PIN_PB13 IRQ_TYPE_EDGE_RISING>;
 
 						active-semi,chglev-gpios = <&pioA PIN_PA12 GPIO_ACTIVE_HIGH>;
 						active-semi,lbo-gpios = <&pioA PIN_PC8 GPIO_ACTIVE_LOW>;
-- 
2.7.4
