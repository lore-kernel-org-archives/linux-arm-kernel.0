From: dinguyen@altera.com (dinguyen at altera.com)
Date: Tue, 17 Sep 2013 11:31:25 -0500
Subject: [PATCH 1/2] arm: dts: socfpga: Change some types of gate-clk type to
 periph-clk type
Message-ID: <1379435486-25981-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Some of the clocks that were designated gate-clk did not have a gate, so
change those clocks to be of periph-clk type.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: devicetree at vger.kernel.org
CC: linux-arm-kernel at lists.infradead.org
---
 arch/arm/boot/dts/socfpga.dtsi |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 1ee6079..acd6c3a 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -245,14 +245,14 @@
 
 				mpu_periph_clk: mpu_periph_clk {
 					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
+					compatible = "altr,socfpga-perip-clk";
 					clocks = <&mpuclk>;
 					fixed-divider = <4>;
 					};
 
 				mpu_l2_ram_clk: mpu_l2_ram_clk {
 					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
+					compatible = "altr,socfpga-perip-clk";
 					clocks = <&mpuclk>;
 					fixed-divider = <2>;
 					};
@@ -266,8 +266,9 @@
 
 				l3_main_clk: l3_main_clk {
 					#clock-cells = <0>;
-					compatible = "altr,socfpga-gate-clk";
+					compatible = "altr,socfpga-perip-clk";
 					clocks = <&mainclk>;
+					fixed-divider = <1>;
 					};
 
 				l3_mp_clk: l3_mp_clk {
-- 
1.7.9.5
