From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 12 Sep 2009 00:58:35 +0800 (CST)
Subject: [GIT PULL] PXA changes for this merge window
Message-ID: <alpine.DEB.2.00.0909120055460.26978@sl400-karmic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

The following changes since commit 74fca6a42863ffacaf7ba6f1936a9f228950f657:
  Linus Torvalds (1):
        Linux 2.6.31

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git devel

Please consider pull for this merge window, thanks.

Alex Roman (1):
      [ARM] pxa/colibri: add UART MFP configuration for the PXA320 module

Aric D. Blumer (1):
      USB: ohci-pxa27x: Reconfigure power settings on resume

Daniel Mack (7):
      [ARM] pxa: add MFP_PULL_FLOAT
      [ARM] pxa: add clock definition for graphics controller
      [ARM] pxa: add device definition for graphics controller
      [ARM] pxa: rename GCU IRQ for consistency
      [ARM] pxafb: use resource_size() function
      [ARM] pxa/colibri: add NAND config for Colibri PXA3xx boards
      [ARM] pxafb: add accelerator ID for PXA3xx GCU

Daniel Ribeiro (1):
      [ARM] pxa/ezx: set IRQ_BOARD_END for EZX

Eric Miao (3):
      [ARM] pxa/littleton: update littleton to use the new gpio_card_detect for mmc
      [ARM] pxa/corgi: make use of GPIO based matrix keypad driver
      [ARM] pxa/spitz: make use of GPIO based matrix keypad driver

Guennadi Liakhovetski (3):
      [ARM] pxa/pcm990: convert pcm990 to soc-camera as platform-device
      [ARM] pxa/mioa701: convert mioa701 to the new platform-device soc-camera interface
      [ARM] pxa/em-x270: convert em-x270 to soc-camera as platform-device

Haojian Zhuang (10):
      [ARM] pxa: remove duplicate mfp definition in mach
      [ARM] pxa: support mfp of pxa935
      [ARM] pxa: expand irq support for PXA93x and PXA950
      [ARM] pxa: update cpu_is_xsc3() to include Marvell CPUID
      [ARM] pxa: add cpu_is_pxa950() and Kconfig options
      [ARM] pxa: add more registers in interrupt controller
      [ARM] pxa: initialize default interrupt priority and use ICHP for IRQ handling
      [ARM] pxa: update dependancy of pxa i2c module
      [ARM] pxa: merge {zylonite,littleton}_defconfig into pxa3xx_defconfig
      [ARM] pxa: update rtc-sa1100.c to use 'struct dev_pm_ops'

