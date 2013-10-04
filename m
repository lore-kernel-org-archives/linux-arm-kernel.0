From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  4 Oct 2013 15:27:02 +0200
Subject: [PATCH] ARM: integrator: pass parent IRQ to the SIC
Message-ID: <1380893222-7716-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SIC is cascaded off the PIC, so specify this in the device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/integratorcp.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/integratorcp.dts b/arch/arm/boot/dts/integratorcp.dts
index ff1aea0..f0ab05f 100644
--- a/arch/arm/boot/dts/integratorcp.dts
+++ b/arch/arm/boot/dts/integratorcp.dts
@@ -48,8 +48,11 @@
 		valid-mask = <0x00000007>;
 	};
 
+	/* The SIC is cascaded off IRQ 26 on the PIC */
 	sic: sic at ca000000 {
 		compatible = "arm,versatile-fpga-irq";
+		interrupt-parent = <&pic>;
+		interrupts = <26>;
 		#interrupt-cells = <1>;
 		interrupt-controller;
 		reg = <0xca000000 0x100>;
-- 
1.8.3.1
