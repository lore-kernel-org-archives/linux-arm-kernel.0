From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  3 Mar 2015 15:41:00 +0100
Subject: [PATCH v3 05/20] ARM: mvebu: remove aliases for Ethernet devices on
 Armada 370/375/38x/XP
In-Reply-To: <1425393675-17820-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1425393675-17820-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1425393675-17820-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Having aliases for Ethernet devices is useless, since the networking
subsystem unfortunately doesn't care about aliases to name network
interfaces.

Note that the 'aliases' nodes in armada-370-xp.dtsi and armada-xp.dtsi
become empty, but that we keep it as is since a followup patch will
re-add some aliases to it.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi     | 2 --
 arch/arm/boot/dts/armada-375.dtsi        | 2 --
 arch/arm/boot/dts/armada-38x.dtsi        | 3 ---
 arch/arm/boot/dts/armada-xp-mv78260.dtsi | 1 -
 arch/arm/boot/dts/armada-xp-mv78460.dtsi | 1 -
 arch/arm/boot/dts/armada-xp.dtsi         | 1 -
 6 files changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 8a322ad..d36b1e5 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -59,8 +59,6 @@
 	compatible = "marvell,armada-370-xp";
 
 	aliases {
-		eth0 = &eth0;
-		eth1 = &eth1;
 	};
 
 	cpus {
diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 6307e80..0d02251 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -60,8 +60,6 @@
 		gpio0 = &gpio0;
 		gpio1 = &gpio1;
 		gpio2 = &gpio2;
-		ethernet0 = &eth0;
-		ethernet1 = &eth1;
 	};
 
 	clocks {
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index bb73cc3..044e83c 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -59,9 +59,6 @@
 	aliases {
 		gpio0 = &gpio0;
 		gpio1 = &gpio1;
-		ethernet0 = &eth0;
-		ethernet1 = &eth1;
-		ethernet2 = &eth2;
 	};
 
 	soc {
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index 4a7cbed..8479fdc 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -57,7 +57,6 @@
 		gpio0 = &gpio0;
 		gpio1 = &gpio1;
 		gpio2 = &gpio2;
-		eth3 = &eth3;
 	};
 
 	cpus {
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index 36ce63a..661d54c 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -57,7 +57,6 @@
 		gpio0 = &gpio0;
 		gpio1 = &gpio1;
 		gpio2 = &gpio2;
-		eth3 = &eth3;
 	};
 
 
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 8291723..975ae64 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -57,7 +57,6 @@
 	compatible = "marvell,armadaxp", "marvell,armada-370-xp";
 
 	aliases {
-		eth2 = &eth2;
 	};
 
 	soc {
-- 
2.1.0
