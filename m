From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 29 Nov 2015 11:03:10 +0800
Subject: [PATCH v4 5/5] ARM: dts: sun9i: Add TODO comments for the main and
 low power clocks
In-Reply-To: <1448766190-11345-1-git-send-email-wens@csie.org>
References: <1448766190-11345-1-git-send-email-wens@csie.org>
Message-ID: <1448766190-11345-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The main (24MHz) clock on the A80 is configurable via the PRCM address
space. The low power/speed (32kHz) clock is from an external chip, the
AC100.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index a4ce348c0831..eb69a62f6bc4 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -128,6 +128,17 @@
 		 */
 		ranges = <0 0 0 0x20000000>;
 
+		/*
+		 * This clock is actually configurable from the PRCM address
+		 * space. The external 24M oscillator can be turned off, and
+		 * the clock switched to an internal 16M RC oscillator. Under
+		 * normal operation there's no reason to do this, and the
+		 * default is to use the external good one, so just model this
+		 * as a fixed clock. Also it is not entirely clear if the
+		 * osc24M mux in the PRCM affects the entire clock tree, which
+		 * would also throw all the PLL clock rates off, or just the
+		 * downstream clocks in the PRCM.
+		 */
 		osc24M: osc24M_clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
@@ -135,6 +146,13 @@
 			clock-output-names = "osc24M";
 		};
 
+		/*
+		 * The 32k clock is from an external source, normally the
+		 * AC100 codec/RTC chip. This clock is by default enabled
+		 * and clocked at 32768 Hz, from the oscillator connected
+		 * to the AC100. It is configurable, but no such driver or
+		 * bindings exist yet.
+		 */
 		osc32k: osc32k_clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
-- 
2.6.2
