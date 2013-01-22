From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 22 Jan 2013 22:48:15 +0800
Subject: [GIT PULL] imx cleanup for 3.9
Message-ID: <20130122144813.GD2812@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:

  Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-cleanup-3.9

for you to fetch changes up to 6faa0b731160d2b0e49796191ad124f564b021f0:

  ARM: imx: Remove mx508 support (2013-01-22 22:26:44 +0800)

----------------------------------------------------------------
IMX cleanup for 3.9:
 * Board level dts shuffling to use node label
 * Remove lluart.c by using debug_ll_io_init()
 * Remove mach-mx51_3ds board support
 * Remove imx50 support which has been BROKEN for cycles
 * Other trival cleanups

----------------------------------------------------------------
Fabio Estevam (5):
      ARM: mach-imx: Kconfig: Do not select Babbage for MACH_IMX51_DT
      ARM: dts: imx27-3ds: Rename it to imx27-pdk
      ARM: boot: dts: Add an entry for imx27-pdk.dtb
      ARM: imx: Remove mach-mx51_3ds board
      ARM: imx: Remove mx508 support

Shawn Guo (4):
      ARM: dts: add missing imx dtb targets
      ARM: dts: imx: use nodes label in board dts
      ARM: imx: remove unused imx6q_clock_map_io()
      ARM: imx: use debug_ll_io_init() for imx6q

 Documentation/devicetree/bindings/arm/fsl.txt      |    4 +
 arch/arm/Kconfig.debug                             |   10 +-
 arch/arm/boot/dts/Makefile                         |    7 +-
 arch/arm/boot/dts/imx25-karo-tx25.dts              |   30 +-
 arch/arm/boot/dts/imx25.dtsi                       |    2 +-
 arch/arm/boot/dts/imx27-apf27.dts                  |   82 +-
 arch/arm/boot/dts/{imx27-3ds.dts => imx27-pdk.dts} |   24 +-
 arch/arm/boot/dts/imx31-bug.dts                    |   12 +-
 arch/arm/boot/dts/imx51-babbage.dts                |  456 +++++----
 arch/arm/boot/dts/imx53-ard.dts                    |  126 ++-
 arch/arm/boot/dts/imx53-evk.dts                    |  194 ++--
 arch/arm/boot/dts/imx53-qsb.dts                    |  380 ++++----
 arch/arm/boot/dts/imx53-smd.dts                    |  294 +++---
 arch/arm/boot/dts/imx6q-arm2.dts                   |  124 ++-
 arch/arm/boot/dts/imx6q-sabreauto.dts              |   64 +-
 arch/arm/boot/dts/imx6q-sabrelite.dts              |  216 +++--
 arch/arm/boot/dts/imx6q-sabresd.dts                |  102 +-
 arch/arm/boot/dts/imx6q.dtsi                       |    2 +-
 arch/arm/configs/imx_v6_v7_defconfig               |    1 -
 arch/arm/include/debug/imx.S                       |    2 +-
 arch/arm/mach-imx/Kconfig                          |   36 -
 arch/arm/mach-imx/Makefile                         |    3 -
 arch/arm/mach-imx/Makefile.boot                    |    4 -
 arch/arm/mach-imx/clk-imx6q.c                      |    2 -
 arch/arm/mach-imx/common.h                         |   11 -
 arch/arm/mach-imx/cpu-imx5.c                       |   39 -
 arch/arm/mach-imx/devices-imx50.h                  |   33 -
 arch/arm/mach-imx/devices/Kconfig                  |    2 +-
 arch/arm/mach-imx/devices/platform-fec.c           |    6 -
 arch/arm/mach-imx/devices/platform-imx-i2c.c       |   10 -
 arch/arm/mach-imx/devices/platform-imx-uart.c      |   12 -
 arch/arm/mach-imx/hardware.h                       |    6 -
 arch/arm/mach-imx/iomux-mx50.h                     |  977 --------------------
 arch/arm/mach-imx/lluart.c                         |   47 -
 arch/arm/mach-imx/mach-imx6q.c                     |    4 +-
 arch/arm/mach-imx/mach-mx50_rdp.c                  |  225 -----
 arch/arm/mach-imx/mach-mx51_3ds.c                  |  178 ----
 arch/arm/mach-imx/mm-imx5.c                        |   48 -
 arch/arm/mach-imx/mx50.h                           |  290 ------
 arch/arm/mach-imx/mxc.h                            |   13 -
 arch/arm/mach-imx/pm-imx5.c                        |    7 +-
 41 files changed, 1031 insertions(+), 3054 deletions(-)
 rename arch/arm/boot/dts/{imx27-3ds.dts => imx27-pdk.dts} (59%)
 delete mode 100644 arch/arm/mach-imx/devices-imx50.h
 delete mode 100644 arch/arm/mach-imx/iomux-mx50.h
 delete mode 100644 arch/arm/mach-imx/lluart.c
 delete mode 100644 arch/arm/mach-imx/mach-mx50_rdp.c
 delete mode 100644 arch/arm/mach-imx/mach-mx51_3ds.c
 delete mode 100644 arch/arm/mach-imx/mx50.h
