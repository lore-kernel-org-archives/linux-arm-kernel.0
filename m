From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 19 Jun 2013 17:07:23 -0300
Subject: [PATCH v4 09/12] ARM: mvebu: Add BootROM to Armada 370/XP device tree
In-Reply-To: <1371672446-21583-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1371672446-21583-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1371672446-21583-10-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to access the SoC BootROM, we need to declare a mapping
(through a ranges property). The mbus driver will use this property
to allocate a suitable address decoding window.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts              | 3 ++-
 arch/arm/boot/dts/armada-370-mirabox.dts         | 3 ++-
 arch/arm/boot/dts/armada-370-rd.dts              | 3 ++-
 arch/arm/boot/dts/armada-370.dtsi                | 5 +++++
 arch/arm/boot/dts/armada-xp-db.dts               | 3 ++-
 arch/arm/boot/dts/armada-xp-gp.dts               | 3 ++-
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 3 ++-
 arch/arm/boot/dts/armada-xp.dtsi                 | 5 +++++
 8 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 4f08b4d..519a24b 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -30,7 +30,8 @@
 	};
 
 	soc {
-		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000>;
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
+			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
 
 		internal-regs {
 			serial at 12000 {
diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index df30065..69bb7aa 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -25,7 +25,8 @@
 	};
 
 	soc {
-		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000>;
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
+			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
 
 		internal-regs {
 			serial at 12000 {
diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index 7601b24..d0daa9e 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -28,7 +28,8 @@
 	};
 
 	soc {
-		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000>;
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
+			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
 
 		internal-regs {
 			serial at 12000 {
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index c274b7b..2d0ec22 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -32,6 +32,11 @@
 		compatible = "marvell,armada370-mbus", "simple-bus";
 		reg = <0xd0020000 0x100>, <0xd0020180 0x20>;
 
+		bootrom {
+			compatible = "marvell,bootrom";
+			reg = <MBUS_ID(0x01, 0xe0) 0 0x100000>;
+		};
+
 		internal-regs {
 			system-controller at 18200 {
 				compatible = "marvell,armada-370-xp-system-controller";
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 5bc9dcb..d157387 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -30,7 +30,8 @@
 	};
 
 	soc {
-		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000>;
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
+			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000>;
 
 		internal-regs {
 			serial at 12000 {
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 6c27a76..946c695 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -39,7 +39,8 @@
 	};
 
 	soc {
-		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000>;
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
+			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000>;
 
 		internal-regs {
 			serial at 12000 {
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 61b17f4..889ca6ef 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -27,7 +27,8 @@
 	};
 
 	soc {
-		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000>;
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
+			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000>;
 
 		internal-regs {
 			serial at 12000 {
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index feec757..c2ff1d1 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -26,6 +26,11 @@
 		compatible = "marvell,armadaxp-mbus", "simple-bus";
 		reg = <0 0xd0020000 0 0x100>, <0 0xd0020180 0 0x20>;
 
+		bootrom {
+			compatible = "marvell,bootrom";
+			reg = <MBUS_ID(0x01, 0x1d) 0 0x100000>;
+		};
+
 		internal-regs {
 			L2: l2-cache {
 				compatible = "marvell,aurora-system-cache";
-- 
1.8.1.5
