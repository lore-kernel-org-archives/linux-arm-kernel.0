From: dinguyen@altera.com (dinguyen at altera.com)
Date: Wed, 16 Apr 2014 15:14:30 -0500
Subject: [PATCH 2/2] ARM: socfpga: dts: Add div-reg to the main_pll clocks
In-Reply-To: <1397679270-29695-1-git-send-email-dinguyen@altera.com>
References: <1397679270-29695-1-git-send-email-dinguyen@altera.com>
Message-ID: <1397679270-29695-2-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

The mpu_clk, main_clk, and dbg_base_clk outputs from the main PLL go through a
pre-divider. Update socfpga.dtsi to represent those dividers for these
clocks.

Re-use the "div-reg" property that was used for the socfpga-gate-clock as this
is the same thing. Also update the documentation.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
 .../devicetree/bindings/clock/altr_socfpga.txt     |    4 ++--
 arch/arm/boot/dts/socfpga.dtsi                     |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/altr_socfpga.txt b/Documentation/devicetree/bindings/clock/altr_socfpga.txt
index 5dfd145..f72e80e 100644
--- a/Documentation/devicetree/bindings/clock/altr_socfpga.txt
+++ b/Documentation/devicetree/bindings/clock/altr_socfpga.txt
@@ -21,8 +21,8 @@ Optional properties:
 - fixed-divider : If clocks have a fixed divider value, use this property.
 - clk-gate : For "socfpga-gate-clk", clk-gate contains the gating register
         and the bit index.
-- div-reg : For "socfpga-gate-clk", div-reg contains the divider register, bit shift,
-        and width.
+- div-reg : For "socfpga-gate-clk" and "socfpga-periph-clock", div-reg contains
+	the divider register, bit shift, and width.
 - clk-phase : For the sdmmc_clk, contains the value of the clock phase that controls
 	the SDMMC CIU clock. The first value is the clk_sample(smpsel), and the second
 	value is the cclk_in_drv(drvsel). The clk-phase is used to enable the correct
diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 56fc214..291eff1 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -124,7 +124,7 @@
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-perip-clk";
 							clocks = <&main_pll>;
-							fixed-divider = <2>;
+							div-reg = <0xe0 0 9>;
 							reg = <0x48>;
 						};
 
@@ -132,7 +132,7 @@
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-perip-clk";
 							clocks = <&main_pll>;
-							fixed-divider = <4>;
+							div-reg = <0xe4 0 9>;
 							reg = <0x4C>;
 						};
 
@@ -140,7 +140,7 @@
 							#clock-cells = <0>;
 							compatible = "altr,socfpga-perip-clk";
 							clocks = <&main_pll>;
-							fixed-divider = <4>;
+							div-reg = <0xe8 0 9>;
 							reg = <0x50>;
 						};
 
-- 
1.7.9.5
