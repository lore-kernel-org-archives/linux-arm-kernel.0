From: robherring2@gmail.com (Rob Herring)
Date: Sun, 11 Mar 2012 16:08:16 -0500
Subject: [PATCH 0/4] mach/io.h cleanup fixes
Message-ID: <1331500100-31351-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This is a couple of fixes to mach/io.h clean-up series. The first 2 patches
are a couple of compile fixes. The 3rd patch creates a common definition of
IOMEM() macros. The 4th patch uses the common IOMEM() definition to fix
incorrect usages of __io() macro.

This applies on top of io-cleanup-for-3.4 branch already pulled into
arm-soc.

Rob

Rob Herring (4):
  ARM: fix ioremap/iounmap for !CONFIG_MMU
  ARM: iop13xx: fix missing declaration of iop13xx_init_early
  ARM: create a common IOMEM definition
  ARM: __io abuse cleanup

 arch/arm/include/asm/assembler.h                |    2 ++
 arch/arm/include/asm/io.h                       |    2 ++
 arch/arm/kernel/debug.S                         |    1 +
 arch/arm/kernel/entry-armv.S                    |    1 +
 arch/arm/mach-cns3xxx/core.c                    |    8 ++++----
 arch/arm/mach-cns3xxx/devices.c                 |    2 +-
 arch/arm/mach-davinci/include/mach/hardware.h   |    6 ------
 arch/arm/mach-davinci/include/mach/uncompress.h |    2 ++
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    9 ---------
 arch/arm/mach-iop13xx/include/mach/iop13xx.h    |    1 +
 arch/arm/mach-mmp/include/mach/addr-map.h       |    6 ------
 arch/arm/mach-msm/include/mach/msm_iomap-7x00.h |    6 ------
 arch/arm/mach-msm/include/mach/msm_iomap.h      |    6 ------
 arch/arm/mach-mxs/include/mach/hardware.h       |    6 ------
 arch/arm/mach-netx/generic.c                    |    2 +-
 arch/arm/mach-netx/include/mach/hardware.h      |    2 +-
 arch/arm/mach-netx/include/mach/netx-regs.h     |   16 ++++++++--------
 arch/arm/mach-omap1/ams-delta-fiq-handler.S     |    1 +
 arch/arm/mach-omap1/iomap.h                     |    6 ------
 arch/arm/mach-omap2/clock3xxx_data.c            |    1 +
 arch/arm/mach-omap2/clock44xx_data.c            |    1 +
 arch/arm/mach-omap2/iomap.h                     |    6 ------
 arch/arm/mach-realview/include/mach/hardware.h  |    2 +-
 arch/arm/mach-rpc/include/mach/hardware.h       |    6 ------
 arch/arm/mach-shmobile/board-ag5evm.c           |    2 +-
 arch/arm/mach-shmobile/board-bonito.c           |    2 +-
 arch/arm/mach-shmobile/board-kota2.c            |    2 +-
 arch/arm/mach-shmobile/intc-r8a7779.c           |    4 ++--
 arch/arm/mach-shmobile/intc-sh73a0.c            |    4 ++--
 arch/arm/mach-shmobile/smp-r8a7779.c            |    4 ++--
 arch/arm/mach-shmobile/smp-sh73a0.c             |   20 ++++++++++----------
 arch/arm/mach-spear3xx/clock.c                  |    1 +
 arch/arm/mach-spear6xx/clock.c                  |    1 +
 arch/arm/mach-tegra/include/mach/iomap.h        |    6 ------
 arch/arm/mach-u300/include/mach/u300-regs.h     |    6 ------
 arch/arm/mach-ux500/include/mach/hardware.h     |    2 +-
 arch/arm/mm/nommu.c                             |    8 ++++++--
 arch/arm/plat-mxc/include/mach/hardware.h       |    6 ------
 arch/arm/plat-omap/include/plat/hardware.h      |    6 ------
 arch/arm/plat-omap/include/plat/usb.h           |    1 -
 arch/arm/plat-spear/include/plat/hardware.h     |    6 ------
 41 files changed, 56 insertions(+), 126 deletions(-)

-- 
1.7.5.4
