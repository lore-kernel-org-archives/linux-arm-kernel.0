From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 18 Jul 2017 15:18:31 +0200
Subject: [PATCH] arm64: dts: marvell: armada-cp110-slave: Fix RTC interrupt
Message-ID: <20170718131831.5088-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While switching from GIC to ICU, the RTC node in hte CP110 slave dtsi was
missed. Fix the interrupt by using the ICU value instead of the GIC one.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
index 95f8e5f607f6..471aaf8dc750 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -64,7 +64,7 @@
 				compatible = "marvell,armada-8k-rtc";
 				reg = <0x284000 0x20>, <0x284080 0x24>;
 				reg-names = "rtc", "rtc-soc";
-				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <ICU_GRP_NSR 77 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			cps_ethernet: ethernet at 0 {
-- 
2.13.2
