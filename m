From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Wed, 22 Jul 2015 22:30:06 -0500
Subject: [PATCH 2/3] ARM: socfpga: dts: Fix gpio dts entry for the correct
 clock
In-Reply-To: <1437622207-1760-1-git-send-email-dinguyen@opensource.altera.com>
References: <1437622207-1760-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1437622207-1760-2-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

The correct clock for the HPS gpio(s) should be the l4_mp_clk.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 7860935..b0acaec 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -565,7 +565,7 @@
 			#size-cells = <0>;
 			compatible = "snps,dw-apb-gpio";
 			reg = <0xff708000 0x1000>;
-			clocks = <&per_base_clk>;
+			clocks = <&l4_mp_clk>;
 			status = "disabled";
 
 			porta: gpio-controller at 0 {
@@ -585,7 +585,7 @@
 			#size-cells = <0>;
 			compatible = "snps,dw-apb-gpio";
 			reg = <0xff709000 0x1000>;
-			clocks = <&per_base_clk>;
+			clocks = <&l4_mp_clk>;
 			status = "disabled";
 
 			portb: gpio-controller at 0 {
@@ -605,7 +605,7 @@
 			#size-cells = <0>;
 			compatible = "snps,dw-apb-gpio";
 			reg = <0xff70a000 0x1000>;
-			clocks = <&per_base_clk>;
+			clocks = <&l4_mp_clk>;
 			status = "disabled";
 
 			portc: gpio-controller at 0 {
-- 
2.4.5
