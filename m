From: eric@anholt.net (Eric Anholt)
Date: Mon, 21 May 2018 11:39:07 -0700
Subject: [PATCH v2] arm: bcm2835: Add the PMU to the devicetree.
Message-ID: <20180521183907.27563-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This only probes on arm64 so far, but hopefully that driver will be
generalized soon.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2837.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2837.dtsi b/arch/arm/boot/dts/bcm2837.dtsi
index 7704bb029605..beb6c502dadc 100644
--- a/arch/arm/boot/dts/bcm2837.dtsi
+++ b/arch/arm/boot/dts/bcm2837.dtsi
@@ -17,6 +17,12 @@
 		};
 	};
 
+	arm-pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupt-parent = <&local_intc>;
+		interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupt-parent = <&local_intc>;
-- 
2.17.0
