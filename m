From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Tue, 28 Apr 2015 10:10:16 -0500
Subject: [PATCHv2 4/4] Documentation: DT bindings: document the clocks for
 Arria10
In-Reply-To: <1430233816-32635-1-git-send-email-dinguyen@opensource.altera.com>
References: <1430233816-32635-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1430233816-32635-5-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Update the bindings document for the clocks on the SoCFPGA Arria10 platform.
Also fix up a spelling error for the "altr,socfpga-perip-clk".

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 .../devicetree/bindings/clock/altr_socfpga.txt          | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/altr_socfpga.txt b/Documentation/devicetree/bindings/clock/altr_socfpga.txt
index f72e80e..317e9cc 100644
--- a/Documentation/devicetree/bindings/clock/altr_socfpga.txt
+++ b/Documentation/devicetree/bindings/clock/altr_socfpga.txt
@@ -7,11 +7,15 @@ This binding uses the common clock binding[1].
 Required properties:
 - compatible : shall be one of the following:
 	"altr,socfpga-pll-clock" - for a PLL clock
-	"altr,socfpga-perip-clock" - The peripheral clock divided from the
+	"altr,socfpga-perip-clk" - The peripheral clock divided from the
 		PLL clock.
 	"altr,socfpga-gate-clk" - Clocks that directly feed peripherals and
 		can get gated.
-
+	"altr,socfpga-a10-pll-clock" - for a PLL clock on the Arria10.
+	"altr,socfpga-a10-perip-clk" - The peripheral clock divided from the
+		PLL clock on the Arria10.
+	"altr,socfpga-a10-gate-clk" - Clocks that directly feed peripherals and
+		can be gated.
 - reg : shall be the control register offset from CLOCK_MANAGER's base for the clock.
 - clocks : shall be the input parent clock phandle for the clock. This is
 	either an oscillator or a pll output.
@@ -19,10 +23,11 @@ Required properties:
 
 Optional properties:
 - fixed-divider : If clocks have a fixed divider value, use this property.
-- clk-gate : For "socfpga-gate-clk", clk-gate contains the gating register
-        and the bit index.
-- div-reg : For "socfpga-gate-clk" and "socfpga-periph-clock", div-reg contains
-	the divider register, bit shift, and width.
+- clk-gate : For "socfpga-gate-clk" and "altr,socfpga-a10-gate-clk", clk-gate
+	contains the gating register and the bit index.
+- div-reg : For "socfpga-gate-clk", "socfpga-perip-clk",
+	"altr,socfpga-a10-gate-clk", and "altr,socfpga-a10-perip-clk", div-reg
+	contains the divider register, bit shift, and width.
 - clk-phase : For the sdmmc_clk, contains the value of the clock phase that controls
 	the SDMMC CIU clock. The first value is the clk_sample(smpsel), and the second
 	value is the cclk_in_drv(drvsel). The clk-phase is used to enable the correct
-- 
2.2.1
