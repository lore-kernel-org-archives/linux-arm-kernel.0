From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 12 Sep 2016 17:02:24 +0800
Subject: [GIT PULL 1/5] i.MX cleanup for 4.9
Message-ID: <1473670948-4265-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-cleanup-4.9

for you to fetch changes up to 3481bdce6516a1872f3ac0af43ba56d0e1ee3afa:

  ARM: imx: (trivial) fix typo and grammar (2016-09-05 10:36:19 +0800)

----------------------------------------------------------------
i.MX cleanup for 4.9:
 - Drop i.MX1 board files and make i.MX1 a DT only platform.
 - Remove obsolete ENET initialization code for TX28 board, since FEC
   driver handles those setup well now.
 - A couple of cleanups on i.MX31 IOMUX headers to drop duplications
 - A few other random and trivial cleanups

----------------------------------------------------------------
Alexander Kurz (2):
      ARM: i.MX31 iomux: remove plain duplicates
      ARM: i.MX31 iomux: remove duplicates with alternate name

Alexander Shiyan (4):
      ARM: i.MX: Remove i.MX1 Armadeus APF9328 board support
      ARM: i.MX: Remove i.MX1 Synertronixx SCB9328 board support
      ARM: i.MX: Remove i.MX1 non-DT support
      ARM: i.MX: Move SOC_IMX1 into 'Device tree only'

Fabian Frederick (1):
      ARM: imx: remove platform-mxc_rnga

Javier Martinez Canillas (1):
      ARM: imx: use IS_ENABLED() instead of checking for built-in or module

Lothar Wa?mann (1):
      ARM: mxs: remove obsolete startup code for TX28

Martin Kaiser (1):
      ARM: imx: (trivial) fix typo and grammar

Vladimir Murzin (1):
      ARM: imx: no need to select SMP_ON_UP explicitly

 arch/arm/configs/imx_v4_v5_defconfig          |   3 +-
 arch/arm/configs/multi_v4t_defconfig          |   4 +-
 arch/arm/mach-imx/Kconfig                     |  50 ++------
 arch/arm/mach-imx/Makefile                    |   7 +-
 arch/arm/mach-imx/common.h                    |   5 -
 arch/arm/mach-imx/devices-imx1.h              |  30 -----
 arch/arm/mach-imx/devices/Makefile            |   1 -
 arch/arm/mach-imx/devices/devices-common.h    |  12 --
 arch/arm/mach-imx/devices/platform-imx-fb.c   |   5 -
 arch/arm/mach-imx/devices/platform-imx-i2c.c  |   5 -
 arch/arm/mach-imx/devices/platform-imx-uart.c |  37 ------
 arch/arm/mach-imx/devices/platform-spi_imx.c  |   9 --
 arch/arm/mach-imx/hardware.h                  |   3 +-
 arch/arm/mach-imx/iomux-mx1.h                 | 155 -----------------------
 arch/arm/mach-imx/iomux-mx3.h                 |  34 -----
 arch/arm/mach-imx/mach-apf9328.c              | 148 ----------------------
 arch/arm/mach-imx/{imx1-dt.c => mach-imx1.c}  |  23 +++-
 arch/arm/mach-imx/mach-kzm_arm11_01.c         |   6 +-
 arch/arm/mach-imx/mach-pcm037.c               |   2 +-
 arch/arm/mach-imx/mach-scb9328.c              | 143 ---------------------
 arch/arm/mach-imx/mm-imx1.c                   |  67 ----------
 arch/arm/mach-imx/mx1.h                       | 172 --------------------------
 arch/arm/mach-mxs/mach-mxs.c                  |  77 ------------
 drivers/clk/imx/clk-imx1.c                    |  46 +------
 24 files changed, 46 insertions(+), 998 deletions(-)
 delete mode 100644 arch/arm/mach-imx/devices-imx1.h
 delete mode 100644 arch/arm/mach-imx/iomux-mx1.h
 delete mode 100644 arch/arm/mach-imx/mach-apf9328.c
 rename arch/arm/mach-imx/{imx1-dt.c => mach-imx1.c} (63%)
 delete mode 100644 arch/arm/mach-imx/mach-scb9328.c
 delete mode 100644 arch/arm/mach-imx/mm-imx1.c
 delete mode 100644 arch/arm/mach-imx/mx1.h
