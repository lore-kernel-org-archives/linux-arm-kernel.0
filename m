From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 19 Feb 2010 15:51:55 +0800
Subject: What's cooked in 'devel' branch of pxa for next merge window
Message-ID: <f17812d71002182351h7037607dp88d0d2b6051969ed@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

Please review if all the patches are ready for next merge window:

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git devel

Daniel Mack (2):
      [ARM] pxa/raumfeld: add platform support
      [ARM] pxa/raumfeld: add defconfig

Edwin Peer (1):
      [ARM] pxa: add support for Embedian MXM-8x10

Eric Miao (22):
      [ARM] pxa: use chip->ack() instead of accessing GEDR directly
      [ARM] pxa: simplify the LCD pin configuration for pxa25x platforms
      [ARM] pxa: simplify the LCD pin configuration for pxa27x platforms
      [ARM] pxa: remove the unnecessary restoring of MFP registers
      [ARM] pxa: introduce processor specific pxa27x_assert_ac97reset()
      [ARM] pxa: add the missing AC97 pin configurations
      [ARM] pxa: remove now unnecessary pxa_gpio_mode() calls in ac97
      [ARM] pxa/cm-x270: avoid direct access of GPIO/MFP registers
      [ARM] pxa/tosa: make use of the matrix keypad driver
      [ARM] sa1100: remove unreferenced IRQ definitions
      [ARM] locomo: avoid unnecessary cascaded keyboard IRQ
      [ARM] locomo: remove unused IRQs and avoid unnecessary cascade
      [ARM] locomo: allow cascaded IRQ base to be specified by platforms
      [ARM] sa1111: avoid using hardcoded IRQ numbers for PCMCIA driver
      [ARM] sa1111: allow cascaded IRQs to be used by platforms
      [ARM] pxa: move board board IRQ definitions out of irqs.h
      [ARM] pxa: introduce PXA_SSP_LEGACY for legacy SSP API
      ASoC: Remove legacy SSP API usage from pxa-ssp.c
      [ARM] mmp: rename irq.c to irq-pxa168.c to allow other SoC IRQ chips
      MAINTAINERS: add maintainers for Marvell MMP2 (aka ARMADA610) support
      [ARM] mmp2: fix incorrect calling of chip->mask_ack() for 2nd
level cascaded IRQs
      [ARM] pxa: refactor uncompress.h for non-PXA uarts

Haojian Zhuang (11):
      [ARM] mmp: avengers lite (pxa168) board bring up
      [ARM] mmp: update pxa168_defconfig and include avengers lite support
      [ARM] mmp: add support for Marvell MMP2
      [ARM] mmp: add default configuration for MMP2
      [ARM] mmp: support jasper development board
      [ARM] mmp2: add mask function in irq-mmp2.c
      [ARM] mmp2: add mfpr setting
      [ARM] mmp2: add gpio initialization
      [ARM] mmp2: add missing ICU register definitions
      [ARM] mmp2: add support for board IRQs
      [ARM] mmp2: add handling on PMIC IRQ

Marc Zyngier (5):
      [ARM] pxa/zeus: Allow usage of 8250-compatible UART in uncompress
      [ARM] pxa/zeus: Correct the USB host initialisation flags
      [ARM] pxa/zeus: Add Eurotech as the manufacturer
      [ARM] pxa/zeus: Add support for onboard max6369 watchdog
      [ARM] pxa/zeus: Add support for mcp2515 CAN bus

