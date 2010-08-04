From: lethal@linux-sh.org (Paul Mundt)
Date: Wed, 4 Aug 2010 16:58:06 +0900
Subject: [GIT PULL] genesis updates for 2.6.36-rc1
Message-ID: <20100804075806.GE15098@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/genesis-2.6.git

Which contains:

Guennadi Liakhovetski (21):
      fbdev: add a MIPI DSI header
      ARM: mach-shmobile: add LCDC and MIPI DSI-Tx clock definitions to sh7372
      sh: add a YUV422 output data format, that is also supported by LCDC
      sh-mobile: add support for displays, connected over the MIPI bus
      ARM: mach-shmobile: add framebuffer support for ap4evb
      serial: add a new port type, found on some sh-mobile SoCs
      serial: sh-sci: fix handling of SCIFB sh-mobile ports
      ARM: mach-shmobile: SH7372 has 6 SCIFA and 1 SCIFB ports
      ARM: add DMA support to sh7372, enable DMA for SDHI
      ARM: mach-shmobile: add support for the second SD-/MMC-card slot on ap4evb
      ARM: mach-shmobile: add SCIFA and SCIFB DMA slave definitions for sh7372
      ARM: mach-shmobile: add GPIO definitions for switching between LCDC0 and LCDC1
      ARM: mach-shmobile: fix EXTAL1 frequency on sh7372
      ARM: mach-shmobile: fix typos in sh7372 clock definitions
      fbdev: sh-mobile-lcdc: fix potential Oops in SH-Mobile LCDC framebuffer driver
      sh: add a list of parent configurations to struct clk
      sh: add a reparent function to DIV6 clocks
      ARM: mach-shmobile: extend clock definitions on sh7372
      sh: add a parameter to LCDC driver's .display_on() callback
      fbdev: sh-mobile: HDMI support for SH-Mobile SoCs
      ARM: mach-shmobile: add HDMI support to the ap4evb board

Kuninori Morimoto (22):
      ARM: mach-shmobile: sh7372: Add I2C0, I2C1 support
      ARM: mach-shmobile: ap4evb: Add TouchScreen support
      ARM: mach-shmobile: ap4evb: Add SW43, SW3 tiny document
      ARM: mach-shmobile: ap4evb: Add R2025S RTC support
      ARM: mach-shmobile: intc-sh7377: Add INTCS support
      ARM: mach-shmobile: Add missing __initdata on intcs sh7367/sh7377
      ARM: mach-shmobile: Add SDHI support
      ARM: mach-shmobile: intc-sh7372: modify wrong address
      ARM: mach-shmobile: ap4evb: Add USB host support
      ARM: mach-shmobile: g3evm: Add IrDA support
      ARM: mach-shmobile: ap4evb: Add FSI2 support
      ARM: mach-shmobile: ap4evb: Add MMC support
      ARM: mach-shmobile: ap4evb: evt2irq() update for MMCIF
      ARM: mach-shmobile: clock-sh7372: Add MMCIF clock
      ARM: mach-shmobile: ap4evb: update MMC/SHDI tiny document
      ARM: mach-shmobile: make sure static declaration on ap4evb
      ARM: mach-shmobile: make sure static declaration on g4evm
      ARM: mach-shmobile: make sure static declaration on g3evm
      ARM: mach-shmobile: ap4evb: Add LCD panel selection
      net/irda/sh_irda: Modify clk_get lookups
      ARM: mach-shmobile: ap4evb: Add ts_get_pendown_state for tsc2007
      ARM: mach-shmobile: clock-sh7372: modify clock name for FSI2

Magnus Damm (19):
      dmaengine: shdma: Enable on SH-Mobile ARM
      i2c: i2c-sh_mobile register access code break out
      i2c: i2c-sh_mobile support for new ICIC bits
      i2c: i2c-sh_mobile kconfig update for SH-Mobile ARM
      ARM: mach-shmobile: add INTCS macros
      ARM: mach-shmobile: sh7367 INTCS support
      ARM: mach-shmobile: Use 0x2200 as INTCS_VECT_BASE
      ARM: mach-shmobile: sh7372 INTCS support
      ARM: mach-shmobile: Enable TMU driver build
      ARM: mach-shmobile: Use shared clock framework
      ARM: mach-shmobile: sh7372 clock framework support V2
      ARM: mach-shmobile: Set CONSISTENT_DMA_SIZE to 158 MB
      ARM: mach-shmobile: Update VMALLOC_END
      ARM: mach-shmobile: sh7367/G3EVM evt2irq() update
      ARM: mach-shmobile: sh7377/G4EVM evt2irq() update
      ARM: mach-shmobile: sh7372/AP4EVB evt2irq() update
      ARM: mach-shmobile: sh7372 clock fixes
      ARM: mach-shmobile: sh7367 clock framework V2
      ARM: mach-shmobile: sh7377 clock framework V2

