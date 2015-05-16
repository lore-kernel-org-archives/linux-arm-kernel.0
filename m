From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 16 May 2015 02:23:31 +0200
Subject: [PATCH 02/14] ARM: berlin: prepare simple-mfd/syscon conversion of
 sys/chip ctrl nodes
In-Reply-To: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1431735823-28006-3-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Antoine Tenart <antoine.tenart@free-electrons.com>

The chip and system controller nodes will be handled by simple-mfd based
driver probing. Prepare the conversion by adding "simple-mfd" and "syscon"
compatibles to the corresponding nodes.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/boot/dts/berlin2.dtsi   | 4 ++--
 arch/arm/boot/dts/berlin2cd.dtsi | 4 ++--
 arch/arm/boot/dts/berlin2q.dtsi  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index 63d00a63cfa6..245527abb77c 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -351,7 +351,7 @@
 		};
 
 		chip: chip-control at ea0000 {
-			compatible = "marvell,berlin2-chip-ctrl";
+			compatible = "marvell,berlin2-chip-ctrl", "simple-mfd", "syscon";
 			#clock-cells = <1>;
 			#reset-cells = <2>;
 			reg = <0xea0000 0x400>;
@@ -442,7 +442,7 @@
 			};
 
 			sysctrl: system-controller at d000 {
-				compatible = "marvell,berlin2-system-ctrl";
+				compatible = "marvell,berlin2-system-ctrl", "simple-mfd", "syscon";
 				reg = <0xd000 0x100>;
 
 				uart0_pmux: uart0-pmux {
diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index 81b670ac494a..cccc23b45a26 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -295,7 +295,7 @@
 		};
 
 		chip: chip-control at ea0000 {
-			compatible = "marvell,berlin2cd-chip-ctrl";
+			compatible = "marvell,berlin2cd-chip-ctrl", "simple-mfd", "syscon";
 			#clock-cells = <1>;
 			#reset-cells = <2>;
 			reg = <0xea0000 0x400>;
@@ -389,7 +389,7 @@
 			};
 
 			sysctrl: system-controller at d000 {
-				compatible = "marvell,berlin2cd-system-ctrl";
+				compatible = "marvell,berlin2cd-system-ctrl", "simple-mfd", "syscon";
 				reg = <0xd000 0x100>;
 			};
 
diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index be5397288d24..a515b54bb3e5 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -360,7 +360,7 @@
 		};
 
 		chip: chip-control at ea0000 {
-			compatible = "marvell,berlin2q-chip-ctrl";
+			compatible = "marvell,berlin2q-chip-ctrl", "simple-mfd", "syscon";
 			#clock-cells = <1>;
 			#reset-cells = <2>;
 			reg = <0xea0000 0x400>, <0xdd0170 0x10>;
@@ -526,7 +526,7 @@
 			};
 
 			sysctrl: pin-controller at d000 {
-				compatible = "marvell,berlin2q-system-ctrl";
+				compatible = "marvell,berlin2q-system-ctrl", "simple-mfd", "syscon";
 				reg = <0xd000 0x100>;
 
 				uart0_pmux: uart0-pmux {
-- 
2.1.0
