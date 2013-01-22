From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 21 Jan 2013 17:12:10 -0800
Subject: [PATCH 5/6] ARM: S3C24XX: Move mach-s3c2440/ cpufreq driver into
 mach-s3c24xx/
In-Reply-To: <1358817131-27169-1-git-send-email-kgene.kim@samsung.com>
References: <1358817131-27169-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1358817131-27169-6-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c2440/Kconfig                                  |    8 --------
 arch/arm/mach-s3c2440/Makefile                                 |    2 --
 arch/arm/mach-s3c24xx/Kconfig                                  |    8 ++++++++
 arch/arm/mach-s3c24xx/Makefile                                 |    1 +
 .../s3c2440-cpufreq.c => mach-s3c24xx/cpufreq-s3c2440.c}       |    4 +---
 5 files changed, 10 insertions(+), 13 deletions(-)
 rename arch/arm/{mach-s3c2440/s3c2440-cpufreq.c => mach-s3c24xx/cpufreq-s3c2440.c} (99%)

diff --git a/arch/arm/mach-s3c2440/Kconfig b/arch/arm/mach-s3c2440/Kconfig
index a4d7fd2..ad06fa2 100644
--- a/arch/arm/mach-s3c2440/Kconfig
+++ b/arch/arm/mach-s3c2440/Kconfig
@@ -2,14 +2,6 @@
 #
 # Licensed under GPLv2
 
-config S3C2440_CPUFREQ
-	bool "S3C2440/S3C2442 CPU Frequency scaling support"
-	depends on CPU_FREQ_S3C24XX && (CPU_S3C2440 || CPU_S3C2442)
-	default y
-	select S3C2410_CPUFREQ_UTILS
-	help
-	  CPU Frequency scaling support for S3C2440 and S3C2442 SoC CPUs.
-
 config S3C2440_XTAL_12000000
 	bool
 	help
diff --git a/arch/arm/mach-s3c2440/Makefile b/arch/arm/mach-s3c2440/Makefile
index 0ddd17f..d76e4b9 100644
--- a/arch/arm/mach-s3c2440/Makefile
+++ b/arch/arm/mach-s3c2440/Makefile
@@ -9,7 +9,5 @@ obj-m				:=
 obj-n				:=
 obj-				:=
 
-obj-$(CONFIG_S3C2440_CPUFREQ)	+= s3c2440-cpufreq.o
-
 obj-$(CONFIG_S3C2440_PLL_12000000) += s3c2440-pll-12000000.o
 obj-$(CONFIG_S3C2440_PLL_16934400) += s3c2440-pll-16934400.o
diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index f1d3951..edf6549 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -387,6 +387,14 @@ endif	# CPU_S3C2416
 
 if CPU_S3C2440
 
+config S3C2440_CPUFREQ
+	bool "S3C2440/S3C2442 CPU Frequency scaling support"
+	depends on CPU_FREQ_S3C24XX && (CPU_S3C2440 || CPU_S3C2442)
+	default y
+	select S3C2410_CPUFREQ_UTILS
+	help
+	  CPU Frequency scaling support for S3C2440 and S3C2442 SoC CPUs.
+
 config S3C2440_DMA
 	bool
 	help
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index 0f042d1..6d4b9ad 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_S3C2416_PM)	+= pm-s3c2416.o
 obj-$(CONFIG_CPU_S3C2440)	+= s3c2440.o irq-s3c2440.o clock-s3c2440.o
 obj-$(CONFIG_CPU_S3C2442)	+= s3c2442.o
 obj-$(CONFIG_CPU_S3C244X)	+= s3c244x.o irq-s3c244x.o clock-s3c244x.o
+obj-$(CONFIG_S3C2440_CPUFREQ)	+= cpufreq-s3c2440.o
 obj-$(CONFIG_S3C2440_DMA)	+= dma-s3c2440.o
 
 obj-$(CONFIG_CPU_S3C2443)	+= s3c2443.o irq-s3c2443.o clock-s3c2443.o
diff --git a/arch/arm/mach-s3c2440/s3c2440-cpufreq.c b/arch/arm/mach-s3c24xx/cpufreq-s3c2440.c
similarity index 99%
rename from arch/arm/mach-s3c2440/s3c2440-cpufreq.c
rename to arch/arm/mach-s3c24xx/cpufreq-s3c2440.c
index 6177676..72b2cc8 100644
--- a/arch/arm/mach-s3c2440/s3c2440-cpufreq.c
+++ b/arch/arm/mach-s3c24xx/cpufreq-s3c2440.c
@@ -1,5 +1,4 @@
-/* linux/arch/arm/plat-s3c24xx/s3c2440-cpufreq.c
- *
+/*
  * Copyright (c) 2006-2009 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
@@ -310,5 +309,4 @@ static int s3c2442_cpufreq_init(void)
 {
 	return subsys_interface_register(&s3c2442_cpufreq_interface);
 }
-
 subsys_initcall(s3c2442_cpufreq_init);
-- 
1.7.10.4
