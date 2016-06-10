From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 11 Jun 2016 00:03:09 +0200
Subject: [PATCH 06/48] ARM: dts: at91: at91sam9260: TC blocks are also
 simple-mfd and syscon devices
In-Reply-To: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1465596231-21766-7-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add simple-mfd and syscon to the TC blocks to allow to register one of the
channels as clocksource properly at boot time. It also allows to use
regmap instead of tclib.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index d4884dd1c243..7b2aa604a924 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -376,7 +376,9 @@
 			};
 
 			tcb0: timer at fffa0000 {
-				compatible = "atmel,at91rm9200-tcb";
+				compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0xfffa0000 0x100>;
 				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0
 					      18 IRQ_TYPE_LEVEL_HIGH 0
@@ -386,7 +388,9 @@
 			};
 
 			tcb1: timer@fffdc000 {
-				compatible = "atmel,at91rm9200-tcb";
+				compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0xfffdc000 0x100>;
 				interrupts = <26 IRQ_TYPE_LEVEL_HIGH 0
 					      27 IRQ_TYPE_LEVEL_HIGH 0
-- 
2.8.1
