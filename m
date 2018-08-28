From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 28 Aug 2018 16:56:46 +0200
Subject: [PATCH] ARM: shmobile: defconfig: Refresh shmobile_defconfig for
 v4.19-rc1
Message-ID: <20180828145646.12014-1-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Refresh the defconfig for Renesas ARM boards:
  - Move options that have moved,
  - Remove CONFIG_HAVE_ARM_ARCH_TIMER (auto-enabled),
  - Remove ENABLE_WARN_DEPRECATED (removed).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/configs/shmobile_defconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index c8f2cb9fc7f3c8d8..7b48ec3e63ec3234 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -32,10 +32,8 @@ CONFIG_PCI_RCAR_GEN2=y
 CONFIG_PCIE_RCAR=y
 CONFIG_SMP=y
 CONFIG_SCHED_MC=y
-CONFIG_HAVE_ARM_ARCH_TIMER=y
 CONFIG_NR_CPUS=8
 CONFIG_HIGHMEM=y
-CONFIG_CMA=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
@@ -50,6 +48,7 @@ CONFIG_CPUFREQ_DT=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_CMA=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -207,7 +206,6 @@ CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_ARM_UNWIND is not set
-- 
2.17.1