Stefan Schmidt (4):
      [ARM] pxa: enable check_scoop_reg() only if CONFIG_PM is set.
      [ARM] pxa: define zeus_power_off() only when CONFIG_PM enabled
      [ARM] pxa/imote2: Add defconfig for the imote2 platform.
      [ARM] pxa/imote2: Remove redundant pin entry for nCS.

 MAINTAINERS                                  |    7 +
 arch/arm/Kconfig                             |    4 +-
 arch/arm/common/locomo.c                     |  362 +----
 arch/arm/common/sa1111.c                     |  112 ++-
 arch/arm/common/scoop.c                      |    2 +-
 arch/arm/configs/imote2_defconfig            | 2077 ++++++++++++++++++++++++++
 arch/arm/configs/mmp2_defconfig              | 1194 +++++++++++++++
 arch/arm/configs/pxa168_defconfig            |  229 ++-
 arch/arm/configs/raumfeld_defconfig          | 1898 +++++++++++++++++++++++
 arch/arm/include/asm/hardware/it8152.h       |   12 +
 arch/arm/include/asm/hardware/locomo.h       |    4 +
 arch/arm/include/asm/hardware/sa1111.h       |    4 +
 arch/arm/mach-mmp/Kconfig                    |   35 +-
 arch/arm/mach-mmp/Makefile                   |   10 +-
 arch/arm/mach-mmp/avengers_lite.c            |   51 +
 arch/arm/mach-mmp/common.h                   |    4 +
 arch/arm/mach-mmp/flint.c                    |  123 ++
 arch/arm/mach-mmp/include/mach/cputype.h     |    9 +
 arch/arm/mach-mmp/include/mach/devices.h     |   12 +
 arch/arm/mach-mmp/include/mach/entry-macro.S |    7 +-
 arch/arm/mach-mmp/include/mach/irqs.h        |  115 ++-
 arch/arm/mach-mmp/include/mach/mfp-mmp2.h    |  240 +++
 arch/arm/mach-mmp/include/mach/mfp-pxa168.h  |    4 +-
 arch/arm/mach-mmp/include/mach/mmp2.h        |   60 +
 arch/arm/mach-mmp/include/mach/regs-apbc.h   |   41 +
 arch/arm/mach-mmp/include/mach/regs-icu.h    |   42 +-
 arch/arm/mach-mmp/include/mach/uncompress.h  |   13 +-
 arch/arm/mach-mmp/irq-mmp2.c                 |  154 ++
 arch/arm/mach-mmp/{irq.c => irq-pxa168.c}    |    0
 arch/arm/mach-mmp/jasper.c                   |   80 +
 arch/arm/mach-mmp/mmp2.c                     |  123 ++
 arch/arm/mach-mmp/time.c                     |   26 +-
 arch/arm/mach-pxa/Kconfig                    |   35 +
 arch/arm/mach-pxa/Makefile                   |    5 +
 arch/arm/mach-pxa/balloon3.c                 |   33 +-
 arch/arm/mach-pxa/capc7117.c                 |  158 ++
 arch/arm/mach-pxa/cm-x255.c                  |   21 +-
 arch/arm/mach-pxa/cm-x270.c                  |   83 +-
 arch/arm/mach-pxa/cm-x2xx-pci.c              |    2 +-
 arch/arm/mach-pxa/e740.c                     |    6 +
 arch/arm/mach-pxa/e750.c                     |    6 +
 arch/arm/mach-pxa/e800.c                     |    9 +
 arch/arm/mach-pxa/em-x270.c                  |   21 +-
 arch/arm/mach-pxa/icontrol.c                 |  202 +++
 arch/arm/mach-pxa/idp.c                      |   20 +-
 arch/arm/mach-pxa/imote2.c                   |    3 +-
 arch/arm/mach-pxa/include/mach/balloon3.h    |   10 +
 arch/arm/mach-pxa/include/mach/irqs.h        |  153 +--
 arch/arm/mach-pxa/include/mach/lpd270.h      |    4 +
 arch/arm/mach-pxa/include/mach/lubbock.h     |   11 +
 arch/arm/mach-pxa/include/mach/mainstone.h   |   17 +
 arch/arm/mach-pxa/include/mach/mfp-pxa25x.h  |   32 +
 arch/arm/mach-pxa/include/mach/mfp-pxa27x.h  |   27 +
 arch/arm/mach-pxa/include/mach/mxm8x10.h     |   21 +
 arch/arm/mach-pxa/include/mach/pcm027.h      |    7 +
 arch/arm/mach-pxa/include/mach/ssp.h         |    2 +
 arch/arm/mach-pxa/include/mach/uncompress.h  |   41 +-
 arch/arm/mach-pxa/include/mach/zeus.h        |    3 +-
 arch/arm/mach-pxa/lpd270.c                   |    6 +-
 arch/arm/mach-pxa/lubbock.c                  |   35 +-
 arch/arm/mach-pxa/magician.c                 |   21 +-
 arch/arm/mach-pxa/mainstone.c                |   27 +-
 arch/arm/mach-pxa/mioa701.c                  |   24 +-
 arch/arm/mach-pxa/mxm8x10.c                  |  474 ++++++
 arch/arm/mach-pxa/palmld.c                   |   21 +-
 arch/arm/mach-pxa/palmt5.c                   |   21 +-
 arch/arm/mach-pxa/palmtc.c                   |   21 +-
 arch/arm/mach-pxa/palmte2.c                  |   21 +-
 arch/arm/mach-pxa/palmtreo.c                 |   20 +-
 arch/arm/mach-pxa/palmtx.c                   |   21 +-
 arch/arm/mach-pxa/palmz72.c                  |   22 +-
 arch/arm/mach-pxa/pcm990-baseboard.c         |    9 +-
 arch/arm/mach-pxa/poodle.c                   |   28 +-
 arch/arm/mach-pxa/pxa27x.c                   |   19 +
 arch/arm/mach-pxa/raumfeld.c                 | 1100 ++++++++++++++
 arch/arm/mach-pxa/spitz.c                    |   20 +-
 arch/arm/mach-pxa/ssp.c                      |    5 +
 arch/arm/mach-pxa/tosa.c                     |  117 ++-
 arch/arm/mach-pxa/trizeps4.c                 |   27 +-
 arch/arm/mach-pxa/viper.c                    |    8 +-
 arch/arm/mach-pxa/zeus.c                     |   91 +-
 arch/arm/mach-sa1100/badge4.c                |    5 +
 arch/arm/mach-sa1100/collie.c                |    4 +
 arch/arm/mach-sa1100/include/mach/collie.h   |    7 -
 arch/arm/mach-sa1100/include/mach/irqs.h     |   91 +--
 arch/arm/mach-sa1100/jornada720.c            |    5 +
 arch/arm/mach-sa1100/neponset.c              |    5 +
 drivers/input/keyboard/locomokbd.c           |   32 +-
 drivers/pcmcia/sa1111_generic.c              |   25 +-
 drivers/usb/gadget/pxa25x_udc.c              |    4 +
 sound/arm/pxa2xx-ac97-lib.c                  |   68 +-
 sound/soc/pxa/pxa-ssp.c                      |   90 +-
 92 files changed, 9248 insertions(+), 1232 deletions(-)
 create mode 100644 arch/arm/configs/imote2_defconfig
 create mode 100644 arch/arm/configs/mmp2_defconfig
 create mode 100644 arch/arm/configs/raumfeld_defconfig
 create mode 100644 arch/arm/mach-mmp/avengers_lite.c
 create mode 100644 arch/arm/mach-mmp/flint.c
 create mode 100644 arch/arm/mach-mmp/include/mach/mfp-mmp2.h
 create mode 100644 arch/arm/mach-mmp/include/mach/mmp2.h
 create mode 100644 arch/arm/mach-mmp/irq-mmp2.c
 rename arch/arm/mach-mmp/{irq.c => irq-pxa168.c} (100%)
 create mode 100644 arch/arm/mach-mmp/jasper.c
 create mode 100644 arch/arm/mach-mmp/mmp2.c
 create mode 100644 arch/arm/mach-pxa/capc7117.c
 create mode 100644 arch/arm/mach-pxa/icontrol.c
 create mode 100644 arch/arm/mach-pxa/include/mach/mxm8x10.h
 create mode 100644 arch/arm/mach-pxa/mxm8x10.c
 create mode 100644 arch/arm/mach-pxa/raumfeld.c
