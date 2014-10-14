From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Oct 2014 15:04:10 +0200
Subject: [PATCH 3/8] ARM: realview: add charlcd to PB1176 device tree
In-Reply-To: <1413291855-499-1-git-send-email-linus.walleij@linaro.org>
References: <1413291855-499-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1413291855-499-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend the PB1176 device tree with the character LCD device.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/arm-realview-pb1176.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
index 4721244a16d6..4ca486796f71 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -253,6 +253,15 @@
 		compatible = "simple-bus";
 		ranges;
 
+		fpga_charlcd: charlcd at 10008000 {
+			compatible = "arm,versatile-lcd";
+			reg = <0x10008000 0x1000>;
+			interrupt-parent = <&intc_fpga1176>;
+			interrupts = <0 7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
 		/* This GIC on the board is cascaded off the DevChip GIC */
 		intc_fpga1176: interrupt-controller at 10040000 {
 			compatible = "arm,arm1176jzf-devchip-gic", "arm,arm11mp-gic";
-- 
1.9.3
