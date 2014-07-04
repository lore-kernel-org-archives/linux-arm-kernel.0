From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  4 Jul 2014 11:45:01 +0200
Subject: [PATCH 6/8] ARM: mvebu: update Armada XP DT for dynamic frequency
 scaling
In-Reply-To: <1404467103-29644-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404467103-29644-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1404467103-29644-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support dynamic frequency scaling, the cpuclk Device Tree
node needs to be updated to describe a second set of registers
describing the PMU DFS registers.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 5902e83..bff9f6c 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -99,7 +99,7 @@
 			cpuclk: clock-complex at 18700 {
 				#clock-cells = <1>;
 				compatible = "marvell,armada-xp-cpu-clock";
-				reg = <0x18700 0xA0>;
+				reg = <0x18700 0xA0>, <0x1c054 0x10>;
 				clocks = <&coreclk 1>;
 			};
 
-- 
2.0.0
