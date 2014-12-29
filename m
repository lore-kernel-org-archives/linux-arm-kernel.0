From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:43:19 +0900
Subject: [PATCH 2/5] ARM: shmobile: defconfig: cleanup by savedefconfig
In-Reply-To: <cover.1419808942.git.horms+renesas@verge.net.au>
References: <cover.1419808942.git.horms+renesas@verge.net.au>
Message-ID: <ff550a37cda1f8ef9f383b456a9403c9e636fc9e.1419808942.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current shmobile_defconfig is not created from savedefconfig.
Therefore, next defconfig patch will be unreadable. this patch
tidyup this issue by below command

 > make shmobile_defconfig
 > make savedefconfig
 > cp defconfig ${LINUX}/arch/arm/config/shmobile_defconfig

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
[horms: Resolved conflicts; in particular leaving CONFIG_CPUFREQ_DT enabled]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 3df6ca0..ad52868 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -19,7 +19,6 @@ CONFIG_ARCH_R8A7791=y
 CONFIG_ARCH_R8A7794=y
 CONFIG_MACH_LAGER=y
 CONFIG_MACH_MARZEN=y
-# CONFIG_SWP_EMULATE is not set
 CONFIG_CPU_BPREDICT_DISABLE=y
 CONFIG_PL310_ERRATA_588369=y
 CONFIG_ARM_ERRATA_754322=y
@@ -36,6 +35,13 @@ CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_KEXEC=y
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_STAT_DETAILS=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=y
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_CPU_FREQ_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
+CONFIG_CPUFREQ_DT=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
@@ -98,9 +104,10 @@ CONFIG_GPIO_EM=y
 CONFIG_GPIO_RCAR=y
 # CONFIG_HWMON is not set
 CONFIG_THERMAL=y
+CONFIG_CPU_THERMAL=y
 CONFIG_RCAR_THERMAL=y
 CONFIG_REGULATOR=y
-CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_REGULATOR_DA9210=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_MEDIA_CAMERA_SUPPORT=y
@@ -154,7 +161,6 @@ CONFIG_PWM_RENESAS_TPU=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
-CONFIG_CONFIGFS_FS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
@@ -166,16 +172,3 @@ CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_ARM_UNWIND is not set
-CONFIG_CPU_FREQ=y
-CONFIG_CPU_FREQ_GOV_COMMON=y
-CONFIG_CPU_FREQ_STAT=y
-CONFIG_CPU_FREQ_STAT_DETAILS=y
-CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
-CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
-CONFIG_CPU_FREQ_GOV_POWERSAVE=y
-CONFIG_CPU_FREQ_GOV_USERSPACE=y
-CONFIG_CPU_FREQ_GOV_ONDEMAND=y
-CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
-CONFIG_CPU_THERMAL=y
-CONFIG_CPUFREQ_DT=y
-CONFIG_REGULATOR_DA9210=y
-- 
2.1.3
