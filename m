From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Mon, 9 Oct 2017 19:09:25 +0300
Subject: [PATCH 03/15] ARM: dts: at91: sama5d27_som1_ek: update serial aliases
In-Reply-To: <1507565377-1545-1-git-send-email-claudiu.beznea@microchip.com>
References: <1507565377-1545-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1507565377-1545-4-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Overwrite sama5d2.dtsi aliases node to match the at91-sama5d27_som1_ek
board configuration. ttyS0 stands for DBGU, ttyS1 for the mikro BUS 1
serial lines and ttyS2 for the mikro BUS 2 serial lines.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
[claudiu.beznea at microchip.com: change subject to match the desired prefix]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
index 03a4c77fd6ab..b31778121c41 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -53,6 +53,12 @@
 	model = "Atmel SAMA5D27 SOM1 EK";
 	compatible = "atmel,sama5d27-som1-ek", "atmel,sama5d27-som1", "atmel,sama5d27", "atmel,sama5d2", "atmel,sama5";
 
+	aliases {
+		serial0 = &uart1;	/* DBGU */
+		serial1 = &uart4;	/* mikro BUS 1 */
+		serial2 = &uart2;	/* mikro BUS 2 */
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
-- 
2.7.4
