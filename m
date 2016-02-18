From: stefan@agner.ch (Stefan Agner)
Date: Wed, 17 Feb 2016 16:37:00 -0800
Subject: [PATCH] ARM: dts: vf610: add performance monitoring unit
Message-ID: <1455755820-31442-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All Freescale Vybrid SoC include a Cortex-A5 core which supports
ARM's standard PMU (performance monitoring unit). Include the
monitoring unit into the Cortex-A5 base device tree vf500.dtsi.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf500.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/vf500.dtsi b/arch/arm/boot/dts/vf500.dtsi
index b94b992..9cd1ac5 100644
--- a/arch/arm/boot/dts/vf500.dtsi
+++ b/arch/arm/boot/dts/vf500.dtsi
@@ -75,6 +75,16 @@
 				clocks = <&clks VF610_CLK_PLATFORM_BUS>;
 			};
 		};
+
+		aips-bus at 40080000 {
+
+			pmu at 40089000 {
+				compatible = "arm,cortex-a5-pmu";
+				interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-affinity = <&a5_cpu>;
+			};
+		};
+
 	};
 };
 
-- 
2.7.1
