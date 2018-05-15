From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Tue, 15 May 2018 17:12:08 +0800
Subject: [PATCH] ARM: dts: berlin2: fix irq type for arm twd timer
Message-ID: <20180515171208.4f1c0b21@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fix below warning about PPI interrupts configuration:
"GIC: PPI13 is secure or misconfigured"

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm/boot/dts/berlin2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index d575823c5750..787a9d042ad9 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -149,7 +149,7 @@
 		local-timer at ad0600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xad0600 0x20>;
-			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>;
 			clocks = <&chip_clk CLKID_TWD>;
 		};
 
-- 
2.17.0
