From: pebolle@tiscali.nl (Paul Bolle)
Date: Sun, 14 Jul 2013 14:02:19 +0200
Subject: [PATCH] cpufreq: s3c24xx: fix typo "ARM_S3C24XX"
Message-ID: <1373803339.1370.18.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kconfig symbol S3C24XX_PLL depends on ARM_S3C24XX. But that symbol
doesn't exist. Commit f023f8dd59bf ("cpufreq: s3c24xx: move cpufreq
driver to drivers/cpufreq"), which added this typo, makes clear that
ARM_S3C24XX_CPUFREQ was intended here.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested!

 arch/arm/mach-s3c24xx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 6d9252e..7791ac7 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -208,7 +208,7 @@ config S3C24XX_GPIO_EXTRA128
 
 config S3C24XX_PLL
 	bool "Support CPUfreq changing of PLL frequency (EXPERIMENTAL)"
-	depends on ARM_S3C24XX
+	depends on ARM_S3C24XX_CPUFREQ
 	help
 	  Compile in support for changing the PLL frequency from the
 	  S3C24XX series CPUfreq driver. The PLL takes time to settle
-- 
1.8.1.4
