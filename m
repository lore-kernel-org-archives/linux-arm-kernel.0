From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 13 Jul 2016 00:45:05 +0200
Subject: [PATCH 1/4] ARM: dts: at91: sama5d3_xplained: fix regulator name
Message-ID: <1468363508-23843-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vcc_mmc0_reg is a fixed regulator and doesn't need a reg property. Remove
its unit-address.

Solves:
Warning (unit_address_vs_reg): Node /fixedregulator at 0 has a unit name, but no reg property

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index f3e2b96c06a3..c51fc652f6c7 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -297,7 +297,7 @@
 		};
 	};
 
-	vcc_mmc0_reg: fixedregulator at 0 {
+	vcc_mmc0_reg: fixedregulator_mmc0 {
 		compatible = "regulator-fixed";
 		gpio = <&pioE 2 GPIO_ACTIVE_LOW>;
 		regulator-name = "mmc0-card-supply";
-- 
2.8.1
