From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Tue, 15 May 2018 17:16:36 +0800
Subject: [PATCH] ARM: dts: berlin2q: fix irq type for arm twd timer
Message-ID: <20180515171636.6414cbc5@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fix below warning about PPI interrupts configuration:
"GIC: PPI13 is secure or misconfigured"

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 7cba798152b9..f11254e70f57 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -164,7 +164,7 @@
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xad0600 0x20>;
 			clocks = <&chip_clk CLKID_TWD>;
-			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
 		};
 
 		gic: interrupt-controller at ad1000 {
-- 
2.17.0
