From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 16 May 2015 02:23:43 +0200
Subject: [PATCH 14/14] ARM: berlin: remove useless chip and system ctrl
 compatibles
In-Reply-To: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1431735823-28006-15-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Antoine Tenart <antoine.tenart@free-electrons.com>

Now that the rework to have one sub-node per device in the chip and
system controllers is done, their dedicated compatible can be removed.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/boot/dts/berlin2.dtsi   | 4 ++--
 arch/arm/boot/dts/berlin2cd.dtsi | 4 ++--
 arch/arm/boot/dts/berlin2q.dtsi  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index b2ffaf42c815..4d2f52759b07 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -351,7 +351,7 @@
 		};
 
 		chip: chip-control at ea0000 {
-			compatible = "marvell,berlin2-chip-ctrl", "simple-mfd", "syscon";
+			compatible = "simple-mfd", "syscon";
 			reg = <0xea0000 0x400>;
 
 			chip_clk: clock {
@@ -454,7 +454,7 @@
 			};
 
 			sysctrl: system-controller at d000 {
-				compatible = "marvell,berlin2-system-ctrl", "simple-mfd", "syscon";
+				compatible = "simple-mfd", "syscon";
 				reg = <0xd000 0x100>;
 
 				sys_pinctrl: pin-controller {
diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index 6ff0194cf77d..0a70d47663b2 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -295,7 +295,7 @@
 		};
 
 		chip: chip-control at ea0000 {
-			compatible = "marvell,berlin2cd-chip-ctrl", "simple-mfd", "syscon";
+			compatible = "simple-mfd", "syscon";
 			reg = <0xea0000 0x400>;
 
 			chip_clk: clock {
@@ -401,7 +401,7 @@
 			};
 
 			sysctrl: system-controller at d000 {
-				compatible = "marvell,berlin2cd-system-ctrl", "simple-mfd", "syscon";
+				compatible = "simple-mfd", "syscon";
 				reg = <0xd000 0x100>;
 
 				sys_pinctrl: pin-controller {
diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 4a21ba386230..0c6c88a861cd 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -360,7 +360,7 @@
 		};
 
 		chip: chip-control at ea0000 {
-			compatible = "marvell,berlin2q-chip-ctrl", "simple-mfd", "syscon";
+			compatible = "simple-mfd", "syscon";
 			reg = <0xea0000 0x400>, <0xdd0170 0x10>;
 
 			chip_clk: clock {
@@ -537,7 +537,7 @@
 			};
 
 			sysctrl: pin-controller at d000 {
-				compatible = "marvell,berlin2q-system-ctrl", "simple-mfd", "syscon";
+				compatible = "simple-mfd", "syscon";
 				reg = <0xd000 0x100>;
 
 				sys_pinctrl: pin-controller {
-- 
2.1.0
