From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed,  3 Mar 2010 16:38:15 +0200
Subject: [PATCH] s3c244x: Fix compilation issue due to moved cpufreq-related
	files
Message-ID: <1267627095-24200-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cpufreq-related files were moved but Makefiles were not modified, and it
breaks compilation when CONFIG_S3C2440_CPUFREQ=y.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-s3c2440/Makefile |    4 ----
 arch/arm/plat-s3c24xx/Makefile |    4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c2440/Makefile b/arch/arm/mach-s3c2440/Makefile
index c85ba32..1825516 100644
--- a/arch/arm/mach-s3c2440/Makefile
+++ b/arch/arm/mach-s3c2440/Makefile
@@ -19,10 +19,6 @@ obj-$(CONFIG_S3C2440_DMA)	+= dma.o
 obj-$(CONFIG_CPU_S3C244X)	+= s3c244x.o
 obj-$(CONFIG_CPU_S3C244X)	+= s3c244x-irq.o
 obj-$(CONFIG_CPU_S3C244X)	+= s3c244x-clock.o
-obj-$(CONFIG_S3C2440_CPUFREQ)	+= s3c2440-cpufreq.o
-
-obj-$(CONFIG_S3C2440_PLL_12000000) += s3c2440-pll-12000000.o
-obj-$(CONFIG_S3C2440_PLL_16934400) += s3c2440-pll-16934400.o
 
 # Machine support
 
diff --git a/arch/arm/plat-s3c24xx/Makefile b/arch/arm/plat-s3c24xx/Makefile
index c2237c4..b3a7ac2 100644
--- a/arch/arm/plat-s3c24xx/Makefile
+++ b/arch/arm/plat-s3c24xx/Makefile
@@ -22,6 +22,10 @@ obj-$(CONFIG_S3C24XX_DCLK)	+= clock-dclk.o
 
 obj-$(CONFIG_CPU_FREQ_S3C24XX)	+= cpu-freq.o
 obj-$(CONFIG_CPU_FREQ_S3C24XX_DEBUGFS) += cpu-freq-debugfs.o
+obj-$(CONFIG_S3C2440_CPUFREQ)	+= s3c2440-cpufreq.o
+
+obj-$(CONFIG_S3C2440_PLL_12000000) += s3c2440-pll-12000000.o
+obj-$(CONFIG_S3C2440_PLL_16934400) += s3c2440-pll-16934400.o
 
 # Architecture dependant builds
 
-- 
1.7.0
