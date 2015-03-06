From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri,  6 Mar 2015 16:13:03 +0100
Subject: [PATCH v2 10/11] ARM: berlin: remove useless chip and system ctrl
 compatibles in BG2CD
In-Reply-To: <1425654784-27354-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1425654784-27354-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1425654784-27354-11-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the rework to have one sub-node per device in the chip and
system controllers is done, their dedicated compatible can be removed.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2cd.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index 240bfe24ae83..7dff8497606b 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -295,7 +295,7 @@
 		};
 
 		chip: chip-controller at ea0000 {
-			compatible = "marvell,berlin2cd-chip-ctrl", "simple-mfd", "syscon";
+			compatible = "simple-mfd", "syscon";
 			reg = <0xea0000 0x400>;
 
 			chip_clk: clock {
@@ -402,7 +402,7 @@
 			};
 
 			sysctrl: system-controller at d000 {
-				compatible = "marvell,berlin2cd-system-ctrl", "simple-mfd", "syscon";
+				compatible = "simple-mfd", "syscon";
 				reg = <0xd000 0x100>;
 
 				sys_pinctrl: pin-controller {
-- 
2.3.1
