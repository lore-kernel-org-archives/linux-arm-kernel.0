From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  7 May 2018 15:57:06 +0200
Subject: [PATCH 7/8] ARM: dts: r8a7743: Add PMU device node
In-Reply-To: <1525701427-12914-1-git-send-email-geert+renesas@glider.be>
References: <1525701427-12914-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1525701427-12914-8-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for the ARM Performance Monitor Units in the Cortex-A15
CPU cores on RZ/G1M by adding a device node for the PMU.

New Linux output:

    hw perfevents: enabled with armv7_cortex_a15 PMU driver, 7 counters available

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7743.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 69d8f7e0f0536fc0..142949d7066f3a65 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -125,6 +125,13 @@
 		clock-frequency = <0>;
 	};
 
+	pmu {
+		compatible = "arm,cortex-a15-pmu";
+		interrupts-extended = <&gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>;
+	};
+
 	/* External SCIF clock */
 	scif_clk: scif {
 		compatible = "fixed-clock";
-- 
2.7.4
