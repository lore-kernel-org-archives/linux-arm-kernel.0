From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 10 May 2011 15:42:08 +0200
Subject: [PATCH] CPUFREQ/S3C64xx: Move S3C64xx CPUfreq driver into
	drivers/cpufreq
Message-ID: <1305034928-25835-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a straight code motion patch, there are no changes to the driver
itself. The Kconfig is left untouched as the ARM CPUfreq Kconfig is all
in one big block in arm/Kconfig and should be moved en masse rather than
being done piecemeal.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/Makefile                     |    4 ----
 drivers/cpufreq/Makefile                           |    2 ++
 .../cpufreq.c => drivers/cpufreq/s3c64xx.c         |    3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)
 rename arch/arm/mach-s3c64xx/cpufreq.c => drivers/cpufreq/s3c64xx.c (99%)

diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index 88d7fd2..61b4034 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -23,10 +23,6 @@ obj-$(CONFIG_CPU_S3C6410)	+= s3c6410.o
 obj-y				+= irq.o
 obj-y				+= irq-eint.o
 
-# CPU frequency scaling
-
-obj-$(CONFIG_CPU_FREQ_S3C64XX)  += cpufreq.o
-
 # DMA support
 
 obj-$(CONFIG_S3C64XX_DMA)	+= dma.o
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index e3fc242..2edd08f 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -39,3 +39,5 @@ obj-$(CONFIG_X86_CPUFREQ_NFORCE2)	+= cpufreq-nforce2.o
 
 ##################################################################################d
 
+# ARM CPUfreq drivers
+obj-$(CONFIG_CPU_FREQ_S3C64XX)  += s3c64xx.o
diff --git a/arch/arm/mach-s3c64xx/cpufreq.c b/drivers/cpufreq/s3c64xx.c
similarity index 99%
rename from arch/arm/mach-s3c64xx/cpufreq.c
rename to drivers/cpufreq/s3c64xx.c
index 1e7df30..c370935 100644
--- a/arch/arm/mach-s3c64xx/cpufreq.c
+++ b/drivers/cpufreq/s3c64xx.c
@@ -1,5 +1,4 @@
-/* linux/arch/arm/plat-s3c64xx/cpufreq.c
- *
+/*
  * Copyright 2009 Wolfson Microelectronics plc
  *
  * S3C64xx CPUfreq Support
-- 
1.7.4.1
