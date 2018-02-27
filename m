From: stefan@agner.ch (Stefan Agner)
Date: Tue, 27 Feb 2018 16:16:10 +0100
Subject: [PATCH] ARM: dts: imx7: add CPU PMU support
Message-ID: <20180227151610.21887-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for ARM Performance Monitoring Units available
on the Cortex-A7 CPU. There is only a single interrupt for the
PMU in both variants of the family, i.MX 7Solo and 7Dual.

Tested with perf on a i.MX 7Dual:
  hw perfevents: enabled with armv7_cortex_a7 PMU driver, 5 counters available

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx7s.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 9aa2bb998552..a6d8f35c4255 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -130,6 +130,12 @@
 		#phy-cells = <0>;
 	};
 
+	pmu {
+		compatible = "arm,cortex-a7-pmu";
+		interrupt-parent = <&gpc>;
+		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>;
+	};
 
 	replicator {
 		/*
-- 
2.16.2
