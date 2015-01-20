From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Tue, 20 Jan 2015 07:34:01 +0100
Subject: [PATCH RFC] ARM: BCM5301X: Specify RAM on devices by including HIGHMEM
Message-ID: <1421735641-8404-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please note that before enabling CONFIG_HIGHMEM we should add support
for swiotlb (on ARM).

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  | 3 ++-
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts        | 3 ++-
 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts     | 3 ++-
 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts        | 3 ++-
 arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts | 3 ++-
 arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts  | 3 ++-
 6 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
index ce083a5..fdd0837 100644
--- a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
+++ b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
@@ -20,7 +20,8 @@
 	};
 
 	memory {
-		reg = <0x00000000 0x08000000>;
+		reg = <0x00000000 0x08000000
+		       0x88000000 0x18000000>;
 	};
 
 	spi {
diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
index 0a5f561..bbe4462 100644
--- a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
+++ b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
@@ -20,7 +20,8 @@
 	};
 
 	memory {
-		reg = <0x00000000 0x08000000>;
+		reg = <0x00000000 0x08000000
+		       0x88000000 0x08000000>;
 	};
 
 	chipcommonA {
diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
index 3991042..48e182e 100644
--- a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
+++ b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
@@ -20,7 +20,8 @@
 	};
 
 	memory {
-		reg = <0x00000000 0x08000000>;
+		reg = <0x00000000 0x08000000
+		       0x88000000 0x08000000>;
 	};
 
 	leds {
diff --git a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
index 4d87219..ab32f32 100644
--- a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
+++ b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
@@ -20,7 +20,8 @@
 	};
 
 	memory {
-		reg = <0x00000000 0x08000000>;
+		reg = <0x00000000 0x08000000
+		       0x88000000 0x08000000>;
 	};
 
 	leds {
diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
index 362f914..8025f32 100644
--- a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
+++ b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
@@ -20,7 +20,8 @@
 	};
 
 	memory {
-		reg = <0x00000000 0x08000000>;
+		reg = <0x00000000 0x08000000
+		       0x88000000 0x08000000>;
 	};
 
 	spi {
diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts b/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
index b5352c0..2311c6a 100644
--- a/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
+++ b/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
@@ -20,7 +20,8 @@
 	};
 
 	memory {
-		reg = <0x00000000 0x08000000>;
+		reg = <0x00000000 0x08000000
+		       0x88000000 0x08000000>;
 	};
 
 	gpio-keys {
-- 
1.8.4.5
