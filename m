From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 17 Mar 2015 12:35:41 +0000
Subject: [PATCH] arm64: juno: Fix misleading name of UART reference clock
Message-ID: <1426595741-6213-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UART reference clock speed is 7273.8 kHz, not 72738 kHz.

Dots aren't usually used in node names even though ePAPR permits
them.  However, this can easily be avoided by expressing the
frequency in Hz, not kHz.

This patch changes the name to refclk7273800hz, reflecting the
actual clock speed.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 arch/arm64/boot/dts/arm/juno-clocks.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/arm/juno-clocks.dtsi b/arch/arm64/boot/dts/arm/juno-clocks.dtsi
index ea2b566..c9b89ef 100644
--- a/arch/arm64/boot/dts/arm/juno-clocks.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-clocks.dtsi
@@ -8,7 +8,7 @@
  */
 
 	/* SoC fixed clocks */
-	soc_uartclk: refclk72738khz {
+	soc_uartclk: refclk7273800hz {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <7273800>;
-- 
1.7.10.4
