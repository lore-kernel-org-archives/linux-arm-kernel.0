From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 18 Sep 2010 11:45:16 +0900
Subject: [PATCH 4/4] ARM: S5PV310: Update Kconfig and Makefile for supporting
	CPUFREQ
In-Reply-To: <1284777916-23257-1-git-send-email-kgene.kim@samsung.com>
References: <1284777916-23257-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1284777916-23257-5-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunyoung Kang <sy0816.kang@samsung.com>

This patch adds ARCH_HAS_CPUFREQ in Kconfig of ARCH_S5PV310 and updates
Makefile for supporting build S5PV310 CPUFREQ driver.

Signed-off-by: Sunyoung Kang <sy0816.kang@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/Kconfig               |    1 +
 arch/arm/mach-s5pv310/Makefile |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index bce9193..6424eec 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -733,6 +733,7 @@ config ARCH_S5PV310
 	select CPU_V7
 	select GENERIC_GPIO
 	select HAVE_CLK
+	select ARCH_HAS_CPUFREQ
 	select GENERIC_CLOCKEVENTS
 	help
 	  Samsung S5PV310 series based systems
diff --git a/arch/arm/mach-s5pv310/Makefile b/arch/arm/mach-s5pv310/Makefile
index aefb14f..d17c8c7 100644
--- a/arch/arm/mach-s5pv310/Makefile
+++ b/arch/arm/mach-s5pv310/Makefile
@@ -14,6 +14,7 @@ obj-				:=
 
 obj-$(CONFIG_CPU_S5PV310)	+= cpu.o init.o clock.o irq-combiner.o
 obj-$(CONFIG_CPU_S5PV310)	+= setup-i2c0.o time.o
+obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
 
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
-- 
1.6.2.5
