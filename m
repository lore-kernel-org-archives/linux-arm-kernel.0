From: robherring2@gmail.com (Rob Herring)
Date: Thu, 08 Mar 2012 10:24:16 -0600
Subject: [GIT PULL] mach/io.h clean-up and removal
Message-ID: <4F58DD30.4060704@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Please pull the mach/io.h cleanup series for 3.4. This does not include
the PCI i/o mapping changes. In hopes of testing, I'll wait until 3.5
for that. Although, it seems no one has devices with i/o.

I'm sending this to you rather than Russell as it is based on at91 and
omap cleanup branches in arm-soc tree.

Rob

The following changes since commit d50673ed97a7ce609cf62bcd40c57517ada31806:

  Merge remote-tracking branch 'arm-soc/at91/base2+cleanup' into
cleanup-base (2012-03-04 22:00:46 -0600)

are available in the git repository at:

  git://sources.calxeda.com/kernel/linux.git io-cleanup-for-3.4

Rob Herring (21):
      usb: ohci-pxa27x: add explicit include of hardware.h
      ARM: provide runtime hook for ioremap/iounmap
      ARM: imx: convert to common runtime ioremap hook
      ARM: msm: use runtime ioremap hook
      ARM: iop13xx: use runtime ioremap hook
      ARM: ixp4xx: use runtime ioremap hook
      ARM: ebsa110: use runtime ioremap hook
      ARM: remove compile time __arch_ioremap/__arch_iounmap
      ARM: iop13xx: move io.h externs to pci.h
      ARM: msm: clean-up mach/io.h
      [media] davinci: remove includes of mach/io.h
      ARM: davinci: remove unneeded mach/io.h include
      ARM: orion5x: clean-up mach/io.h
      ARM: tegra: clean-up mach/io.h
      ARM: ep93xx: clean-up mach/io.h
      ARM: at91: add explicit include of hardware.h to uncompressor
      ARM: dove: add explicit include of dove.h to addr-map.c
      ARM: clps711x: remove unneeded include of mach/io.h
      ARM: make mach/io.h include optional
      ARM: remove bunch of now unused mach/io.h files
      ARM: kill off __mem_pci

Tony Lindgren (1):
      ARM: OMAP: Remove remaining includes for mach/io.h

 arch/arm/Kconfig                                 |   23 +++++++
 arch/arm/include/asm/io.h                        |   69