Paul Mundt (5):
      MAINTAINERS: Add a patchwork entry for ARM/SH-Mobile.
      ARM: mach-shmobile: update defconfigs.
      ARM: mach-shmobile: Fix up ap4evb build warnings.
      ARM: mach-shmobile: update ap4evb defconfig for MMC/DMA changes.
      ARM: mach-shmobile: Fix up ap4evb build for LCDC merge damage.

 MAINTAINERS                                   |    3 +-
 arch/arm/mach-shmobile/Kconfig                |   26 +
 arch/arm/mach-shmobile/Makefile               |    6 +-
 arch/arm/mach-shmobile/board-ap4evb.c         |  817 +++++++++++++++++++-
 arch/arm/mach-shmobile/board-g3evm.c          |   59 ++-
 arch/arm/mach-shmobile/board-g4evm.c          |  153 ++++-
 arch/arm/mach-shmobile/clock-sh7367.c         |  357 ++++++++--
 arch/arm/mach-shmobile/clock-sh7372.c         |  560 ++++++++++++++
 arch/arm/mach-shmobile/clock-sh7377.c         |  369 +++++++++
 arch/arm/mach-shmobile/clock.c                |   44 ++
 arch/arm/mach-shmobile/include/mach/common.h  |   10 +
 arch/arm/mach-shmobile/include/mach/irqs.h    |    6 +
 arch/arm/mach-shmobile/include/mach/memory.h  |    3 +
 arch/arm/mach-shmobile/include/mach/sh7372.h  |   30 +
 arch/arm/mach-shmobile/include/mach/vmalloc.h |    3 +-
 arch/arm/mach-shmobile/intc-sh7367.c          |  178 +++++-
 arch/arm/mach-shmobile/intc-sh7372.c          |  232 ++++++-
 arch/arm/mach-shmobile/intc-sh7377.c          |  300 +++++++-
 arch/arm/mach-shmobile/pfc-sh7372.c           |    3 +
 arch/arm/mach-shmobile/setup-sh7367.c         |   30 +-
 arch/arm/mach-shmobile/setup-sh7372.c         |  391 +++++++++-
 arch/arm/mach-shmobile/setup-sh7377.c         |   34 +-
 arch/sh/boards/mach-ap325rxa/setup.c          |    2 +-
 arch/sh/boards/mach-kfr2r09/Makefile          |    6 +-
 arch/sh/boards/mach-kfr2r09/lcd_wqvga.c       |    2 +-
 arch/sh/include/mach-kfr2r09/mach/kfr2r09.h   |   16 +-
 drivers/dma/Kconfig                           |    2 +-
 drivers/dma/shdma.c                           |    8 +-
 drivers/i2c/busses/Kconfig                    |    2 +-
 drivers/i2c/busses/i2c-sh_mobile.c            |  121 ++-
 drivers/net/irda/sh_irda.c                    |    6 +-
 drivers/serial/sh-sci.c                       |   42 +-
 drivers/serial/sh-sci.h                       |   29 +-
 drivers/sh/Makefile                           |    5 +-
 drivers/sh/clk-cpg.c                          |   58 ++-
 drivers/video/Kconfig                         |   15 +
 drivers/video/Makefile                        |    2 +
 drivers/video/sh_mipi_dsi.c                   |  505 ++++++++++++
 drivers/video/sh_mobile_hdmi.c                | 1028 +++++++++++++++++++++++++
 drivers/video/sh_mobile_lcdcfb.c              |  196 ++++--
 include/linux/serial_core.h                   |    3 +
 include/linux/sh_clk.h                        |   23 +-
 include/video/mipi_display.h                  |  130 ++++
 include/video/sh_mipi_dsi.h                   |   35 +
 include/video/sh_mobile_hdmi.h                |   22 +
 include/video/sh_mobile_lcdc.h                |   41 +-
 46 files changed, 5602 insertions(+), 311 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/clock-sh7372.c
 create mode 100644 arch/arm/mach-shmobile/clock-sh7377.c
 create mode 100644 arch/arm/mach-shmobile/clock.c
 create mode 100644 drivers/video/sh_mipi_dsi.c
 create mode 100644 drivers/video/sh_mobile_hdmi.c
 create mode 100644 include/video/mipi_display.h
 create mode 100644 include/video/sh_mipi_dsi.h
 create mode 100644 include/video/sh_mobile_hdmi.h
