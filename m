From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 29 Jan 2013 14:42:02 +0800
Subject: [GIT PULL v2] imx cleanup for 3.9
Message-ID: <20130129064200.GC21504@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:

  Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-cleanup-3.9

for you to fetch changes up to 7356420cd34e40fe27bf26555b0bf3f2849a43dd:

  ARM: imx: Remove mx508 support (2013-01-29 14:05:43 +0800)

----------------------------------------------------------------
I have left out the patch (ARM: dts: imx: use nodes label in board dts)
in question and other dts related changes, and will have them go via DT
branch  to save the cross branch dependency.

----------------------------------------------------------------
Fabio Estevam (3):
      ARM: mach-imx: Kconfig: Do not select Babbage for MACH_IMX51_DT
      ARM: imx: Remove mach-mx51_3ds board
      ARM: imx: Remove mx508 support

Shawn Guo (2):
      ARM: imx: remove unused imx6q_clock_map_io()
      ARM: imx: use debug_ll_io_init() for imx6q

 arch/arm/Kconfig.debug                        |   10 +-
 arch/arm/configs/imx_v6_v7_defconfig          |    1 -
 arch/arm/include/debug/imx.S                  |    2 +-
 arch/arm/mach-imx/Kconfig                     |   36 -
 arch/arm/mach-imx/Makefile                    |    3 -
 arch/arm/mach-imx/Makefile.boot               |    4 -
 arch/arm/mach-imx/clk-imx6q.c                 |    2 -
 arch/arm/mach-imx/common.h                    |   11 -
 arch/arm/mach-imx/cpu-imx5.c                  |   39 -
 arch/arm/mach-imx/devices-imx50.h             |   33 -
 arch/arm/mach-imx/devices/Kconfig             |    2 +-
 arch/arm/mach-imx/devices/platform-fec.c      |    6 -
 arch/arm/mach-imx/devices/platform-imx-i2c.c  |   10 -
 arch/arm/mach-imx/devices/platform-imx-uart.c |   12 -
 arch/arm/mach-imx/hardware.h                  |    6 -
 arch/arm/mach-imx/iomux-mx50.h                |  977 -------------------------
 arch/arm/mach-imx/lluart.c                    |   47 --
 arch/arm/mach-imx/mach-imx6q.c                |    4 +-
 arch/arm/mach-imx/mach-mx50_rdp.c             |  225 ------
 arch/arm/mach-imx/mach-mx51_3ds.c             |  178 -----
 arch/arm/mach-imx/mm-imx5.c                   |   48 --
 arch/arm/mach-imx/mx50.h                      |  290 --------
 arch/arm/mach-imx/mxc.h                       |   13 -
 arch/arm/mach-imx/pm-imx5.c                   |    7 +-
 24 files changed, 11 insertions(+), 1955 deletions(-)
 delete mode 100644 arch/arm/mach-imx/devices-imx50.h
 delete mode 100644 arch/arm/mach-imx/iomux-mx50.h
 delete mode 100644 arch/arm/mach-imx/lluart.c
 delete mode 100644 arch/arm/mach-imx/mach-mx50_rdp.c
 delete mode 100644 arch/arm/mach-imx/mach-mx51_3ds.c
 delete mode 100644 arch/arm/mach-imx/mx50.h
