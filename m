From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Thu, 29 Jun 2017 14:44:30 +0300
Subject: [PATCH 1/5] ARM: dts: at91: sama5d2: add QSPI nodes
In-Reply-To: <1498736674-9233-1-git-send-email-claudiu.beznea@microchip.com>
References: <1498736674-9233-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1498736674-9233-2-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyrille Pitchen <cyrille.pitchen@atmel.com>

This patch adds DT nodes for sama5d2 QSPI controllers.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
[claudiu.beznea at microchip.com: change subject to match the desired prefix]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index cc06da3..71e9d83 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -954,6 +954,28 @@
 				};
 			};
 
+			qspi0: spi at f0020000 {
+				compatible = "atmel,sama5d2-qspi";
+				reg = <0xf0020000 0x100>, <0xd0000000 0x08000000>;
+				reg-names = "qspi_base", "qspi_mmap";
+				interrupts = <52 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&qspi0_clk>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			qspi1: spi at f0024000 {
+				compatible = "atmel,sama5d2-qspi";
+				reg = <0xf0024000 0x100>, <0xd8000000 0x08000000>;
+				reg-names = "qspi_base", "qspi_mmap";
+				interrupts = <53 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&qspi1_clk>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			sha at f0028000 {
 				compatible = "atmel,at91sam9g46-sha";
 				reg = <0xf0028000 0x100>;
-- 
2.7.4
