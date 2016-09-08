From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu,  8 Sep 2016 11:26:01 -0400
Subject: [PATCH 2/2] ARM: dts: s5p: Add missing unit name to memory nodes for
 S5PV210 boards
In-Reply-To: <1473348361-15784-1-git-send-email-javier@osg.samsung.com>
References: <1473348361-15784-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1473348361-15784-3-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following DTC warnings:

"Node /memory has a reg or ranges property, but no unit name"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 arch/arm/boot/dts/s5pv210-aquila.dts   | 2 +-
 arch/arm/boot/dts/s5pv210-goni.dts     | 2 +-
 arch/arm/boot/dts/s5pv210-smdkc110.dts | 2 +-
 arch/arm/boot/dts/s5pv210-smdkv210.dts | 2 +-
 arch/arm/boot/dts/s5pv210-torbreck.dts | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210-aquila.dts b/arch/arm/boot/dts/s5pv210-aquila.dts
index da24ab570b0e..d763c5b4c65d 100644
--- a/arch/arm/boot/dts/s5pv210-aquila.dts
+++ b/arch/arm/boot/dts/s5pv210-aquila.dts
@@ -29,7 +29,7 @@
 		bootargs = "console=ttySAC2,115200n8 root=/dev/mmcblk1p5 rw rootwait ignore_loglevel earlyprintk";
 	};
 
-	memory {
+	memory at 30000000 {
 		device_type = "memory";
 		reg = <0x30000000 0x05000000
 			0x40000000 0x18000000>;
diff --git a/arch/arm/boot/dts/s5pv210-goni.dts b/arch/arm/boot/dts/s5pv210-goni.dts
index 0a33d402138e..c56f51ee7897 100644
--- a/arch/arm/boot/dts/s5pv210-goni.dts
+++ b/arch/arm/boot/dts/s5pv210-goni.dts
@@ -29,7 +29,7 @@
 		bootargs = "console=ttySAC0,115200n8 root=/dev/mmcblk0p5 rw rootwait ignore_loglevel earlyprintk";
 	};
 
-	memory {
+	memory at 30000000 {
 		device_type = "memory";
 		reg = <0x30000000 0x05000000
 			0x40000000 0x10000000
diff --git a/arch/arm/boot/dts/s5pv210-smdkc110.dts b/arch/arm/boot/dts/s5pv210-smdkc110.dts
index 1eedab7ffe94..5d14da911aa5 100644
--- a/arch/arm/boot/dts/s5pv210-smdkc110.dts
+++ b/arch/arm/boot/dts/s5pv210-smdkc110.dts
@@ -29,7 +29,7 @@
 		bootargs = "console=ttySAC0,115200n8 root=/dev/mmcblk0p1 rw rootwait ignore_loglevel earlyprintk";
 	};
 
-	memory {
+	memory@20000000 {
 		device_type = "memory";
 		reg = <0x20000000 0x20000000>;
 	};
diff --git a/arch/arm/boot/dts/s5pv210-smdkv210.dts b/arch/arm/boot/dts/s5pv210-smdkv210.dts
index 9eb6aff3e38f..75398318ed57 100644
--- a/arch/arm/boot/dts/s5pv210-smdkv210.dts
+++ b/arch/arm/boot/dts/s5pv210-smdkv210.dts
@@ -29,7 +29,7 @@
 		bootargs = "console=ttySAC0,115200n8 root=/dev/mmcblk0p1 rw rootwait ignore_loglevel earlyprintk";
 	};
 
-	memory {
+	memory at 20000000 {
 		device_type = "memory";
 		reg = <0x20000000 0x40000000>;
 	};
diff --git a/arch/arm/boot/dts/s5pv210-torbreck.dts b/arch/arm/boot/dts/s5pv210-torbreck.dts
index 622599fd2cfa..7cb50bcee888 100644
--- a/arch/arm/boot/dts/s5pv210-torbreck.dts
+++ b/arch/arm/boot/dts/s5pv210-torbreck.dts
@@ -29,7 +29,7 @@
 		bootargs = "console=ttySAC0,115200n8 root=/dev/mmcblk0p1 rw rootwait ignore_loglevel earlyprintk";
 	};
 
-	memory {
+	memory at 20000000 {
 		device_type = "memory";
 		reg = <0x20000000 0x20000000>;
 	};
-- 
2.7.4
