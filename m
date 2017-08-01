From: mw@semihalf.com (Marcin Wojtas)
Date: Tue,  1 Aug 2017 18:36:23 +0200
Subject: [PATCH 2/2] ARM: dts: armada-38x: Add arm_global_timer node
In-Reply-To: <1501605383-24748-1-git-send-email-mw@semihalf.com>
References: <1501605383-24748-1-git-send-email-mw@semihalf.com>
Message-ID: <1501605383-24748-3-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since generic Cortex-A9 global timer is available after adding
it to compilation, enable its node in armada-38x.dtsi.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index af31f5d..7ff0811e 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -154,6 +154,13 @@
 				reg = <0xc000 0x58>;
 			};
 
+			timer at c200 {
+				compatible = "arm,cortex-a9-global-timer";
+				reg = <0xc200 0x20>;
+				interrupts = <GIC_PPI 11 (IRQ_TYPE_EDGE_RISING | GIC_CPU_MASK_SIMPLE(2))>;
+				clocks = <&coreclk 2>;
+			};
+
 			timer at c600 {
 				compatible = "arm,cortex-a9-twd-timer";
 				reg = <0xc600 0x20>;
-- 
1.8.3.1
