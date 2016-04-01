From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 01 Apr 2016 15:57:54 +0900
Subject: [PATCH 11/11] ARM: dts: s5p: Fix DTC unit name warnings in S5Pv210
 boards
In-Reply-To: <1459493874-2366-1-git-send-email-k.kozlowski@samsung.com>
References: <1459493874-2366-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1459493874-2366-11-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix following DTC warnings in S5Pv210 boards:

Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /soc/fimd at f8000000/display-timings/timing at 0 has a unit name, but no reg property

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/s5pv210-aquila.dts   | 2 +-
 arch/arm/boot/dts/s5pv210-goni.dts     | 2 +-
 arch/arm/boot/dts/s5pv210-smdkc110.dts | 2 +-
 arch/arm/boot/dts/s5pv210-smdkv210.dts | 4 ++--
 arch/arm/boot/dts/s5pv210-torbreck.dts | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

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
index 54fcc3fc82e2..75398318ed57 100644
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
@@ -197,7 +197,7 @@
 	display-timings {
 		native-mode = <&timing0>;
 
-		timing0: timing at 0 {
+		timing0: timing {
 			/* 800x480 at 60Hz */
 			clock-frequency = <24373920>;
 			hactive = <800>;
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
2.5.0
