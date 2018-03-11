From: amonakov@ispras.ru (Alexander Monakov)
Date: Sun, 11 Mar 2018 19:00:02 +0300
Subject: [PATCH 2/8] ARM: dts: berlin2cd: fix local timer interrupt flags
In-Reply-To: <20180311160008.22928-1-amonakov@ispras.ru>
References: <20180311160008.22928-1-amonakov@ispras.ru>
Message-ID: <20180311160008.22928-3-amonakov@ispras.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the correct trigger type for Cortex-A9. This was fixed for several
other SoCs since the kernel started issuing a boot-time warning.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
---
 arch/arm/boot/dts/berlin2cd.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index 501c59d97eae..8c8bf3194f34 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -118,7 +118,7 @@
 		local-timer at ad0600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xad0600 0x20>;
-			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_EDGE_RISING)>;
 			clocks = <&chip_clk CLKID_TWD>;
 		};
 
-- 
2.11.0
