From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:28 +0100
Subject: [PATCH 00/51] Remove inline arch_reset definitions from system.h
Message-ID: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Well, looks like I finally made it and I reckon I've managed to preserve
my sanity.

This patch series removes the inline arch_reset definitions from the
mach/system.h files, which is currently a blocker for the single zImage
work. Nicolas has some patches doing a similar thing for arch_idle. In
cases where a new file has been introduced and it looks like arch_idle
could co-exist in there, I've named the new file system.c but it will
mean that Nicolas will need to rebase his stuff on top of this.

I think I've compile-tested this whenever I could identify the right
defconfig, but my brain stopped working about 25% of the way through.

Thanks to Paul Walmsley for saving me from the OMAP changes.

Comments / suggestions / fixups welcome.

Will

Cc: Nicolas Pitre <nicolas.pitre@linaro.org>


Paul Walmsley (1):
  ARM: OMAP: convert reset to use arm_arch_reset

Will Deacon (50):
  ARM: reset: introduce arm_arch_reset function pointer
  ARM: mach-at91: use arm_arch_reset instead of arch_reset
  ARM: bcmring: use arm_arch_reset instead of arch_reset
  ARM: mach-clps711x: use arm_arch_reset instead of arch_reset
  ARM: cns3xxx: use arm_arch_reset instead of arch_reset
  ARM: mach-davinci: use arm_arch_reset instead of arch_reset
  ARM: mach-dove: use arm_arch_reset instead of arch_reset
  ARM: mach-ebsa110: use arm_arch_reset instead of arch_reset
  ARM: mach-ep93xx: use arm_arch_reset instead of arch_reset
  ARM: mach-footbridge: use arm_arch_reset instead of arch_reset
  ARM: mach-gemini: use arm_arch_reset instead of arch_reset
  ARM: mach-h720x: use arm_arch_reset instead of arch_reset
  ARM: mach-integrator: use arm_arch_reset instead of arch_reset
  ARM: mach-iop13xx: use arm_arch_reset instead of arch_reset
  ARM: mach-iop32x: use arm_arch_reset instead of arch_reset
  ARM: mach-iop33x: use arm_arch_reset instead of arch_reset
  ARM: mach-ixp2000: use arm_arch_reset instead of arch_reset
  ARM: mach-ixp23xx: use arm_arch_reset instead of arch_reset
  ARM: mach-ixp4xx: use arm_arch_reset instead of arch_reset
  ARM: mach-kirkwood: use arm_arch_reset instead of arch_reset
  ARM: mach-ks8695: use arm_arch_reset instead of arch_reset
  ARM: mach-lpc32xx: use arm_arch_reset instead of arch_reset
  ARM: mach-mmp: use arm_arch_reset instead of arch_reset
  ARM: mach-mv78xx0: use arm_arch_reset instead of arch_reset
  ARM: mach-msm: use arm_arch_reset instead of arch_reset
  ARM: mach-mxs: use arm_arch_reset instead of arch_reset
  ARM: mach-netx: use arm_arch_reset instead of arch_reset
  ARM: mach-nomadik: use arm_arch_reset instead of arch_reset
  ARM: mach-nuc93x: use arm_arch_reset instead of arch_reset
  ARM: mach-orion5x: use arm_arch_reset instead of arch_reset
  ARM: mach-pnx4008: use arm_arch_reset instead of arch_reset
  ARM: mach-prima2: use arm_arch_reset instead of arch_reset
  ARM: mach-pxa: use arm_arch_reset instead of arch_reset
  ARM: mach-realview: use arm_arch_reset instead of arch_reset
  ARM: mach-rpc: use arm_arch_reset instead of arch_reset
  ARM: mach-s3c64xx: use arm_arch_reset instead of arch_reset
  ARM: mach-sa1100: use arm_arch_reset instead of arch_reset
  ARM: mach-shark: use arm_arch_reset instead of arch_reset
  ARM: mach-shmobile: use arm_arch_reset instead of arch_reset
  ARM: mach-tegra: use arm_arch_reset instead of arch_reset
  ARM: mach-u300: use arm_arch_reset instead of arch_reset
  ARM: mach-versatile: use arm_arch_reset instead of arch_reset
  ARM: mach-vt8500: use arm_arch_reset instead of arch_reset
  ARM: mach-w90x900: use arm_arch_reset instead of arch_reset
  ARM: plat-spear: use arm_arch_reset instead of arch_reset
  ARM: plat-tcc: use arm_arch_reset instead of arch_reset
  ARM: plat-s5p: use arm_arch_reset instead of arch_reset
  ARM: plat-mxc: use arm_arch_reset instead of arch_reset
  ARM: plat-s3c24xx: use arm_arch_reset instead of arch_reset
  ARM: reset: remove empty arch_reset definitions

 arch/arm/include/asm/system.h                      |    1 +
 arch/arm/kernel/process.c                          |    6 ++-
 arch/arm/mach-at91/at91cap9.c                      |    5 +-
 arch/arm/mach-at91/at91rm9200.c                    |    5 +-
 arch/arm/mach-at91/at91sam9260.c                   |    3 +-
 arch/arm/mach-at91/at91sam9261.c                   |    3 +-
 arch/arm/mach-at91/at91sam9263.c                   |    3 +-
 arch/arm/mach-at91/at91sam9g45.c                   |    5 +-
 arch/arm/mach-at91/at91sam9rl.c                    |    3 +-
 arch/arm/mach-at91/generic.h                       |    3 +-
 arch/arm/mach-at91/include/mach/system.h           |    9 ---
 arch/arm/mach-bcmring/arch.c                       |   27 +++++++-
 arch/arm/mach-bcmring/include/mach/system.h        |   24 -------
 arch/arm/mach-clps711x/Makefile                    |    2 +-
 arch/arm/mach-clps711x/include/mach/system.h       |    5 --
 arch/arm/mach-clps711x/system.c                    |   23 +++++++
 arch/arm/mach-cns3xxx/cns3420vb.c                  |    3 +
 arch/arm/mach-cns3xxx/include/mach/system.h        |    2 -
 arch/arm/mach-cns3xxx/pm.c                         |    2 +-
 arch/arm/mach-davinci/common.c                     |    8 ++
 arch/arm/mach-davinci/include/mach/system.h        |    6 --
 arch/arm/mach-dove/common.c                        |   18 +++++
 arch/arm/mach-dove/include/mach/system.h           |   17 -----
 arch/arm/mach-ebsa110/core.c                       |    6 ++
 arch/arm/mach-ebsa110/include/mach/system.h        |    2 -
 arch/arm/mach-ep93xx/core.c                        |   22 ++++++
 arch/arm/mach-ep93xx/include/mach/system.h         |   14 ----
 arch/arm/mach-exynos4/include/mach/system.h        |    2 -
 arch/arm/mach-footbridge/Makefile                  |    2 +-
 arch/arm/mach-footbridge/include/mach/system.h     |   50 --------------
 arch/arm/mach-footbridge/reset.c                   |   69 ++++++++++++++++++++
 arch/arm/mach-gemini/Makefile                      |    2 +-
 arch/arm/mach-gemini/include/mach/system.h         |    6 --
 arch/arm/mach-gemini/system.c                      |   22 ++++++
 arch/arm/mach-h720x/common.c                       |   12 ++++
 arch/arm/mach-h720x/include/mach/system.h          |    6 --
 arch/arm/mach-integrator/core.c                    |   11 +++
 arch/arm/mach-integrator/include/mach/system.h     |    9 ---
 arch/arm/mach-iop13xx/include/mach/system.h        |   13 ----
 arch/arm/mach-iop13xx/setup.c                      |   14 ++++
 arch/arm/mach-iop32x/Makefile                      |    2 +-
 arch/arm/mach-iop32x/include/mach/system.h         |   17 -----
 arch/arm/mach-iop32x/reset.c                       |   33 +++++++++
 arch/arm/mach-iop33x/Makefile                      |    2 +-
 arch/arm/mach-iop33x/include/mach/system.h         |    8 --
 arch/arm/mach-iop33x/reset.c                       |   24 +++++++
 arch/arm/mach-ixp2000/core.c                       |   38 +++++++++++
 arch/arm/mach-ixp2000/include/mach/system.h        |   34 ----------
 arch/arm/mach-ixp23xx/core.c                       |   15 ++++
 arch/arm/mach-ixp23xx/include/mach/system.h        |   16 -----
 arch/arm/mach-ixp4xx/common.c                      |   22 ++++++
 arch/arm/mach-ixp4xx/include/mach/system.h         |   24 -------
 arch/arm/mach-kirkwood/common.c                    |   17 +++++
 arch/arm/mach-kirkwood/include/mach/system.h       |   18 -----
 arch/arm/mach-ks8695/Makefile                      |    2 +-
 arch/arm/mach-ks8695/include/mach/system.h         |   21 ------
 arch/arm/mach-ks8695/reset.c                       |   33 +++++++++
 arch/arm/mach-lpc32xx/common.c                     |   30 +++++++++
 arch/arm/mach-lpc32xx/include/mach/system.h        |   25 -------
 arch/arm/mach-mmp/common.c                         |   16 +++++
 arch/arm/mach-mmp/include/mach/system.h            |    8 --
 arch/arm/mach-msm/include/mach/system.h            |   10 ---
 arch/arm/mach-msm/smd.c                            |    6 ++
 arch/arm/mach-mv78xx0/common.c                     |   17 +++++
 arch/arm/mach-mv78xx0/include/mach/system.h        |   16 -----
 arch/arm/mach-mxs/include/mach/system.h            |    2 -
 arch/arm/mach-mxs/system.c                         |    4 +-
 arch/arm/mach-netx/generic.c                       |    7 ++
 arch/arm/mach-netx/include/mach/system.h           |   10 ---
 arch/arm/mach-nomadik/cpu-8815.c                   |   12 ++++
 arch/arm/mach-nomadik/include/mach/system.h        |   13 ----
 arch/arm/mach-nuc93x/cpu.c                         |   12 ++++
 arch/arm/mach-nuc93x/include/mach/system.h         |    8 --
 arch/arm/mach-omap1/board-voiceblue.c              |    2 +-
 arch/arm/mach-omap1/io.c                           |    4 +
 arch/arm/mach-omap1/reset.c                        |    2 -
 arch/arm/mach-omap2/io.c                           |    7 ++-
 arch/arm/mach-omap2/prcm.c                         |    4 +-
 arch/arm/mach-orion5x/common.c                     |   17 +++++
 arch/arm/mach-orion5x/include/mach/system.h        |   12 ----
 arch/arm/mach-pnx4008/core.c                       |    6 ++
 arch/arm/mach-pnx4008/include/mach/system.h        |    9 ---
 arch/arm/mach-prima2/Makefile                      |    1 +
 arch/arm/mach-prima2/include/mach/system.h         |   10 ---
 arch/arm/mach-prima2/reset.c                       |   22 ++++++
 arch/arm/mach-pxa/include/mach/system.h            |    5 --
 arch/arm/mach-pxa/reset.c                          |    8 ++-
 arch/arm/mach-realview/core.c                      |   20 ++++++
 arch/arm/mach-realview/include/mach/system.h       |   17 -----
 arch/arm/mach-rpc/include/mach/system.h            |   14 ----
 arch/arm/mach-rpc/riscpc.c                         |   14 ++++
 arch/arm/mach-s3c2410/include/mach/system-reset.h  |   32 ---------
 arch/arm/mach-s3c2410/include/mach/system.h        |    2 -
 arch/arm/mach-s3c64xx/Makefile                     |    1 +
 arch/arm/mach-s3c64xx/include/mach/system.h        |   11 ---
 arch/arm/mach-s3c64xx/reset.c                      |   26 +++++++
 arch/arm/mach-s5p64x0/include/mach/system.h        |    2 -
 arch/arm/mach-s5pc100/include/mach/system.h        |    2 -
 arch/arm/mach-s5pv210/include/mach/system.h        |    2 -
 arch/arm/mach-sa1100/generic.c                     |   13 ++++
 arch/arm/mach-sa1100/include/mach/system.h         |   12 ----
 arch/arm/mach-shark/core.c                         |    5 +-
 arch/arm/mach-shark/include/mach/system.h          |    2 -
 arch/arm/mach-shmobile/Makefile                    |    2 +-
 arch/arm/mach-shmobile/include/mach/system.h       |    5 --
 arch/arm/mach-shmobile/reset.c                     |   18 +++++
 arch/arm/mach-tegra/common.c                       |    4 +-
 arch/arm/mach-tegra/include/mach/system.h          |    3 -
 arch/arm/mach-u300/Makefile                        |    2 +-
 arch/arm/mach-u300/include/mach/system.h           |   28 --------
 arch/arm/mach-u300/reset.c                         |   42 ++++++++++++
 arch/arm/mach-ux500/include/mach/system.h          |    5 --
 arch/arm/mach-versatile/core.c                     |   14 ++++
 arch/arm/mach-versatile/include/mach/system.h      |   12 ----
 arch/arm/mach-vexpress/include/mach/system.h       |    4 -
 arch/arm/mach-vt8500/Makefile                      |    2 +-
 arch/arm/mach-vt8500/include/mach/system.h         |    9 ---
 arch/arm/mach-vt8500/reset.c                       |   21 ++++++
 arch/arm/mach-w90x900/Makefile                     |    2 +-
 arch/arm/mach-w90x900/include/mach/system.h        |   21 ------
 arch/arm/mach-w90x900/reset.c                      |   31 +++++++++
 arch/arm/mach-zynq/include/mach/system.h           |    5 --
 arch/arm/plat-mxc/include/mach/system.h            |    2 -
 arch/arm/plat-mxc/system.c                         |    3 +-
 arch/arm/plat-omap/include/plat/system.h           |    3 +-
 arch/arm/plat-s3c24xx/cpu.c                        |   23 ++++++-
 arch/arm/plat-s5p/Makefile                         |    1 +
 .../plat/system-reset.h => system-reset.c}         |   17 ++++-
 arch/arm/plat-spear/Makefile                       |    2 +-
 arch/arm/plat-spear/include/plat/system.h          |   15 ----
 arch/arm/plat-spear/reset.c                        |   29 ++++++++
 arch/arm/plat-tcc/include/mach/system.h            |    9 ---
 arch/arm/plat-tcc/system.c                         |   10 +++-
 133 files changed, 901 insertions(+), 694 deletions(-)
 create mode 100644 arch/arm/mach-clps711x/system.c
 create mode 100644 arch/arm/mach-footbridge/reset.c
 create mode 100644 arch/arm/mach-gemini/system.c
 create mode 100644 arch/arm/mach-iop32x/reset.c
 create mode 100644 arch/arm/mach-iop33x/reset.c
 create mode 100644 arch/arm/mach-ks8695/reset.c
 create mode 100644 arch/arm/mach-prima2/reset.c
 delete mode 100644 arch/arm/mach-s3c2410/include/mach/system-reset.h
 create mode 100644 arch/arm/mach-s3c64xx/reset.c
 create mode 100644 arch/arm/mach-shmobile/reset.c
 create mode 100644 arch/arm/mach-u300/reset.c
 create mode 100644 arch/arm/mach-vt8500/reset.c
 create mode 100644 arch/arm/mach-w90x900/reset.c
 rename arch/arm/plat-s5p/{include/plat/system-reset.h => system-reset.c} (66%)
 create mode 100644 arch/arm/plat-spear/reset.c

-- 
1.7.4.1