Jonathan McDowell (1):
      [ARM] pxa: balloon3 (http://balloonboard.org/) base machine support

Marek Vasut (9):
      [ARM] pxa/palm: add detect_delay to mmc for PalmTX,T5,LD
      [ARM] pxa/palm: Add NOR flash support for PalmLD
      [ARM] pxa/palm: add NAND Flash support for PalmTX
      [ARM] pxa/palm: Add NOR Flash support for PalmTX
      [ARM] pxa: Palm Tungsten|C initial support
      [ARM] pxa: Palm Tungsten|C PCMCIA support
      [ARM] pxa/palm: fix possibly uninitialized variable in PalmTC-pcmcia
      [ARM] pxa: add gpio_pwdown(_inverted) into pxaficp_ir.c
      MAINTAINERS: fix mailing list entries for ARM/Palm devices

Matej Kenda (2):
      [ARM] pxa: add support for the IskraTel XCEP board
      [ARM] pxa: add defconfig for IskraTel XCEP board

Mike Rapoport (11):
      [ARM] pxa/em-x270: remove debug leftovers
      [ARM] pxa/em-x270: add vcc_core regulator
      [ARM] pxa/cm-x270: add libertas device registration
      [ARM] pxa: update da903x_bl.c to use 'struct dev_pm_ops'
      [ARM] pxa: update pxa serial driver to use 'struct dev_pm_ops'
      [ARM] pxa: update ohci-pxa27x.c to use 'struct dev_pm_ops'
      [ARM] pxa: update pxa2xx-spi.c to use 'struct dev_pm_ops'
      [ARM] pxa: update pxafb.c to use 'struct dev_pm_ops'
      [ARM] pxa: update pxa2xx-ac97.c to use 'struct dev_pm_ops'
      [ARM] pxa: update pxamci.c to use 'struct dev_pm_ops'
      [ARM] pxa: update pcmcia/pxa2xx_base.c to use 'struct dev_pm_ops'

Philipp Zabel (2):
      [ARM] pxa: remove left-over struct clk *other field from struct clk
      [ARM] pxa/hx4700: use platform_lcd driver

Robert Jarzmik (6):
      [ARM] pxa/dma: cosmetic move of EXPORT_SYMBOL under their functions
      [ARM] pxa/dma: optimize irq handler loop
      [ARM] pxa/dma: add debugfs entries
      [ARM] pxamci: add simple gpio controls
      [ARM] pxa: factor pxamci gpio handling
      [ARM] pxa: update rtc-pxa.c to use 'struct dev_pm_ops'

Tom?? ?ech (1):
      [ARM] pxa/treo680: move LCD power GPIO to proper place

walker at suse.cz (1):
      [ARM] pxa/treo680: pxamci simplify to use GPIO

 MAINTAINERS                                  |    8 +-
 arch/arm/configs/littleton_defconfig         |  783 ---------------
 arch/arm/configs/pxa3xx_defconfig            | 1332 ++++++++++++++++++++++++++
 arch/arm/configs/xcep_defconfig              | 1129 ++++++++++++++++++++++
 arch/arm/configs/zylonite_defconfig          |  736 --------------
 arch/arm/include/asm/cputype.h               |    5 +-
 arch/arm/mach-pxa/Kconfig                    |   36 +
 arch/arm/mach-pxa/Makefile                   |    4 +
 arch/arm/mach-pxa/balloon3.c                 |  361 +++++++
 arch/arm/mach-pxa/clock.h                    |    1 -
 arch/arm/mach-pxa/cm-x270.c                  |  146 ++-
 arch/arm/mach-pxa/cm-x300.c                  |   71 +--
 arch/arm/mach-pxa/colibri-pxa300.c           |    1 +
 arch/arm/mach-pxa/colibri-pxa320.c           |   33 +
 arch/arm/mach-pxa/colibri-pxa3xx.c           |   52 +-
 arch/arm/mach-pxa/corgi.c                    |  233 +++--
 arch/arm/mach-pxa/csb726.c                   |   54 +-
 arch/arm/mach-pxa/devices.c                  |   27 +
 arch/arm/mach-pxa/devices.h                  |    2 +
 arch/arm/mach-pxa/e740.c                     |    1 -
 arch/arm/mach-pxa/e750.c                     |    1 -
 arch/arm/mach-pxa/em-x270.c                  |   45 +-
 arch/arm/mach-pxa/eseries.c                  |   39 +-
 arch/arm/mach-pxa/gumstix.c                  |    5 +-
 arch/arm/mach-pxa/hx4700.c                   |   65 +-
 arch/arm/mach-pxa/idp.c                      |    5 +-
 arch/arm/mach-pxa/imote2.c                   |    3 +
 arch/arm/mach-pxa/include/mach/balloon3.h    |  134 +++
 arch/arm/mach-pxa/include/mach/colibri.h     |    6 +
 arch/arm/mach-pxa/include/mach/entry-macro.S |   25 +-
 arch/arm/mach-pxa/include/mach/hardware.h    |   17 +
 arch/arm/mach-pxa/include/mach/irda.h        |    2 +
 arch/arm/mach-pxa/include/mach/irqs.h        |   42 +-
 arch/arm/mach-pxa/include/mach/mfp.h         |  301 +------
 arch/arm/mach-pxa/include/mach/mmc.h         |    5 +
 arch/arm/mach-pxa/include/mach/palmtc.h      |   86 ++
 arch/arm/mach-pxa/include/mach/palmtx.h      |    5 +
 arch/arm/mach-pxa/include/mach/pxa3xx-regs.h |    4 +-
 arch/arm/mach-pxa/include/mach/pxafb.h       |    3 +-
 arch/arm/mach-pxa/include/mach/regs-intc.h   |   11 +
 arch/arm/mach-pxa/include/mach/uncompress.h  |    2 +-
 arch/arm/mach-pxa/irq.c                      |    8 +-
 arch/arm/mach-pxa/littleton.c                |   43 +-
 arch/arm/mach-pxa/lubbock.c                  |   18 +-
 arch/arm/mach-pxa/magician.c                 |   59 +-
 arch/arm/mach-pxa/mainstone.c                |   16 +-
 arch/arm/mach-pxa/mioa701.c                  |   84 +--
 arch/arm/mach-pxa/palmld.c                   |  143 +--
 arch/arm/mach-pxa/palmt5.c                   |  111 +--
 arch/arm/mach-pxa/palmtc.c                   |  436 +++++++++
 arch/arm/mach-pxa/palmte2.c                  |  110 +--
 arch/arm/mach-pxa/palmtx.c                   |  225 +++--
 arch/arm/mach-pxa/palmz72.c                  |  116 +---
 arch/arm/mach-pxa/pcm990-baseboard.c         |   67 +-
 arch/arm/mach-pxa/poodle.c                   |   80 +--
 arch/arm/mach-pxa/pxa2xx.c                   |    1 +
 arch/arm/mach-pxa/pxa300.c                   |    2 +
 arch/arm/mach-pxa/pxa320.c                   |    2 +
 arch/arm/mach-pxa/pxa930.c                   |   19 +-
 arch/arm/mach-pxa/spitz.c                    |  237 +++--
 arch/arm/mach-pxa/tosa.c                     |   91 +--
 arch/arm/mach-pxa/treo680.c                  |  159 +---
 arch/arm/mach-pxa/trizeps4.c                 |    4 +
 arch/arm/mach-pxa/xcep.c                     |  187 ++++
 arch/arm/mach-pxa/zylonite.c                 |    3 +
 arch/arm/plat-pxa/dma.c                      |  281 +++++-
 arch/arm/plat-pxa/include/plat/mfp.h         |   73 ++-
 arch/arm/plat-pxa/mfp.c                      |    3 +
 drivers/i2c/busses/Kconfig                   |    4 +-
 drivers/mmc/host/pxamci.c                    |  104 ++-
 drivers/net/irda/pxaficp_ir.c                |   47 +-
 drivers/pcmcia/Makefile                      |    1 +
 drivers/pcmcia/pxa2xx_base.c                 |   18 +-
 drivers/pcmcia/pxa2xx_palmtc.c               |  230 +++++
 drivers/rtc/rtc-pxa.c                        |   27 +-
 drivers/rtc/rtc-sa1100.c                     |   23 +-
 drivers/serial/pxa.c                         |   20 +-
 drivers/spi/pxa2xx_spi.c                     |   30 +-
 drivers/usb/host/ohci-pxa27x.c               |   30 +-
 drivers/video/backlight/da903x_bl.c          |   20 +-
 drivers/video/pxafb.c                        |   32 +-
 include/linux/fb.h                           |    1 +
 sound/arm/pxa2xx-ac97.c                      |   20 +-
 83 files changed, 5606 insertions(+), 3400 deletions(-)
 delete mode 100644 arch/arm/configs/littleton_defconfig
 create mode 100644 arch/arm/configs/pxa3xx_defconfig
 create mode 100644 arch/arm/configs/xcep_defconfig
 delete mode 100644 arch/arm/configs/zylonite_defconfig
 create mode 100644 arch/arm/mach-pxa/balloon3.c
 create mode 100644 arch/arm/mach-pxa/include/mach/balloon3.h
 create mode 100644 arch/arm/mach-pxa/include/mach/palmtc.h
 create mode 100644 arch/arm/mach-pxa/palmtc.c
 create mode 100644 arch/arm/mach-pxa/xcep.c
 create mode 100644 drivers/pcmcia/pxa2xx_palmtc.c
