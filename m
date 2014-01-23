From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Thu, 23 Jan 2014 16:57:11 +0100
Subject: [PATCH v3 07/15] at91: dt: sam9261: Added the descriptions of hck0
 and hck1 clocks (CCF)
In-Reply-To: <1390492639-7299-1-git-send-email-jjhiblot@traphandler.com>
References: <1390492639-7299-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <1390492639-7299-8-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/arm/boot/dts/at91sam9261.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 2730611..97e6b62 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -518,6 +518,26 @@
 					atmel,clk-output-range = <0 94000000>;
 					atmel,clk-divisors = <1 2 4 3>;
 				};
+
+				systemck {
+					compatible = "atmel,at91rm9200-clk-system";
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					hclk0: hclk0 {
+						#clock-cells = <0>;
+						reg = <16>;
+						clocks = <&mck>;
+					};
+
+					hclk1: hclk1 {
+						#clock-cells = <0>;
+						reg = <17>;
+						clocks = <&mck>;
+					};
+				};
+
+
 				periphck {
 					compatible = "atmel,at91rm9200-clk-peripheral";
 					#address-cells = <1>;
-- 
1.8.5.2
