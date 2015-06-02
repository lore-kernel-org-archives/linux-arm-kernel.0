From: tony@atomide.com (Tony Lindgren)
Date: Tue,  2 Jun 2015 10:22:17 -0700
Subject: [GIT PULL 3/3] omap soc changes for v4.2
In-Reply-To: <pull-1433265658-688305>
References: <pull-1433265658-688305>
Message-ID: <pull-1433265658-688305-3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit e26081808edadfd257c6c9d81014e3b25e9a6118:

  Linux 4.1-rc4 (2015-05-18 10:13:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.2/soc-pt1-take2

for you to fetch changes up to 436bbc12452c23b9e7385f3fcabc82fdd387a55a:

  Merge tag 'for-v4.2/omap-hwmod-a' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v4.2/soc (2015-06-02 07:42:43 -0700)

----------------------------------------------------------------
Omap hwmod changes for v4.2 via Paul Walmsley <paul@pwsan.com>:

Several OMAP2+ hwmod changes for v4.2.  One patch cleans up a nasty
interaction between the OMAP GPMC and the hwmod code when debugging is
enabled.  IP block integration data has been added for the AM43xx EMIF
RAM controller.  There's also a fix for the omap-aes driver when used in
QEMU.  And finally, some changes to the OMAP3 hwmod code to support the
use of the security IP blocks (AES and SHA) on GP devices, or when they've
specifically been enabled in the DT data.

Basic build, boot, and power management test results are here:

http://www.pwsan.com/omap/testlogs/omap-hwmod-a-for-v4.2/20150601192349/

----------------------------------------------------------------
Dave Gerlach (1):
      ARM: OMAP: AM43xx hwmod: Add data for am43xx emif hwmod

Pali Roh?r (2):
      ARM: OMAP2+: Return correct error values from device and hwmod
      ARM: OMAP3: Fix crypto support for HS devices

Tony Lindgren (2):
      memory: omap-gpmc: Add Kconfig option for debug
      Merge tag 'for-v4.2/omap-hwmod-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v4.2/soc

 arch/arm/mach-omap2/omap_device.c                  |  30 +++---
 arch/arm/mach-omap2/omap_hwmod.c                   |  10 +-
 arch/arm/mach-omap2/omap_hwmod.h                   |   6 ++
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  12 +--
 .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  |   1 +
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  16 ++-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |  13 ---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         | 119 +++++++++++++++++----
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |  22 ++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  11 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |   4 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         |   2 +
 arch/arm/mach-omap2/prcm43xx.h                     |   2 +
 drivers/memory/Kconfig                             |   8 ++
 drivers/memory/omap-gpmc.c                         |   6 +-
 15 files changed, 184 insertions(+), 78 deletions(-)
