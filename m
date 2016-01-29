From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Jan 2016 15:50:34 +0100
Subject: [PATCH 2/6] ARM: s3c24xx: allow selecting S3C2440_XTAL_16934400 for
 s3c2442
In-Reply-To: <1454079040-3567945-1-git-send-email-arnd@arndb.de>
References: <1454079040-3567945-1-git-send-email-arnd@arndb.de>
Message-ID: <1454079040-3567945-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The S3C2440_XTAL_16934400 and S3C2440_XTAL_12000000 symbols are used
for both s3c2442 and s3c2440, but Kconfig only allows it to be selected
if CPU_S3C2440 is enabled, which can lead to a warning otherwise:

warning: (MACH_RX1950) selects S3C2440_XTAL_16934400 which has unmet direct dependencies (ARCH_S3C24XX && CPU_S3C2440)

This changes the dependencies to make it possible also for CPU_S3C2442-only
configurations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c24xx/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index c94ef77405ed..5884bbb7952e 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -405,7 +405,7 @@ config MACH_S3C2416_DT
 
 endif	# CPU_S3C2416
 
-if CPU_S3C2440
+if CPU_S3C2440 || CPU_S3C2442
 
 config S3C2440_XTAL_12000000
 	bool
@@ -432,6 +432,9 @@ config S3C2440_PLL_16934400
 	default y if S3C24XX_PLL
 	help
 	  PLL tables for S3C2440 or S3C2442 CPUs with 16.934MHz crystals.
+endif
+
+if CPU_S3C2440
 
 comment "S3C2440 Boards"
 
-- 
2.7.0
