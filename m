From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 30 Aug 2016 14:12:34 +0200
Subject: [PATCH 2/4] ARM: dts: add the Integrator/AP baseboard clocks
In-Reply-To: <1472559156-32148-1-git-send-email-linus.walleij@linaro.org>
References: <1472559156-32148-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1472559156-32148-2-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The two clocks present on the Integrator/AP baseboard and
accessible through its system controller is the PCIv3 bridge
clock and the PCI bus clock. Define the proper device tree
nodes for these.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/integratorap.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/integratorap.dts b/arch/arm/boot/dts/integratorap.dts
index c1e3abf5d072..726a3ac486e0 100644
--- a/arch/arm/boot/dts/integratorap.dts
+++ b/arch/arm/boot/dts/integratorap.dts
@@ -48,6 +48,27 @@
 		interrupt-parent = <&pic>;
 		/* These are the logical module IRQs */
 		interrupts = <9>, <10>, <11>, <12>;
+
+		/*
+		 * SYSCLK clocks PCIv3 bridge, system controller and the
+		 * logic modules.
+		 */
+		sysclk: apsys at 24M {
+			compatible = "arm,syscon-icst525-integratorap-sys";
+			#clock-cells = <0>;
+			lock-offset = <0x1c>;
+			vco-offset = <0x04>;
+			clocks = <&xtal24mhz>;
+		};
+
+		/* One-bit control for the PCI bus clock (33 or 25 MHz) */
+		pciclk: pciclk at 24M {
+			compatible = "arm,syscon-icst525-integratorap-pci";
+			#clock-cells = <0>;
+			lock-offset = <0x1c>;
+			vco-offset = <0x04>;
+			clocks = <&xtal24mhz>;
+		};
 	};
 
 	timer0: timer at 13000000 {
-- 
2.7.4
