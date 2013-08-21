From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Wed, 21 Aug 2013 09:42:37 +0200
Subject: [PATCH v2] ARM: at91: at91sam9260: add missing pinctrl on mmc
Message-ID: <1377070957-24984-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

pinctrl-names was missing causing mmc pinctrl to never be requested. Moreover,
add minimal pin configuration to not cause error if overloading is forgotten
in board files.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---

v2:
  - add minimal pin configuration

 arch/arm/boot/dts/at91sam9260.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 84c4bef..b4de52a 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -477,6 +477,8 @@
 				interrupts = <9 4 0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_mmc0_clk &pinctrl_mmc0_slot1_cmd_dat0>;
 				status = "disabled";
 			};
 
-- 
1.7.11.3
