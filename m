From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon,  3 Jun 2013 18:47:36 +0200
Subject: [PATCH] ARM: mvebu: set aliases for ethernet controllers
Message-ID: <1370278056-3058-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Willy Tarreau <w@1wt.eu>

These aliases are used when feeding the DT from ATAGS to set the
devices MAC addresses.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi     | 9 +++++++--
 arch/arm/boot/dts/armada-xp-mv78460.dtsi | 3 ++-
 arch/arm/boot/dts/armada-xp.dtsi         | 6 +++++-
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 550eb77..8f69cf4 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -22,6 +22,11 @@
 	model = "Marvell Armada 370 and XP SoC";
 	compatible = "marvell,armada-370-xp";
 
+	aliases {
+		eth0 = &eth0;
+		eth1 = &eth1;
+	};
+
 	cpus {
 		cpu at 0 {
 			compatible = "marvell,sheeva-v7";
@@ -94,7 +99,7 @@
 				reg = <0x72004 0x4>;
 			};
 
-			ethernet at 70000 {
+			eth0: ethernet at 70000 {
 				compatible = "marvell,armada-370-neta";
 				reg = <0x70000 0x2500>;
 				interrupts = <8>;
@@ -102,7 +107,7 @@
 				status = "disabled";
 			};
 
-			ethernet at 74000 {
+			eth1: ethernet at 74000 {
 				compatible = "marvell,armada-370-neta";
 				reg = <0x74000 0x2500>;
 				interrupts = <10>;
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index 6ab56bd..386f0ce 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -23,6 +23,7 @@
 		gpio0 = &gpio0;
 		gpio1 = &gpio1;
 		gpio2 = &gpio2;
+		eth3 = &eth3;
 	};
 
 
@@ -105,7 +106,7 @@
 				interrupts = <91>;
 			};
 
-			ethernet at 34000 {
+			eth3: ethernet at 34000 {
 				compatible = "marvell,armada-370-neta";
 				reg = <0x34000 0x2500>;
 				interrupts = <14>;
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 5b902f9..e481d54 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -22,6 +22,10 @@
 	model = "Marvell Armada XP family SoC";
 	compatible = "marvell,armadaxp", "marvell,armada-370-xp";
 
+	aliases {
+		eth2 = &eth2;
+	};
+
 	soc {
 		internal-regs {
 			L2: l2-cache {
@@ -86,7 +90,7 @@
 				reg = <0x18200 0x500>;
 			};
 
-			ethernet at 30000 {
+			eth2: ethernet at 30000 {
 				compatible = "marvell,armada-370-neta";
 				reg = <0x30000 0x2500>;
 				interrupts = <12>;
-- 
1.8.1.2
