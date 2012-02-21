From: robherring2@gmail.com (Rob Herring)
Date: Tue, 21 Feb 2012 17:31:10 -0600
Subject: [PULL] entry-macro.S clean-up and removal
Message-ID: <4F44293E.2090901@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Please pull entry-macro clean-up for 3.4. This should be pretty much
free of any conflicts AFAICT. A merge of your for-next branch had no
conflicts.

Cheers,
Rob

The following changes since commit d65b4e98d7ea3038b767b70fe8be959b2913f16d:

  Linux 3.3-rc3 (2012-02-08 19:21:53 -0800)

are available in the git repository at:
  git://sources.calxeda.com/kernel/linux.git entry-macro-cleanup

Rob Herring (4):
      ARM: make arch_ret_to_user macro optional
      ARM: rpc: make default fiq handler run-time installed
      ARM: make entry-macro.S depend on !MULTI_IRQ_HANDLER
      ARM: remove disable_fiq and arch_ret_to_user macros

 arch/arm/Kconfig                                   |    6 ++++
 arch/arm/include/asm/hardware/entry-macro-iomd.S   |    8 ------
 arch/arm/kernel/entry-armv.S                       |    3 +-
 arch/arm/kernel/entry-common.S                     |    8 +++++-
 arch/arm/mach-at91/include/mach/entry-macro.S      |    6 ----
 arch/arm/mach-bcmring/include/mach/entry-macro.S   |    6 ----
 arch/arm/mach-clps711x/include/mach/entry-macro.S  |    6 ----
 arch/arm/mach-cns3xxx/include/mach/entry-macro.S   |   15 -----------
 arch/arm/mach-davinci/include/mach/entry-macro.S   |    6 ----
 arch/arm/mach-dove/include/mach/entry-macro.S      |    6 ----
 arch/arm/mach-ebsa110/include/mach/entry-macro.S   |    6 ----
 arch/arm/mach-ep93xx/include/mach/entry-macro.S    |   17 ------------
 arch/arm/mach-exynos/include/mach/entry-macro.S    |   16 -----------
 .../arm/mach-footbridge/include/mach/entry-macro.S |    6 ----
 arch/arm/mach-gemini/include/mach/entry-macro.S    |    6 ----
 arch/arm/mach-h720x/include/mach/entry-macro.S     |    6 ----
 arch/arm/mach-highbank/include/mach/entry-macro.S  |    5 ---
 .../arm/mach-integrator/include/mach/entry-macro.S |    6 ----
 arch/arm/mach-iop13xx/include/mach/entry-macro.S   |    3 --
 arch/arm/mach-iop32x/include/mach/entry-macro.S    |    3 --
 arch/arm/mach-iop33x/include/mach/entry-macro.S    |    3 --
 arch/arm/mach-ixp2000/include/mach/entry-macro.S   |    6 ----
 arch/arm/mach-ixp23xx/include/mach/entry-macro.S   |    6 ----
 arch/arm/mach-ixp4xx/include/mach/entry-macro.S    |    6 ----
 arch/arm/mach-kirkwood/include/mach/entry-macro.S  |    6 ----
 arch/arm/mach-ks8695/include/mach/entry-macro.S    |    6 ----
 arch/arm/mach-lpc32xx/include/mach/entry-macro.S   |    6 ----
 arch/arm/mach-mmp/include/mach/entry-macro.S       |    6 ----
 arch/arm/mach-msm/include/mach/entry-macro.S       |    6 ----
 arch/arm/mach-mv78xx0/include/mach/entry-macro.S   |    6 ----
 arch/arm/mach-mxs/include/mach/entry-macro.S       |    6 ----
 arch/arm/mach-netx/include/mach/entry-macro.S      |   26
-------------------
 arch/arm/mach-nomadik/include/mach/entry-macro.S   |   13 ---------
 arch/arm/mach-omap1/include/mach/entry-macro.S     |    6 ----
 arch/arm/mach-omap2/include/mach/entry-macro.S     |   18 -------------
 arch/arm/mach-orion5x/include/mach/entry-macro.S   |    6 ----
 arch/arm/mach-picoxcell/include/mach/entry-macro.S |   16 -----------
 arch/arm/mach-pnx4008/include/mach/entry-macro.S   |    6 ----
 arch/arm/mach-prima2/include/mach/entry-macro.S    |    7 -----
 arch/arm/mach-pxa/include/mach/entry-macro.S       |   15 -----------
 arch/arm/mach-realview/include/mach/entry-macro.S  |   16 -----------
 arch/arm/mach-rpc/Makefile                         |    2 +-
 arch/arm/mach-rpc/fiq.S                            |   16 +++++++++++
 arch/arm/mach-rpc/include/mach/entry-macro.S       |    4 ---
 arch/arm/mach-rpc/irq.c                            |    6 ++++
 arch/arm/mach-s3c2410/include/mach/entry-macro.S   |    8 ------
 arch/arm/mach-s3c64xx/include/mach/entry-macro.S   |   19 --------------
 arch/arm/mach-s5p64x0/include/mach/entry-macro.S   |   17 ------------
 arch/arm/mach-s5pc100/include/mach/entry-macro.S   |    6 ----
 arch/arm/mach-s5pv210/include/mach/entry-macro.S   |   17 ------------
 arch/arm/mach-sa1100/include/mach/entry-macro.S    |    6 ----
 arch/arm/mach-shark/include/mach/entry-macro.S     |    6 ----
 arch/arm/mach-shmobile/include/mach/entry-macro.S  |   22 ----------------
 arch/arm/mach-spear3xx/include/mach/entry-macro.S  |   18 -------------
 arch/arm/mach-spear6xx/include/mach/entry-macro.S  |   18 -------------
 arch/arm/mach-tegra/include/mach/entry-macro.S     |   20 --------------
 arch/arm/mach-u300/include/mach/entry-macro.S      |   16 -----------
 arch/arm/mach-ux500/include/mach/entry-macro.S     |   18 -------------
 arch/arm/mach-versatile/include/mach/entry-macro.S |   15 -----------
 arch/arm/mach-vexpress/include/mach/entry-macro.S  |    5 ---
 arch/arm/mach-vt8500/include/mach/entry-macro.S    |    6 ----
 arch/arm/mach-w90x900/include/mach/entry-macro.S   |    8 ------
 arch/arm/mach-zynq/include/mach/entry-macro.S      |   27
--------------------
 arch/arm/plat-mxc/include/mach/entry-macro.S       |   16 -----------
 64 files changed, 38 insertions(+), 594 deletions(-)
 delete mode 100644 arch/arm/mach-cns3xxx/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-ep93xx/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-exynos/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-highbank/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-netx/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-nomadik/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-omap2/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-pxa/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-realview/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-rpc/fiq.S
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-shmobile/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-tegra/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-u300/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-ux500/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-versatile/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-vexpress/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-zynq/include/mach/entry-macro.S
 delete mode 100644 arch/arm/plat-mxc/include/mach/entry-macro.S
