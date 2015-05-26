From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 27 May 2015 00:54:16 +0800
Subject: [PATCH] ARM: dts: sun9i: Add device node for watchdog
Message-ID: <1432659256-13278-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On A80 there are 2 watchdogs, one in the main block, and one in the
R (special) block. We do not have information on the R block watchdog,
other than the register layout is the same, and the interrupt number.
Both are able to reset the whole system.

Add the main watchdog, in case the R block is used for special purposes
like running an RTOS.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index ca272e92b85d..a43ad779ee2f 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -565,6 +565,12 @@
 			clocks = <&osc24M>;
 		};
 
+		wdt: watchdog at 06000ca0 {
+			compatible = "allwinner,sun6i-a31-wdt";
+			reg = <0x06000ca0 0x20>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		pio: pinctrl at 06000800 {
 			compatible = "allwinner,sun9i-a80-pinctrl";
 			reg = <0x06000800 0x400>;
-- 
2.1.4
