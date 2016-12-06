From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Tue,  6 Dec 2016 18:17:13 +0100
Subject: [PATCH 4/5] ARM: BCM5301X: Specify all RAM by including extra block
In-Reply-To: <20161206171714.22738-1-zajec5@gmail.com>
References: <20161206171714.22738-1-zajec5@gmail.com>
Message-ID: <20161206171714.22738-4-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

So far we were specifying only the first block which is always limited
up to 128 MiB. There are many devices with 256 MiB and few with 512 MiB.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts        | 3 ++-
 arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts        | 3 ++-
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  | 3 ++-
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts        | 3 ++-
 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts     | 3 ++-
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts      | 3 ++-
 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts        | 3 ++-
 arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts | 3 ++-
 arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts  | 3 ++-
 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts        | 3 ++-
 arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts  | 3 ++-
 arch/arm/boot/dts/bcm4709-netgear-r7000.dts        | 3 ++-
 arch/arm/boot/dts/bcm4709-netgear-r8000.dts        | 3 ++-
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      | 3 ++-
 arch/arm/boot/dts/bcm47094-netgear-r8500.dts       | 3 ++-
 15 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts b/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts
index 112a5a8..d241cee 100644
--- a/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts
+++ b/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts
@@ -21,7 +21,8 @@
 	};
 
 	memory {
-		reg = <0x00000000 0x08000000>;
+		reg = <0x00000000 0x08000000
+		       0x88000000 0x08000000>;
 	};
 
 	leds {
diff --git a/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts b/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
index 3600f56..b0e6204 100644
--- a/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
+++ b/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
@@ -21,7 +21,8 @@
 	};
 
 	memory {
-		reg = <0x00000000 0x08000000>;
+		reg = <0x00000000 0x08000000
+		       0x88000000 0x08000000>;
 	};
 
 	leds {
diff --git a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
index d49afec0..c9ba6b9 100644
--- a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
+++ b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
@@ -21,7 +21,8 @@
 	};
 
 	memory {
-		reg = <0x00000000 0x08000000>;
+		reg = <0x00000000 0x08000000
+		       0x88000000 0x18000000>;
 	};
 
 	spi {
diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
index 8519548..b9f66c0 100644
--- a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
+++ b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
@@ -21,7 +21,8 @@
 	};
 
 	memory {
-		reg = <0x00000000 0x08000000>;
+		reg = <0x00000000 0x08000000
+		       0x88000000 0x08000000>;
 	};
 
 	leds {
diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
index 6229ef2..ae0199f 100644
--- a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
+++ b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
@@ -21,7 +21,8 @@
 	};
 
 	memory {
-		reg = <0x00000000 0x08000000>;
+		reg = <0x00000000 0x08000000
+		       0x88000000 0x08000000>;
 	};
 
 	leds {
diff --git a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
index 74cfcd3..36b628b1 100644
--- a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
+++ b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
@@ -21,7 +21,8 @@
 	};
 
 	memory {
-		reg = <0x00000000 0x08000000>;
+		reg = <0x00000000 0x08000000
+		       0x88000000 0x08000000>;
 	};
 
 	leds {
diff --git a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
index 71b98cf..db8608b 100644
--- a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
+++ b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
@@ -21,7 +21,8 @@
 	};
 
 	memory {
-		reg = <0x00000000 0x08000000>;
+		reg = <0x00000000 0x08000000
+		       0x88000000 0x08000000>;
 	};
 
 	leds {
diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
index 2922536..d51586d 100644
--- a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
+++ b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
@@ -21,7 +21,8 @@
 	};
 
 	memory {
-		reg = <0x00000000 0x08000000>;
+		reg = <0x00000000 0x08000000
+		       0x88000000 0x08000000>;
 	};
 
 	spi {
diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts b/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
index 184fd92..de041b8 100644
--- a/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
+++ b/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
@@ -21,7 +21,8 @@
 	};
 
 	memory {
-		reg = <0x00000000 0x08000000>;
+		reg = <0x00000000 0x08000000
+		       0x88000000 0x08000000>;
 	};
 
 	gpio-keys {
diff --git a/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts b/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
index eac0f52..eaca687 100644
--- a/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
+++ b/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
@@ -21,7 +21,8 @@
 	};
 
 	memory {
-		reg = <0x00000000 0x08000000>;
+		reg = <0x00000000 0x08000000
+		       0x88000000 0x08000000>;
 	};
 
 	leds {
diff --git a/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts b/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
index aab39c9..b32957c 100644
--- a/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
+++ b/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
@@ -21,7 +21,8 @@
 	};
 
 	memory {
-		reg = <0x00000000 0x08000000>;
+		reg = <0x00000000 0x08000000
+		       0x88000000 0x18000000>;
 	};
 
 	leds {
diff --git a/arch/arm/boot/dts/bcm4709-netgear-r7000.dts b/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
index 7ab1176..f459a98 100644
--- a/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
+++ b/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
@@ -21,7 +21,8 @@
 	};
 
 	memory {
-		reg = <0x00000000 0x08000000>;
+		reg = <0x00000000 0x08000000
+		       0x88000000 0x08000000>;
 	};
 
 	leds {
diff --git a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
index 56d38a3..cd13534 100644
--- a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
+++ b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
@@ -21,7 +21,8 @@
 	};
 
 	memory {
-		reg = <0x00000000 0x08000000>;
+		reg = <0x00000000 0x08000000
+		       0x88000000 0x08000000>;
 	};
 
 	leds {
diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
index 7fb9270..64ded76 100644
--- a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
+++ b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
@@ -21,7 +21,8 @@
 	};
 
 	memory {
-		reg = <0x00000000 0x08000000>;
+		reg = <0x00000000 0x08000000
+		       0x88000000 0x08000000>;
 	};
 
 	nand: nand at 18028000 {
diff --git a/arch/arm/boot/dts/bcm47094-netgear-r8500.dts b/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
index 7ecd57c..600795e 100644
--- a/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
+++ b/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
@@ -18,7 +18,8 @@
 	};
 
 	memory {
-		reg = <0x00000000 0x08000000>;
+		reg = <0x00000000 0x08000000
+		       0x88000000 0x18000000>;
 	};
 
 	leds {
-- 
2.10.1
