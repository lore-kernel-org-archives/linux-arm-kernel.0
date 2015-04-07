From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue,  7 Apr 2015 16:45:07 +0200
Subject: [PATCH v3 7/9] ARM: berlin: remove useless chip and system ctrl
 compatibles in BG2
In-Reply-To: <1428417909-27378-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1428417909-27378-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1428417909-27378-8-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the rework to have one sub-node per device in the chip and
system controllers is done, their dedicated compatible can be removed.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index 0cbe99da16dc..a80611999b37 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -351,7 +351,7 @@
 		};
 
 		chip: chip-controller at ea0000 {
-			compatible = "marvell,berlin2-chip-ctrl", "simple-mfd", "syscon";
+			compatible = "simple-mfd", "syscon";
 			reg = <0xea0000 0x400>;
 
 			chip_clk: clock {
@@ -455,7 +455,7 @@
 			};
 
 			sysctrl: system-controller at d000 {
-				compatible = "marvell,berlin2-system-ctrl", "simple-mfd", "syscon";
+				compatible = "simple-mfd", "syscon";
 				reg = <0xd000 0x100>;
 
 				sys_pinctrl: pin-controller {
-- 
2.3.5
