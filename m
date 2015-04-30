From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  1 May 2015 00:10:06 +0800
Subject: [PATCH v2 5/5] ARM: dts: sun9i: Add TODO comments for the main and
 low power clocks
In-Reply-To: <1430410206-4410-1-git-send-email-wens@csie.org>
References: <1430410206-4410-1-git-send-email-wens@csie.org>
Message-ID: <1430410206-4410-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The main (24MHz) clock on the A80 is configurable via the PRCM address
space. The low power/speed (32kHz) clock is from an external chip, the
AC100.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index f0869ff8006f..517d5a8c7b59 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -133,6 +133,14 @@
 		 */
 		ranges = <0 0 0 0x20000000>;
 
+		/*
+		 * This clock is actually configurable from the PRCM address
+		 * space. The external 24M oscillator can be turned off, and
+		 * the clock switched to an internal 16M RC oscillator. Under
+		 * normal operation there's no reason to do this, and the
+		 * default is to use the external good one, so just model this
+		 * as a fixed clock.
+		 */
 		osc24M: osc24M_clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
@@ -140,6 +148,13 @@
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
2.1.4
