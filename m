From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Feb 2012 09:49:40 +0000
Subject: [CPUFREQ] Fix exposure of ARM_EXYNOS4210_CPUFREQ
Message-ID: <20120213094940.GA15338@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King <rmk+kernel@arm.linux.org.uk>

exynos4210-cpufreq.c is not buildable on non-exynos builds, so it's
pointless allowing this option to be exposed.  Fix this by adding a
dependency on ARCH_EXYNOS.

drivers/cpufreq/exynos4210-cpufreq.c:20:29: error: mach/regs-clock.h: No such file or directory
drivers/cpufreq/exynos4210-cpufreq.c:21:26: error: mach/cpufreq.h: No such file or directory

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Dave Jones <davej@redhat.com>
Cc: cpufreq at vger.kernel.org
Cc: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/cpufreq/Kconfig.arm |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index e0664fe..c8bde43 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -34,6 +34,7 @@ config ARM_EXYNOS_CPUFREQ
 
 config ARM_EXYNOS4210_CPUFREQ
 	bool "Samsung EXYNOS4210"
+	depends on ARCH_EXYNOS
 	help
 	  This adds the CPUFreq driver for Samsung EXYNOS4210
 	  SoC (S5PV310 or S5PC210).
