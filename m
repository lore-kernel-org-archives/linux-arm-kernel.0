From: balbi@ti.com (Felipe Balbi)
Date: Mon, 13 Jul 2015 15:41:41 -0500
Subject: [PATCH] arm: dts: dra7: arch timer sits in always-on power domain
Message-ID: <1436820101-2172-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to DRA7x TRM section 4.3.5 Realtime Counter (Master Counter),
the realtime counter sits in the Wakeup Always-On Power domain.
Furthermore, the counter will automatically switch the 32K clock source
when MPU goes into standby and automatically switch back to SYS_CLK or
ABE_LP when MPU goes out of standby.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 8f1e25bcecbd..c1e6fd82485f 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -50,6 +50,7 @@
 			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
 		interrupt-parent = <&gic>;
+		always-on;
 	};
 
 	gic: interrupt-controller at 48211000 {
-- 
2.4.4
