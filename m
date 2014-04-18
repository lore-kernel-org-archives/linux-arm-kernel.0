From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Fri, 18 Apr 2014 11:45:08 +0200
Subject: [RFC 2/3] atmel: drm: dt: Added DT entry for the atmel hlcdc found in
 the sama5
In-Reply-To: <1397814309-32160-1-git-send-email-jjhiblot@traphandler.com>
References: <1397814309-32160-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <1397814309-32160-3-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/arm/boot/dts/sama5d3_lcd.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3_lcd.dtsi b/arch/arm/boot/dts/sama5d3_lcd.dtsi
index 85d3027..2a2bced 100644
--- a/arch/arm/boot/dts/sama5d3_lcd.dtsi
+++ b/arch/arm/boot/dts/sama5d3_lcd.dtsi
@@ -51,6 +51,17 @@
 				};
 			};
 
+			hlcdc: hlcdc at f0030000 {
+				compatible = "atmel,hlcdc";
+				reg = <0xf0030000 0x4000>;
+				interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&lcdc_clk>, <&lcdck>;
+				clock-names = "lcdc_clk","bus_clk";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_lcd>;
+				status = "disabled";
+			};
+
 			pmc: pmc at fffffc00 {
 				periphck {
 					lcdc_clk: lcdc_clk {
-- 
1.9.1
