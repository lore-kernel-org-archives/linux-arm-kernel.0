From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Oct 2014 15:04:11 +0200
Subject: [PATCH 4/8] ARM: realview: add RTC clocks to device tree
In-Reply-To: <1413291855-499-1-git-send-email-linus.walleij@linaro.org>
References: <1413291855-499-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1413291855-499-4-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PB1176 has two PL031 RTC clocks, one in the devchip and one
in the FPGA. Add them to the device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/arm-realview-pb1176.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
index 4ca486796f71..0e5b608ab9db 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -196,6 +196,15 @@
 			clock-names = "timer1", "timer2", "apb_pclk";
 		};
 
+		pb1176_rtc: rtc at 10108000 {
+			compatible = "arm,pl031", "arm,primecell";
+			reg = <0x10108000 0x1000>;
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 14 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
 		pb1176_gpio0: gpio at 1010a000 {
 			compatible = "arm,pl061", "arm,primecell";
 			reg = <0x1010a000 0x1000>;
@@ -299,5 +308,14 @@
 			clocks = <&pclk>;
 			clock-names = "apb_pclk";
 		};
+
+		fpga_rtc: rtc at 10017000 {
+			compatible = "arm,pl031", "arm,primecell";
+			reg = <0x10017000 0x1000>;
+			interrupt-parent = <&intc_fpga1176>;
+			interrupts = <0 25 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
 	};
 };
-- 
1.9.3
