From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 12 May 2010 03:36:06 +0100
Subject: [PATCH 15/15] ARM: SAMSUNG: Update S3C2416 entry with S3C2450
In-Reply-To: <1273631766-15693-1-git-send-email-ben-linux@fluff.org>
References: <1273631766-15693-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1273631766-15693-15-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These devices are so similar that they share the same SoC
ID code, so note this.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/Kconfig              |    6 +++++-
 arch/arm/mach-s3c2416/Kconfig |    3 +++
 arch/arm/plat-s3c24xx/cpu.c   |    2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 6785c33..3f8718f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -647,7 +647,7 @@ config ARCH_SA1100
 	  Support for StrongARM 11x0 based boards.
 
 config ARCH_S3C2410
-	bool "Samsung S3C2410, S3C2412, S3C2413, S3C2416, S3C2440, S3C2442, S3C2443"
+	bool "Samsung S3C2410, S3C2412, S3C2413, S3C2416, S3C2440, S3C2442, S3C2443, S3C2450"
 	select GENERIC_GPIO
 	select ARCH_HAS_CPUFREQ
 	select HAVE_CLK
@@ -656,6 +656,10 @@ config ARCH_S3C2410
 	  BAST (<http://www.simtec.co.uk/products/EB110ITX/>), the IPAQ 1940 or
 	  the Samsung SMDK2410 development board (and derivatives).
 
+	  Note, the S3C2416 and the S3C2450 are so close that they even share
+	  the same SoC ID code. This means that there is no seperate machine
+	  directory (no arch/arm/mach-s3c2450) as the S3C2416 was first.
+
 config ARCH_S3C64XX
 	bool "Samsung S3C64XX"
 	select PLAT_SAMSUNG
diff --git a/arch/arm/mach-s3c2416/Kconfig b/arch/arm/mach-s3c2416/Kconfig
index 6d077b2..29103a6 100644
--- a/arch/arm/mach-s3c2416/Kconfig
+++ b/arch/arm/mach-s3c2416/Kconfig
@@ -4,6 +4,9 @@
 #
 # Licensed under GPLv2
 
+# note, this also supports the S3C2450 which is so similar it has the same
+# ID code as the S3C2416.
+
 config CPU_S3C2416
 	bool
 	depends on ARCH_S3C2410
diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
index 32db856..76d0858 100644
--- a/arch/arm/plat-s3c24xx/cpu.c
+++ b/arch/arm/plat-s3c24xx/cpu.c
@@ -58,7 +58,7 @@
 static const char name_s3c2400[]  = "S3C2400";
 static const char name_s3c2410[]  = "S3C2410";
 static const char name_s3c2412[]  = "S3C2412";
-static const char name_s3c2416[]  = "S3C2416";
+static const char name_s3c2416[]  = "S3C2416/S3C2450";
 static const char name_s3c2440[]  = "S3C2440";
 static const char name_s3c2442[]  = "S3C2442";
 static const char name_s3c2442b[]  = "S3C2442B";
-- 
1.6.3.3
