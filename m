From: r.sricharan@ti.com (Sricharan R)
Date: Thu, 10 Oct 2013 13:20:13 +0530
Subject: [PATCH] ARM: DRA: DTS: Remove clock-frequency field for cpu timers
Message-ID: <1381391413-4361-1-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm arch timers frequency are now programmed in the CNTFREQ
per-cpu register by the timer code using the secure API [1].
So remove the redundant entry from the dts.

[1] http://marc.info/?l=linux-omap&m=138139106312786&w=2

Cc: Benoit Cousson <bcousson@baylibre.com>
Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 37f606b..f25adc5 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -52,7 +52,6 @@
 			     <GIC_PPI 14 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 11 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>;
-		clock-frequency = <6144000>;
 	};
 
 	gic: interrupt-controller at 48211000 {
-- 
1.7.9.5
