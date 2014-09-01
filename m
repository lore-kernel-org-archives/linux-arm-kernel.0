From: gael.portay@gmail.com (=?UTF-8?q?Ga=C3=ABl=20PORTAY?=)
Date: Mon,  1 Sep 2014 23:29:46 +0200
Subject: [PATCH] ARM: at91/dt: sam9g20: set at91sam9g20 pllb driver
Message-ID: <1409606986-32455-1-git-send-email-gael.portay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The at91sam9g20 SOC uses its own pllb implementation which is different
from the one inherited from at91sam9260 SOC.

Signed-off-by: Ga?l PORTAY <gael.portay@gmail.com>
---
 arch/arm/boot/dts/at91sam9g20.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index 31f7652..4e0abbd 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -40,6 +40,7 @@
 				};
 
 				pllb: pllbck {
+					compatible = "atmel,at91sam9g20-clk-pllb";
 					atmel,clk-input-range = <2000000 32000000>;
 					atmel,pll-clk-output-ranges = <30000000 100000000 0 0>;
 				};
-- 
1.9.3
