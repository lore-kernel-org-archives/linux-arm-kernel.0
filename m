From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 17 Mar 2015 13:53:34 +0100
Subject: [PATCH] ARM: mvebu: clk: remove cpuclk resources overlapping
 coredivclk registers on Armada XP
Message-ID: <1426596814-30758-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nadav Haklai <nadavh@marvell.com>

The resources of the cpuclk node are overlapping the one from
coredivclk node. It was not noticed until now because the driver did a
simple of_iomap and not a request_mem_region. This patch fixes it.

[gregory.clement at free-electrons.com: add commit log and port to 4.0-rc]
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Nadav Haklai <nadavh@marvell.com>
Signed-off-by: Nadav Haklai <nadavh@marvell.com>
---
 arch/arm/boot/dts/armada-xp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 82917236a2fb..fdc2e5bdf459 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -149,7 +149,7 @@
 			cpuclk: clock-complex at 18700 {
 				#clock-cells = <1>;
 				compatible = "marvell,armada-xp-cpu-clock";
-				reg = <0x18700 0xA0>, <0x1c054 0x10>;
+				reg = <0x18700 0x24>, <0x1c054 0x10>;
 				clocks = <&coreclk 1>;
 			};
 
-- 
2.1.0
