From: jiri.prchal@aksignal.cz (Jiri Prchal)
Date: Thu, 19 Sep 2013 14:33:36 +0200
Subject: [PATCH] at91: serial: sam9g25: add usart3 to dtsi
Message-ID: <1379594016-9408-1-git-send-email-jiri.prchal@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hope it should be in g25 because not all x5 socs have usart3.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
 arch/arm/boot/dts/at91sam9g25.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9g25.dtsi b/arch/arm/boot/dts/at91sam9g25.dtsi
index b4ec6fe..ba0966f 100644
--- a/arch/arm/boot/dts/at91sam9g25.dtsi
+++ b/arch/arm/boot/dts/at91sam9g25.dtsi
@@ -12,6 +12,10 @@
 	model = "Atmel AT91SAM9G25 SoC";
 	compatible = "atmel,at91sam9g25", "atmel,at91sam9x5";
 
+	aliases {
+		serial4 = &usart3;
+	};
+
 	ahb {
 		apb {
 			pinctrl at fffff400 {
@@ -23,6 +27,16 @@
 				       0x003fffff 0x003f8000 0x00000000  /* pioD */
 				      >;
 			};
+
+			usart3: serial at f8028000 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xf8028000 0x200>;
+				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_usart3>;
+				status = "disabled";
+			};
+
 		};
 	};
 };
-- 
1.7.9.5
