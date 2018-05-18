From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:17:33 +0200
Subject: [PATCH 60/69] ARM: dts: r7s72100: Add PMU device node
In-Reply-To: <cover.1526641667.git.horms+renesas@verge.net.au>
References: <cover.1526641667.git.horms+renesas@verge.net.au>
Message-ID: <74a0e50d70aa8f7baeaad7a5c5f7d6bdaf92ff1a.1526641667.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Enable support for the ARM Performance Monitor Units in the Cortex-A9
CPU core on RZ/A1H by adding a device node for the PMU.

New Linux output:

    hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7 counters available

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index eb2e6f95a2e8..a54822e97bac 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -77,6 +77,11 @@
 		clock-div = <6>;
 	};
 
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts-extended = <&gic GIC_PPI 0 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	rtc_x1_clk: rtc_x1 {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
-- 
2.11.0
