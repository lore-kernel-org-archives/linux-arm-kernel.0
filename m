From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  1 Feb 2016 09:57:48 +0100
Subject: [PATCH 3/5] ARM: pb1176: add ISP1761 USB OTG host controller
Message-ID: <1454317068-4790-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB host controller was missing from the device tree so add
it. This device is not inside either the development chip or the
FPGA but mounted on the board, so it ends up in the root node of
the device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/arm-realview-pb1176.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
index 3d2938c73c4e..70a1ec3bedb9 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -106,6 +106,14 @@
 		clock-frequency = <0>;
 	};
 
+	usb at 3b000000 {
+		compatible = "nxp,usb-isp1761";
+		reg = <0x3b000000 0x20000>;
+		interrupt-parent = <&intc_fpga1176>;
+		interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
+		port1-otg;
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.4.3
