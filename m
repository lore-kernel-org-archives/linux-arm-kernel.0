From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 13 Jun 2014 15:43:21 +0200
Subject: [PATCH 3/3] ARM: at91/dt: sam9261: correctly define mainck
In-Reply-To: <1402667001-11207-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1402667001-11207-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1402667001-11207-4-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mainck (CKGR_MCFR register) is actually using main_osc (CKGR_MOR register).

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9261.dtsi | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index b309c1c6e848..9de312e9bb3e 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -581,13 +581,19 @@
 					clocks = <&slow_rc_osc &slow_xtal>;
 				};
 
-				main: mainck {
-					compatible = "atmel,at91rm9200-clk-main";
+				main_osc: main_osc {
+					compatible = "atmel,at91rm9200-clk-main-osc";
 					#clock-cells = <0>;
 					interrupts-extended = <&pmc AT91_PMC_MOSCS>;
 					clocks = <&main_xtal>;
 				};
 
+				main: mainck {
+					compatible = "atmel,at91rm9200-clk-main";
+					#clock-cells = <0>;
+					clocks = <&main_osc>;
+				};
+
 				plla: pllack {
 					compatible = "atmel,at91rm9200-clk-pll";
 					#clock-cells = <0>;
-- 
1.9.1