++++++++++------------
 arch/arm/mach-at91/include/mach/io.h             |   31 ----------
 arch/arm/mach-at91/include/mach/uncompress.h     |    1 +
 arch/arm/mach-bcmring/include/mach/io.h          |   33 ----------
 arch/arm/mach-clps711x/include/mach/io.h         |   36 -----------
 arch/arm/mach-clps711x/include/mach/uncompress.h |    1 -
 arch/arm/mach-cns3xxx/include/mach/io.h          |   17 -----
 arch/arm/mach-davinci/include/mach/entry-macro.S |    1 -
 arch/arm/mach-davinci/include/mach/io.h          |   24 --------
 arch/arm/mach-dove/addr-map.c                    |    1 +
 arch/arm/mach-dove/include/mach/io.h             |    1 -
 arch/arm/mach-ebsa110/core.c                     |   15 +++++
 arch/arm/mach-ebsa110/include/mach/io.h          |    9 ---
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h  |    9 +++
 arch/arm/mach-ep93xx/include/mach/io.h           |   22 -------
 arch/arm/mach-exynos/include/mach/io.h           |   26 --------
 arch/arm/mach-footbridge/include/mach/io.h       |   13 ----
 arch/arm/mach-gemini/include/mach/io.h           |   18 ------
 arch/arm/mach-h720x/include/mach/io.h            |   22 -------
 arch/arm/mach-highbank/include/mach/io.h         |    7 --
 arch/arm/mach-imx/mm-imx3.c                      |   10 ++--
 arch/arm/mach-integrator/include/mach/io.h       |    1 -
 arch/arm/mach-iop13xx/include/mach/io.h          |   13 ----
 arch/arm/mach-iop13xx/io.c                       |   20 ++++---
 arch/arm/mach-iop13xx/iq81340mc.c                |    1 +
 arch/arm/mach-iop13xx/iq81340sc.c                |    1 +
 arch/arm/mach-iop13xx/pci.h                      |    6 ++
 arch/arm/mach-iop32x/include/mach/io.h           |    1 -
 arch/arm/mach-iop33x/include/mach/io.h           |    1 -
 arch/arm/mach-ixp2000/include/mach/io.h          |    1 -
 arch/arm/mach-ixp23xx/include/mach/io.h          |    1 -
 arch/arm/mach-ixp4xx/avila-setup.c               |    2 +
 arch/arm/mach-ixp4xx/common.c                    |   33 ++++++++++
 arch/arm/mach-ixp4xx/coyote-setup.c              |    2 +
 arch/arm/mach-ixp4xx/dsmg600-setup.c             |    1 +
 arch/arm/mach-ixp4xx/fsg-setup.c                 |    1 +
 arch/arm/mach-ixp4xx/gateway7001-setup.c         |    1 +
 arch/arm/mach-ixp4xx/goramo_mlr.c                |    1 +
 arch/arm/mach-ixp4xx/gtwx5715-setup.c            |    1 +
 arch/arm/mach-ixp4xx/include/mach/io.h           |   24 +-------
 arch/arm/mach-ixp4xx/include/mach/platform.h     |    1 +
 arch/arm/mach-ixp4xx/ixdp425-setup.c             |    4 +
 arch/arm/mach-ixp4xx/nas100d-setup.c             |    1 +
 arch/arm/mach-ixp4xx/nslu2-setup.c               |    1 +
 arch/arm/mach-ixp4xx/omixp-setup.c               |    3 +
 arch/arm/mach-ixp4xx/vulcan-setup.c              |    1 +
 arch/arm/mach-ixp4xx/wg302v2-setup.c             |    1 +
 arch/arm/mach-kirkwood/include/mach/io.h         |    2 -
 arch/arm/mach-ks8695/include/mach/io.h           |   19 ------
 arch/arm/mach-lpc32xx/include/mach/io.h          |   27 ---------
 arch/arm/mach-mmp/include/mach/io.h              |   21 -------
 arch/arm/mach-msm/board-halibut.c                |    6 ++
 arch/arm/mach-msm/board-trout.c                  |    6 ++
 arch/arm/mach-msm/include/mach/io.h              |   36 -----------
 arch/arm/mach-msm/include/mach/msm_iomap-7x00.h  |    6 ++
 arch/arm/mach-msm/include/mach/msm_iomap-7x30.h  |    4 +
 arch/arm/mach-msm/include/mach/msm_iomap-8960.h  |    4 +
 arch/arm/mach-msm/include/mach/msm_iomap-8x50.h  |    4 +
 arch/arm/mach-msm/include/mach/msm_iomap-8x60.h  |    4 +
 arch/arm/mach-msm/io.c                           |    8 +--
 arch/arm/mach-mv78xx0/include/mach/io.h          |    2 -
 arch/arm/mach-mxs/include/mach/io.h              |   22 -------
 arch/arm/mach-netx/include/mach/io.h             |   28 ---------
 arch/arm/mach-nomadik/include/mach/io.h          |   22 -------
 arch/arm/mach-omap1/include/mach/entry-macro.S   |    1 -
 arch/arm/mach-omap1/include/mach/io.h            |   46 --------------
 arch/arm/mach-omap1/sleep.S                      |    2 -
 arch/arm/mach-omap1/sram.S                       |    1 -
 arch/arm/mach-omap2/include/mach/io.h            |   49 ---------------
 arch/arm/mach-orion5x/common.h                   |    9 +++
 arch/arm/mach-orion5x/include/mach/io.h          |   33 ----------
 arch/arm/mach-orion5x/pci.c                      |    1 +
 arch/arm/mach-orion5x/tsx09-common.c             |    1 +
 arch/arm/mach-picoxcell/include/mach/io.h        |   22 -------
 arch/arm/mach-pnx4008/include/mach/io.h          |   21 -------
 arch/arm/mach-prima2/include/mach/io.h           |   16 -----
 arch/arm/mach-pxa/include/mach/io.h              |   20 ------
 arch/arm/mach-realview/include/mach/io.h         |   28 ---------
 arch/arm/mach-rpc/include/mach/io.h              |    5 --
 arch/arm/mach-s3c2410/include/mach/io.h          |    5 --
 arch/arm/mach-s3c64xx/include/mach/io.h          |   18 ------
 arch/arm/mach-s5p64x0/include/mach/io.h          |   25 --------
 arch/arm/mach-s5pc100/include/mach/io.h          |   18 ------
 arch/arm/mach-s5pv210/include/mach/io.h          |   26 --------
 arch/arm/mach-sa1100/include/mach/io.h           |   20 ------
 arch/arm/mach-shark/include/mach/io.h            |    2 -
 arch/arm/mach-shmobile/include/mach/io.h         |    9 ---
 arch/arm/mach-spear3xx/include/mach/io.h         |   19 ------
 arch/arm/mach-spear6xx/include/mach/io.h         |   20 ------
 arch/arm/mach-tegra/include/mach/debug-macro.S   |    1 -
 arch/arm/mach-tegra/include/mach/io.h            |   49 ---------------
 arch/arm/mach-tegra/include/mach/iomap.h         |   48 +++++++++++++++
 arch/arm/mach-tegra/io.c                         |    1 +
 arch/arm/mach-u300/include/mach/io.h             |   20 ------
 arch/arm/mach-ux500/include/mach/io.h            |   22 -------
 arch/arm/mach-versatile/include/mach/io.h        |   28 ---------
 arch/arm/mach-vexpress/include/mach/io.h         |   26 --------
 arch/arm/mach-vt8500/include/mach/io.h           |   26 --------
 arch/arm/mach-w90x900/include/mach/io.h          |   30 ---------
 arch/arm/mach-zynq/include/mach/io.h             |   33 ----------
 arch/arm/mm/ioremap.c                            |   17 +++++-
 arch/arm/plat-mxc/include/mach/hardware.h        |    3 +
 arch/arm/plat-mxc/include/mach/io.h              |   39 ------------
 arch/arm/plat-omap/include/plat/sdrc.h           |    1 -
 arch/arm/plat-spear/include/plat/io.h            |   22 -------
 drivers/media/video/davinci/vpbe_osd.c           |    1 -
 drivers/media/video/davinci/vpbe_venc.c          |    1 -
 drivers/usb/host/ohci-pxa27x.c                   |    1 +
 drivers/video/omap2/vrfb.c                       |    1 -
 110 files changed, 275 insertions(+), 1246 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/io.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/io.h
 delete mode 100644 arch/arm/mach-clps711x/include/mach/io.h
 delete mode 100644 arch/arm/mach-cns3xxx/include/mach/io.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/io.h
 delete mode 100644 arch/arm/mach-ep93xx/include/mach/io.h
 delete mode 100644 arch/arm/mach-exynos/include/mach/io.h
 delete mode 100644 arch/arm/mach-gemini/include/mach/io.h
 delete mode 100644 arch/arm/mach-h720x/include/mach/io.h
 delete mode 100644 arch/arm/mach-highbank/include/mach/io.h
 create mode 100644 arch/arm/mach-iop13xx/pci.h
 delete mode 100644 arch/arm/mach-ks8695/include/mach/io.h
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/io.h
 delete mode 100644 arch/arm/mach-mmp/include/mach/io.h
 delete mode 100644 arch/arm/mach-msm/include/mach/io.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/io.h
 delete mode 100644 arch/arm/mach-netx/include/mach/io.h
 delete mode 100644 arch/arm/mach-nomadik/include/mach/io.h
 delete mode 100644 arch/arm/mach-omap1/include/mach/io.h
 delete mode 100644 arch/arm/mach-omap2/include/mach/io.h
 delete mode 100644 arch/arm/mach-orion5x/include/mach/io.h
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/io.h
 delete mode 100644 arch/arm/mach-pnx4008/include/mach/io.h
 delete mode 100644 arch/arm/mach-prima2/include/mach/io.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/io.h
 delete mode 100644 arch/arm/mach-realview/include/mach/io.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/io.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/io.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/io.h
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/io.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/io.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/io.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/io.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/io.h
 delete mode 100644 arch/arm/mach-u300/include/mach/io.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/io.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/io.h
 delete mode 100644 arch/arm/mach-vexpress/include/mach/io.h
 delete mode 100644 arch/arm/mach-vt8500/include/mach/io.h
 delete mode 100644 arch/arm/mach-w90x900/include/mach/io.h
 delete mode 100644 arch/arm/mach-zynq/include/mach/io.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/io.h
 delete mode 100644 arch/arm/plat-spear/include/plat/io.h
