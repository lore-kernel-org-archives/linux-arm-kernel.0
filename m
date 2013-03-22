From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 22 Mar 2013 15:42:14 +0100
Subject: [PATCH] ARM: at91/at91sam9x5: add RTC node
Message-ID: <1363963334-21870-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9x5.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index d18aff5..7a32a3f 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -559,6 +559,13 @@
 					trigger-value = <0x6>;
 				};
 			};
+
+			rtc at fffffeb0 {
+				compatible = "atmel,at91rm9200-rtc";
+				reg = <0xfffffeb0 0x40>;
+				interrupts = <1 4 7>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand at 40000000 {
-- 
1.8.0
