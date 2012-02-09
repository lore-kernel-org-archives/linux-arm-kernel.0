From: robherring2@gmail.com (Rob Herring)
Date: Wed,  8 Feb 2012 19:33:35 -0600
Subject: [PATCH v2 0/4] entry-macro.S clean-up
Message-ID: <1328751219-2552-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

With the recent MULTI_IRQ_HANDLER support, many of the platform
entry-macro.S files can be removed. This series removes empty
isable_fiq and arch_ret_to_user macros from most platforms.

This leaves iop13xx, iop32x and iop33x with compile time difference
from other platforms.

changes in v2:
- Change CONFIG_ARCH_HAS_RET_TO_USER to CONFIG_NEED_RET_TO_USER
- Add runtime installed default fiq handler to RiscPC

Rob

Rob Herring (4):
  ARM: make arch_ret_to_user macro optional
  ARM: rpc: make default fiq handler run-time installed
  ARM: make entry-macro.S depend on !MULTI_IRQ_HANDLER
  ARM: remove empty disable_fiq and arch_ret_to_user macros

 arch/arm/Kconfig                                   |    6 ++++
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
 arch/arm/mach-netx/include/mach/entry-macro.S      |   26 -------------------
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
 arch/arm/mach-rpc/fiq.S                            |   12 +++++++++
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
 arch/arm/mach-zynq/include/mach/entry-macro.S      |   27 --------------------
 arch/arm/plat-mxc/include/mach/entry-macro.S       |   16 -----------
 63 files changed, 34 insertions(+), 586 deletions(-)
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

-- 
1.7.5.4
