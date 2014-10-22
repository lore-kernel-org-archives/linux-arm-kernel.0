From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Wed, 22 Oct 2014 14:07:38 -0500
Subject: [PATCHv4 1/3] ARM: dts: socfpga: rename gpio nodes
In-Reply-To: <1414004860-17645-1-git-send-email-dinguyen@opensource.altera.com>
References: <1414004860-17645-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1414004860-17645-2-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Since the Synopsys GPIO IP can support multiple ports of varying widths, it
would make more sense to have the GPIO node DTS entry as this:

gpio0: gpio at ff708000{
	porta{
	};
};

Also, this is documented in the snps-dwapb-gpio.txt.

Suggested-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 45fce2c..4472fd9 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -547,7 +547,7 @@
 			status = "disabled";
 		};
 
-		gpio at ff708000 {
+		gpio0: gpio at ff708000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "snps,dw-apb-gpio";
@@ -555,7 +555,7 @@
 			clocks = <&per_base_clk>;
 			status = "disabled";
 
-			gpio0: gpio-controller at 0 {
+			porta: gpio-controller at 0 {
 				compatible = "snps,dw-apb-gpio-port";
 				gpio-controller;
 				#gpio-cells = <2>;
@@ -567,7 +567,7 @@
 			};
 		};
 
-		gpio at ff709000 {
+		gpio1: gpio at ff709000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "snps,dw-apb-gpio";
@@ -575,7 +575,7 @@
 			clocks = <&per_base_clk>;
 			status = "disabled";
 
-			gpio1: gpio-controller at 0 {
+			portb: gpio-controller at 0 {
 				compatible = "snps,dw-apb-gpio-port";
 				gpio-controller;
 				#gpio-cells = <2>;
@@ -587,7 +587,7 @@
 			};
 		};
 
-		gpio at ff70a000 {
+		gpio2: gpio at ff70a000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "snps,dw-apb-gpio";
@@ -595,7 +595,7 @@
 			clocks = <&per_base_clk>;
 			status = "disabled";
 
-			gpio2: gpio-controller at 0 {
+			portc: gpio-controller at 0 {
 				compatible = "snps,dw-apb-gpio-port";
 				gpio-controller;
 				#gpio-cells = <2>;
-- 
2.0.3
