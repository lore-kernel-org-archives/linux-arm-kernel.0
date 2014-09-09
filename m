From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue,  9 Sep 2014 16:47:49 +0200
Subject: [PATCH] ARM: dts: berlin: enable timer 1 for sched_clock
Message-ID: <1410274069-24922-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable timer 1 to be the source for the sched_clock, allowing to have a
more precise value than 1/HZ.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index a216cb621ebc..e22b99a3a796 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -247,7 +247,6 @@
 				reg = <0x2c14 0x14>;
 				clocks = <&chip CLKID_CFG>;
 				clock-names = "timer";
-				status = "disabled";
 			};
 
 			timer2: timer at 2c28 {
-- 
1.9.1
