From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  2 Mar 2013 13:22:51 +0400
Subject: [PATCH 1/4] ARM: s3c24xx: Removed unneeded dependency on ARCH_S3C24XX
 for boards
Message-ID: <1362216174-10478-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Board options are already under "if ARCH_S3C24XX" condition, so
additional dependencies on this symbol can be removed.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-s3c24xx/Kconfig | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 37f513d..567d77b 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -36,7 +36,6 @@ config CPU_S3C2410
 
 config CPU_S3C2412
 	bool "SAMSUNG S3C2412"
-	depends on ARCH_S3C24XX
 	select CPU_ARM926T
 	select CPU_LLSERIAL_S3C2440
 	select S3C2412_DMA if S3C24XX_DMA
@@ -46,7 +45,6 @@ config CPU_S3C2412
 
 config CPU_S3C2416
 	bool "SAMSUNG S3C2416/S3C2450"
-	depends on ARCH_S3C24XX
 	select CPU_ARM926T
 	select CPU_LLSERIAL_S3C2440
 	select S3C2416_PM if PM
@@ -81,7 +79,6 @@ config CPU_S3C244X
 
 config CPU_S3C2443
 	bool "SAMSUNG S3C2443"
-	depends on ARCH_S3C24XX
 	select CPU_ARM920T
 	select CPU_LLSERIAL_S3C2440
 	select S3C2443_COMMON
@@ -133,7 +130,6 @@ config S3C24XX_SETUP_TS
 
 config S3C24XX_DMA
 	bool "S3C2410 DMA support"
-	depends on ARCH_S3C24XX
 	select S3C_DMA
 	help
 	  S3C2410 DMA support. This is needed for drivers like sound which
@@ -142,7 +138,7 @@ config S3C24XX_DMA
 
 config S3C2410_DMA_DEBUG
 	bool "S3C2410 DMA support debug"
-	depends on ARCH_S3C24XX && S3C2410_DMA
+	depends on S3C2410_DMA
 	help
 	  Enable debugging output for the DMA code. This option sends info
 	  to the kernel log, at priority KERN_DEBUG.
@@ -380,9 +376,8 @@ if CPU_S3C2412
 
 config CPU_S3C2412_ONLY
 	bool
-	depends on ARCH_S3C24XX && !CPU_S3C2410 && \
-		   !CPU_S3C2416 && !CPU_S3C2440 && !CPU_S3C2442 && \
-		   !CPU_S3C2443 && CPU_S3C2412
+	depends on !CPU_S3C2410 && !CPU_S3C2416 && !CPU_S3C2440 && \
+		   !CPU_S3C2442 && !CPU_S3C2443 && CPU_S3C2412
 	default y
 
 config S3C2412_CPUFREQ
-- 
1.7.12.4
