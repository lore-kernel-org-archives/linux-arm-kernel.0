From: peron.clem@gmail.com (=?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?=)
Date: Thu,  3 May 2018 17:32:07 +0200
Subject: [PATCH v2] ARM: dts: cygnus: fix irq type for arm global timer
Message-ID: <20180503153207.7668-1-peron.clem@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per ARM documentation
PPI(0) ID27 - global timer interrupt is rising-edge sensitive.

set IRQ triggering type to IRQ_TYPE_EDGE_RISING for ARM Global timers.

Fixes: c9ad7bc5fe3 ("ARM: dts: Enable Broadcom Cygnus SoC")
Signed-off-by: Cl?ment P?ron <peron.clem@gmail.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 699fdf94d139..9fe4f5a6379e 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -69,7 +69,7 @@
 		timer at 20200 {
 			compatible = "arm,cortex-a9-global-timer";
 			reg = <0x20200 0x100>;
-			interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_PPI 11 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&periph_clk>;
 		};
 
-- 
2.17.0
