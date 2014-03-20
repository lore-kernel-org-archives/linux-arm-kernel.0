From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 20 Mar 2014 17:13:45 +0530
Subject: [GIT PULL] DaVinci SoC fixes for v3.15
Message-ID: <532AD471.5030305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here is a fix from Kevin over the soc pull request
sent earlier.

Thanks,
Sekhar

The following changes since commit 4b9e44f8d7c9cd166d8304b8f619741c1d59b836:

  ARM: davinci: remove da8xx_omapl_defconfig (2014-03-06 19:08:30 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.15/soc-2

for you to fetch changes up to b737f51d423861399079a1f66647e7a416de3318:

  ARM: davinci: fix DT booting with default defconfig (2014-03-20 15:39:38 +0530)

----------------------------------------------------------------
Includes a patch to enable appended
DTB support for DT booting on DA850
boards with older bootloaders.

----------------------------------------------------------------
Kevin Hilman (1):
      ARM: davinci: fix DT booting with default defconfig

 arch/arm/configs/davinci_all_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index fff4eb6..2df72ff 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -40,6 +40,8 @@ CONFIG_LEDS=y
 CONFIG_USE_OF=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_ARM_APPENDED_DTB=y
+CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_AUTO_ZRELADDR=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
@@ -70,6 +72,7 @@ CONFIG_MTD_CFI_AMDSTD=m
 CONFIG_MTD_PHYSMAP=m
 CONFIG_MTD_NAND=m
 CONFIG_MTD_NAND_DAVINCI=m
+CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=1
