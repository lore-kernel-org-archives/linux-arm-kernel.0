From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 20 Feb 2014 22:29:47 -0700
Subject: [PATCH V2] ARM: bcm2835: fix clock DT node names
Message-ID: <1392960587-29355-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT nodes should be named according to the type of object that they
represent rather than the identity. DT nodes that contain a reg
property should include a unit address in their name. Fix these issues.

Add clock-output-names properties to the nodes so that the clocks get
named something meaningful. This works around the fact that the fixed
clock driver names clocks after the short node name, i.e. not including
the unit address.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
v2: Add clock-output-names properties.
---
 arch/arm/boot/dts/bcm2835.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index a2d4889..b8473c4 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -155,24 +155,27 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		clk_mmc: mmc {
+		clk_mmc: clock at 0 {
 			compatible = "fixed-clock";
 			reg = <0>;
 			#clock-cells = <0>;
+			clock-output-names = "mmc";
 			clock-frequency = <100000000>;
 		};
 
-		clk_i2c: i2c {
+		clk_i2c: clock at 1 {
 			compatible = "fixed-clock";
 			reg = <1>;
 			#clock-cells = <0>;
+			clock-output-names = "i2c";
 			clock-frequency = <250000000>;
 		};
 
-		clk_spi: spi {
+		clk_spi: clock at 2 {
 			compatible = "fixed-clock";
 			reg = <2>;
 			#clock-cells = <0>;
+			clock-output-names = "spi";
 			clock-frequency = <250000000>;
 		};
 	};
-- 
1.8.3.2
