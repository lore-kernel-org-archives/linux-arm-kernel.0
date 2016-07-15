From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 15 Jul 2016 11:25:14 +0200
Subject: [PATCH 1/7] ARM: dts: at91: ariag25 : fix onewire node
Message-ID: <1468574720-24296-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the unit-address from the oneiwire node as it doesn't have a reg
property.

Solves:
Warning (unit_address_vs_reg): Node /onewire at 0 has a unit name, but no reg property

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-ariag25.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-ariag25.dts b/arch/arm/boot/dts/at91-ariag25.dts
index f16a9b85a450..4da011a7a698 100644
--- a/arch/arm/boot/dts/at91-ariag25.dts
+++ b/arch/arm/boot/dts/at91-ariag25.dts
@@ -169,7 +169,7 @@
 
 	};
 
-	onewire at 0 {
+	onewire {
 		compatible = "w1-gpio";
 		gpios = <&pioA 21 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
-- 
2.8.1
