From: sbkim73@samsung.com (Sangbeom Kim)
Date: Mon, 20 Sep 2010 15:04:55 +0900
Subject: [PATCH v2 6/6] ARM: S5PV210: Update Kconfig and Makefile for
	supporting CPUFREQ driver
In-Reply-To: <1284962695-8542-1-git-send-email-sbkim73@samsung.com>
References: <1284962695-8542-1-git-send-email-sbkim73@samsung.com>
Message-ID: <1284962695-8542-7-git-send-email-sbkim73@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaecheol Lee <jc.lee@samsung.com>

This patch adds ARCH_HAS_CPUFREQ in arch/arm/Kconfig for S5PV210,
and updates mach-s5pv210/Makefile for supporting build CPUFREQ driver.

Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
---
 arch/arm/Kconfig               |    1 +
 arch/arm/mach-s5pv210/Makefile |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index bce9193..7bff1d2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -721,6 +721,7 @@ config ARCH_S5PV210
 	select GENERIC_GPIO
 	select HAVE_CLK
 	select ARM_L1_CACHE_SHIFT_6
+	select ARCH_HAS_CPUFREQ
 	select ARCH_USES_GETTIMEOFFSET
 	select HAVE_S3C2410_I2C
 	select HAVE_S3C_RTC
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index 7045489..833d803 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -14,6 +14,7 @@ obj-				:=
 
 obj-$(CONFIG_CPU_S5PV210)	+= cpu.o init.o clock.o dma.o gpiolib.o
 obj-$(CONFIG_CPU_S5PV210)	+= setup-i2c0.o
+obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
 
 # machine support
 
-- 
1.6.2.5
