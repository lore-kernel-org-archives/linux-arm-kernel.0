From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  7 May 2018 15:57:00 +0200
Subject: [PATCH 1/8] ARM: dts: r7s72100: Add PMU device node
In-Reply-To: <1525701427-12914-1-git-send-email-geert+renesas@glider.be>
References: <1525701427-12914-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1525701427-12914-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for the ARM Performance Monitor Units in the Cortex-A9
CPU core on RZ/A1H by adding a device node for the PMU.

New Linux output:

    hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7 counters available

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r7s72100.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index eb2e6f95a2e85862..a54822e97bac42ed 100644
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
2.7.4
