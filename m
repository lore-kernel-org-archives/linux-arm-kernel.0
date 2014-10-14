From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Oct 2014 15:04:09 +0200
Subject: [PATCH 2/8] ARM: realview: add PL061 GPIO to the PB1176 DTS
In-Reply-To: <1413291855-499-1-git-send-email-linus.walleij@linaro.org>
References: <1413291855-499-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1413291855-499-2-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the PL061 GPIO instances found on the PB1176 devchip
and the FPGA to the DTS file.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/arm-realview-pb1176.dts | 39 +++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
index f780adde2332..4721244a16d6 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -196,6 +196,19 @@
 			clock-names = "timer1", "timer2", "apb_pclk";
 		};
 
+		pb1176_gpio0: gpio at 1010a000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x1010a000 0x1000>;
+			gpio-controller;
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 16 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
 		pb1176_serial0: serial at 1010c000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x1010c000 0x1000>;
@@ -251,5 +264,31 @@
 			interrupt-parent = <&intc_dc1176>;
 			interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		fpga_gpio0: gpio at 10014000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x10014000 0x1000>;
+			gpio-controller;
+			interrupt-parent = <&intc_fpga1176>;
+			interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		fpga_gpio1: gpio at 10015000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x10015000 0x1000>;
+			gpio-controller;
+			interrupt-parent = <&intc_fpga1176>;
+			interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
 	};
 };
-- 
1.9.3
