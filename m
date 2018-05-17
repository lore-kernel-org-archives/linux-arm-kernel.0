From: eric@anholt.net (Eric Anholt)
Date: Thu, 17 May 2018 14:17:27 +0100
Subject: [PATCH] arm: bcm2835: Add the PMU to the devicetree.
Message-ID: <20180517131727.29263-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The a53 and a7 counters seem to match up, so we advertise a7 so that
arm32 can probe.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2837.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2837.dtsi b/arch/arm/boot/dts/bcm2837.dtsi
index 7704bb029605..1f5e5c782835 100644
--- a/arch/arm/boot/dts/bcm2837.dtsi
+++ b/arch/arm/boot/dts/bcm2837.dtsi
@@ -17,6 +17,12 @@
 		};
 	};
 
+	arm-pmu {
+		compatible = "arm,cortex-a53-pmu", "arm,cortex-a7-pmu";
+		interrupt-parent = <&local_intc>;
+		interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupt-parent = <&local_intc>;
-- 
2.17.0
