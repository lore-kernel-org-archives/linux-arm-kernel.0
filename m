From: dg77.kim@samsung.com (Donggeun Kim)
Date: Fri, 27 May 2011 15:07:08 +0900
Subject: [PATCH] CPUFREQ/S5PV210,EXYNOS4: Move S5PV210 and EXYNOS4 CPUfreq
	drivers into drivers/cpufreq
Message-ID: <1306476428-24808-1-git-send-email-dg77.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch simply moves CPUfreq drivers for S5PV210 and EXYNOS4
into drivers/cpufreq directoty. The driver codes were not modified.

Signed-off-by: Donggeun Kim <dg77.kim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos4/Makefile                     |    1 -
 arch/arm/mach-s5pv210/Makefile                     |    1 -
 drivers/cpufreq/Makefile                           |    3 +++
 .../cpufreq.c => drivers/cpufreq/exynos4.c         |    3 +--
 .../cpufreq.c => drivers/cpufreq/s5pv210.c         |    3 +--
 5 files changed, 5 insertions(+), 6 deletions(-)
 rename arch/arm/mach-exynos4/cpufreq.c => drivers/cpufreq/exynos4.c (99%)
 rename arch/arm/mach-s5pv210/cpufreq.c => drivers/cpufreq/s5pv210.c (99%)

diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index 9be104f..7bf1c01 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -15,7 +15,6 @@ obj-				:=
 obj-$(CONFIG_CPU_EXYNOS4210)	+= cpu.o init.o clock.o irq-combiner.o
 obj-$(CONFIG_CPU_EXYNOS4210)	+= setup-i2c0.o gpiolib.o irq-eint.o dma.o
 obj-$(CONFIG_PM)		+= pm.o sleep.o
-obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
 
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index 11f1790..435d23e 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -15,7 +15,6 @@ obj-				:=
 obj-$(CONFIG_CPU_S5PV210)	+= cpu.o init.o clock.o dma.o gpiolib.o
 obj-$(CONFIG_CPU_S5PV210)	+= setup-i2c0.o
 obj-$(CONFIG_S5PV210_PM)	+= pm.o sleep.o
-obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
 
 # machine support
 
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index c7f1a6f..92f2222 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -39,3 +39,6 @@ obj-$(CONFIG_X86_CPUFREQ_NFORCE2)	+= cpufreq-nforce2.o
 
 ##################################################################################d
 
+# ARM CPUfreq drivers
+obj-$(CONFIG_CPU_FREQ_S5PV210)		+= s5pv210.o
+obj-$(CONFIG_CPU_FREQ_EXYNOS4)		+= exynos4.o
diff --git a/arch/arm/mach-exynos4/cpufreq.c b/drivers/cpufreq/exynos4.c
similarity index 99%
rename from arch/arm/mach-exynos4/cpufreq.c
rename to drivers/cpufreq/exynos4.c
index a1bd258..54025fc 100644
--- a/arch/arm/mach-exynos4/cpufreq.c
+++ b/drivers/cpufreq/exynos4.c
@@ -1,5 +1,4 @@
-/* linux/arch/arm/mach-exynos4/cpufreq.c
- *
+/*
  * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
diff --git a/arch/arm/mach-s5pv210/cpufreq.c b/drivers/cpufreq/s5pv210.c
similarity index 99%
rename from arch/arm/mach-s5pv210/cpufreq.c
rename to drivers/cpufreq/s5pv210.c
index 22046e2..c482fc8 100644
--- a/arch/arm/mach-s5pv210/cpufreq.c
+++ b/drivers/cpufreq/s5pv210.c
@@ -1,5 +1,4 @@
-/* linux/arch/arm/mach-s5pv210/cpufreq.c
- *
+/*
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
-- 
1.7.4.1
