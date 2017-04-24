From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Apr 2017 21:27:46 +0200
Subject: [PATCH 1/2] reset: Add DT bindings for the Gemini reset controller
Message-ID: <20170424192746.27378-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a simple reset controller in a single 32bit
register.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/reset/cortina,gemini-reset.txt        | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/cortina,gemini-reset.txt

diff --git a/Documentation/devicetree/bindings/reset/cortina,gemini-reset.txt b/Documentation/devicetree/bindings/reset/cortina,gemini-reset.txt
new file mode 100644
index 000000000000..21aa12901774
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/cortina,gemini-reset.txt
@@ -0,0 +1,59 @@
+Cortina Gemini Reset Controller
+
+This reset controller is found in Cortina Systems CS3516 and
+the predecessor StorLink SL3516.
+
+Required properties:
+- compatible: "cortina,gemini-reset"
+- #reset-cells: Must be 1
+
+The Gemini reset controller must be a child node of the
+system controller. Apart from this it follows the standard reset
+controller bindings.
+
+Valid reset line values:
+
+0:  DRAM controller
+1:  Flash controller
+2:  IDE controller
+3:  RAID controller
+4:  Security module
+5:  GMAC0 (ethernet)
+6:  GMAC1 (ethernet)
+7:  PCI host bridge
+8:  USB0 USB host controller
+9:  USB1 USB host controller
+10: General DMA controller
+11: APB bridge
+12: LPC (Low Pin Count) controller
+13: LCD module
+14: Interrupt controller 0
+15: Interrupt controller 1
+16: RTC module
+17: Timer module
+18: UART controller
+19: SSP controller
+20: GPIO0 GPIO controller
+21: GPIO1 GPIO controller
+22: GPIO2 GPIO controller
+23: Watchdog timer
+24: External device reset
+25: CIR module (infrared)
+26: SATA0 SATA bridge
+27: SATA1 SATA bridge
+28: TVE TV Encoder module
+29: Reserved
+30: CPU1 reset
+31: Global soft reset
+
+Example:
+
+syscon: syscon at 40000000 {
+	compatible = "cortina,gemini-syscon", "syscon", "simple-mfd";
+	reg = <0x40000000 0x1000>;
+
+	reset-controller {
+		compatible = "cortina,gemini-reset";
+		#reset-cells = <1>;
+	};
+};
-- 
2.9.3
