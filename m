From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri,  8 Apr 2016 15:02:09 -0400
Subject: [PATCH 1/2] ARM: exynos_defconfig: Enable CPUFreq governors as modules
Message-ID: <1460142130-31822-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently only the ondemand and performance CPUFreq policy governors are
enabled in the Exynos defconfig. But the other governors are also useful
for some cases, enable them to allow users change the default if needed.

The options are enabled as module to keep the kernel image size minimal.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/configs/exynos_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 6ffd7e76f3ce..c38a33e3c861 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -28,6 +28,10 @@ CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttyS
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT_DETAILS=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=m
+CONFIG_CPU_FREQ_GOV_USERSPACE=m
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
+CONFIG_CPU_FREQ_GOV_SCHEDUTIL=m
 CONFIG_CPUFREQ_DT=y
 CONFIG_CPU_IDLE=y
 CONFIG_ARM_EXYNOS_CPUIDLE=y
-- 
2.5.0
