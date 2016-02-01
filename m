From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  1 Feb 2016 09:57:40 +0100
Subject: [PATCH 2/5] ARM: pb1176: add AACI to the device tree
Message-ID: <1454317060-4744-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device tree was missing the definition of the AACI
Advanced Audio Codec Interface, so add it. Tested on the hardware
and it works.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/arm-realview-pb1176.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
index 5edcf596eccc..3d2938c73c4e 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -341,6 +341,15 @@
 		compatible = "simple-bus";
 		ranges;
 
+		fpga_aaci: aaci at 10004000 {
+			compatible = "arm,pl041", "arm,primecell";
+			reg = <0x10004000 0x1000>;
+			interrupt-parent = <&intc_fpga1176>;
+			interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
 		fpga_mci: mmcsd at 10005000 {
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x10005000 0x1000>;
-- 
2.4.3
