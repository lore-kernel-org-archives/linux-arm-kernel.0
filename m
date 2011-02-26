From: sbkim73@samsung.com (Sangbeom Kim)
Date: Sat, 26 Feb 2011 11:45:57 +0900
Subject: [PATCH 3/3] ARM: S5P: Update defconfig for HRT support
In-Reply-To: <1298688357-20775-1-git-send-email-sbkim73@samsung.com>
References: <1298688357-20775-1-git-send-email-sbkim73@samsung.com>
Message-ID: <1298688357-20775-4-git-send-email-sbkim73@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modify s5pv210_defconfig and s5p64x0_defconfig
for HRT support

Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
---
 arch/arm/Kconfig                   |    4 ++--
 arch/arm/configs/s5p64x0_defconfig |    2 ++
 arch/arm/configs/s5pv210_defconfig |    2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 166efa2..8b959e1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -715,7 +715,7 @@ config ARCH_S5P64X0
 	select GENERIC_GPIO
 	select HAVE_CLK
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-	select ARCH_USES_GETTIMEOFFSET
+	select GENERIC_CLOCKEVENTS
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C_RTC if RTC_CLASS
 	help
@@ -753,7 +753,7 @@ config ARCH_S5PV210
 	select HAVE_CLK
 	select ARM_L1_CACHE_SHIFT_6
 	select ARCH_HAS_CPUFREQ
-	select ARCH_USES_GETTIMEOFFSET
+	select GENERIC_CLOCKEVENTS
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C_RTC if RTC_CLASS
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
diff --git a/arch/arm/configs/s5p64x0_defconfig b/arch/arm/configs/s5p64x0_defconfig
index 2993ecd..ad6b61b 100644
--- a/arch/arm/configs/s5p64x0_defconfig
+++ b/arch/arm/configs/s5p64x0_defconfig
@@ -10,6 +10,8 @@ CONFIG_S3C_BOOT_ERROR_RESET=y
 CONFIG_S3C_LOWLEVEL_UART_PORT=1
 CONFIG_MACH_SMDK6440=y
 CONFIG_MACH_SMDK6450=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_CPU_32v6K=y
 CONFIG_AEABI=y
 CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x20800000,8M console=ttySAC1,115200 init=/linuxrc"
diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
index 0488a1e..fa98990 100644
--- a/arch/arm/configs/s5pv210_defconfig
+++ b/arch/arm/configs/s5pv210_defconfig
@@ -13,6 +13,8 @@ CONFIG_MACH_AQUILA=y
 CONFIG_MACH_GONI=y
 CONFIG_MACH_SMDKC110=y
 CONFIG_MACH_SMDKV210=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_VMSPLIT_2G=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
-- 
1.7.1
