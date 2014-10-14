From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Oct 2014 15:04:13 +0200
Subject: [PATCH 6/8] ARM: realview: add FPGA UART4 to PB1176 DTS
In-Reply-To: <1413291855-499-1-git-send-email-linus.walleij@linaro.org>
References: <1413291855-499-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1413291855-499-6-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the UART4 found on the FPGA to the PB1176 DTS
file.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/arm-realview-pb1176.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
index 313a71756a18..ac4c1c850db2 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -35,6 +35,7 @@
 		serial1 = &pb1176_serial1;
 		serial2 = &pb1176_serial2;
 		serial3 = &pb1176_serial3;
+		serial4 = &fpga_serial;
 	};
 
 	memory {
@@ -288,6 +289,15 @@
 			clock-names = "apb_pclk";
 		};
 
+		fpga_serial: serial at 10009000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x10009000 0x1000>;
+			interrupt-parent = <&intc_fpga1176>;
+			interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uartclk>, <&pclk>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+
 		/* This GIC on the board is cascaded off the DevChip GIC */
 		intc_fpga1176: interrupt-controller at 10040000 {
 			compatible = "arm,arm1176jzf-devchip-gic", "arm,arm11mp-gic";
@@ -334,5 +344,7 @@
 			clocks = <&pclk>;
 			clock-names = "apb_pclk";
 		};
+
+
 	};
 };
-- 
1.9.3
