From: khilman@ti.com (Kevin Hilman)
Date: Wed, 15 Feb 2012 11:21:49 -0800
Subject: [PATCH] cpufreq: OMAP driver depends CPUfreq tables
Message-ID: <1329333709-29964-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King <rmk+kernel@arm.linux.org.uk>

The OMAP driver depends on CPUfreq table support for creating a table
of frequencies from the OPP layer.  Ensure that it's build to avoid
link-time errors.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/cpufreq/Kconfig.arm |    5 +++++
 drivers/cpufreq/Makefile    |    2 +-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index e0664fe..015f026 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -2,6 +2,11 @@
 # ARM CPU Frequency scaling drivers
 #
 
+config ARM_OMAP2PLUS_CPUFREQ
+	bool
+	depends on ARCH_OMAP2PLUS
+	select CPU_FREQ_TABLE
+
 config ARM_S3C64XX_CPUFREQ
 	bool "Samsung S3C64XX"
 	depends on CPU_S3C6410
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index ac000fa..fda94c7 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -44,7 +44,7 @@ obj-$(CONFIG_ARM_S3C64XX_CPUFREQ)	+= s3c64xx-cpufreq.o
 obj-$(CONFIG_ARM_S5PV210_CPUFREQ)	+= s5pv210-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)	+= exynos-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+= exynos4210-cpufreq.o
-obj-$(CONFIG_ARCH_OMAP2PLUS)            += omap-cpufreq.o
+obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)     += omap-cpufreq.o
 
 ##################################################################################
 # PowerPC platform drivers
-- 
1.7.9
