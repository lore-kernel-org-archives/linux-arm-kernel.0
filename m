From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 11 May 2010 17:34:49 +0200
Subject: [GIT PULL] pxa: patches for .35 merge window (34-rc7 based)
Message-ID: <AANLkTimOqaAfg7QtoTBuV3ofVFnFIMHWHSx4L8aFWc1r@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit b57f95a38233a2e73b679bea4a5453a1cc2a1cc9:
  Linus Torvalds (1):
        Linux 2.6.34-rc7

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git devel

Eric Miao (17):
      input: remove now deprecated corgi_ts.c touchscreen driver
      [ARM] pxa: remove now un-used corgi_ssp.c and corgi_lcd.c
      [ARM] pxa: remove the now legacy SSP API
      [ARM] pxa: correct SSCR0_SCR to support multiple SoCs
      [ARM] pxa: merge regs-ssp.h into ssp.h
      [ARM] pxa: remove unnecessary #include of <mach/ssp.h>
      [ARM] pxa: remove incorrect select PXA_SSP in Kconfig
      [ARM] pxa: add MFP_LPM_KEEP_OUTPUT flag to pin config
      [ARM] pxa: allow keypad GPIOs to wakeup when configured as generic
      [ARM] pxa: allow MFP_LPM_INPUT to be explicitly specified
      [ARM] pxa/spitz: use generic GPIO API and remove pxa_gpio_mode()
      [ARM] pxa/corgi: use generic GPIO API and remove pxa_gpio_mode()
      [ARM] pxa/corgi: cleanup GPIO configurations and low power mode settings
      [ARM] pxa/tosa: move CONFIG_KEYBOARD_TOSA_USE_EXT_KEYCODES to mach/Kconfig
      input: remove obsolete {corgi,spitz,tosa}kbd.c
      [ARM] pxa: remove pxa_gpio_mode() and files
      [ARM] pxa: make it clear by converting MMC 'delay_detect' to millisecond

Haojian Zhuang (13):
      [ARM] pxa: move ssp into common plat-pxa
      [ARM] pxa: simplify ifdef in ssp.h
      [ARM] mmp: support ssp in pxa168
      [ARM] mmp: enable ssp in aspenite
      [ARM] mmp: update clock register function
      [ARM] mmp: enable L2 in mmp2
      [ARM] mmp: update mmp2 defconfig
      [ARM] mmp: configure gpio pins from 128 to 192
      [ARM] mmp: update mfp setting
      [ARM] mmp: add dma support to mmp2
      [ARM] mmp: update twsi index
      [ARM] mmp: append device support in jasper
      [ARM] pxa: add namespace on ssp

Igor Grinberg (5):
      [ARM] pxa/cm-x300.c: add battery charger support
      [ARM] pxa/cm-x300: da903x WLED is not connected on cm-x300
      [ARM] pxa/cm-x300: fix da903x IRQ line assignment
      [ARM] pxa/cm-x300: add regulator on vcc_core
      [ARM] pxa/cm-x300: update the memory fixup.

Julia Lawall (2):
      [ARM] pxa: avoid NULL dereferencing in error handling of ssp.c
      [ARM] pxa: use resource_size() in ssp.c

Marek (1):
      [ARM] pxa: add basic support for Voipac PXA270 SBC

Marek Vasut (11):
      [ARM] pxa: add basic support for the Aeronix Zipit Z2 handheld
      [ARM] pxa: add support for Voipac PXA270 PCMCIA
      [ARM] pxa/vpac270: UDC and UHC support
      [ARM] pxa/vpac270: add ethernet support
      [ARM] pxa/vpac270: Add touchscreen support
      [ARM] pxa/vpac270: Add DS1339 RTC support
      [ARM] pxa/vpac270: add ide support
      [ARM] pxa/vpac270: remove TS_IRQ magic number
      [ARM] pxa/vpac270: add OneNAND support
      [ARM] pxa/vpac270: fix now invalid bit of UP2OCR
      MAINTAINERS: New MAINTAINERS entries for Zipit Z2 and Voipac PXA270

Mingliang Hu (2):
      [ARM] mmp: fix clock tick rate in mmp2
      [ARM] mmp: add smc registers definition

 Documentation/feature-removal-schedule.txt         |   23 -
 MAINTAINERS                                        |   14 +
 arch/arm/configs/mmp2_defconfig                    |   75 ++-
 arch/arm/mach-mmp/aspenite.c                       |   13 +
 arch/arm/mach-mmp/include/mach/gpio.h              |    2 +-
 arch/arm/mach-mmp/include/mach/irqs.h              |   10 +-
 arch/arm/mach-mmp/include/mach/mfp-mmp2.h          |  187 ++++++-
 arch/arm/mach-mmp/include/mach/mmp2.h              |   14 +-
 arch/arm/mach-mmp/include/mach/pxa168.h            |   21 +
 arch/arm/mach-mmp/include/mach/regs-apbc.h         |   10 +-
 arch/arm/mach-mmp/include/mach/regs-smc.h          |   37 ++
 arch/arm/mach-mmp/include/mach/timex.h             |    4 +
 arch/arm/mach-mmp/jasper.c                         |   64 ++
 arch/arm/mach-mmp/mmp2.c                           |   52 ++-
 arch/arm/mach-mmp/pxa168.c                         |   15 +
 arch/arm/mach-pxa/Kconfig                          |   57 +-
 arch/arm/mach-pxa/Makefile                         |    4 +-
 arch/arm/mach-pxa/cm-x300.c                        |  104 +++-
 arch/arm/mach-pxa/colibri-pxa3xx.c                 |    2 +-
 arch/arm/mach-pxa/corgi.c                          |   56 ++-
 arch/arm/mach-pxa/corgi_lcd.c                      |  288 ---------
 arch/arm/mach-pxa/corgi_pm.c                       |   77 +--
 arch/arm/mach-pxa/corgi_ssp.c                      |  274 ---------
 arch/arm/mach-pxa/csb726.c                         |   11 +-
 arch/arm/mach-pxa/em-x270.c                        |    2 +-
 arch/arm/mach-pxa/generic.c                        |   31 -
 arch/arm/mach-pxa/include/mach/corgi.h             |    1 -
 arch/arm/mach-pxa/include/mach/mfp-pxa2xx.h        |    2 +
 arch/arm/mach-pxa/include/mach/mmc.h               |    2 +-
 arch/arm/mach-pxa/include/mach/pxa2xx-gpio.h       |  375 ------------
 arch/arm/mach-pxa/include/mach/ssp.h               |  109 ----
 arch/arm/mach-pxa/include/mach/tosa.h              |    2 +-
 arch/arm/mach-pxa/include/mach/vpac270.h           |   42 ++
 arch/arm/mach-pxa/include/mach/z2.h                |   41 ++
 arch/arm/mach-pxa/littleton.c                      |    3 +-
 arch/arm/mach-pxa/lubbock.c                        |    2 +-
 arch/arm/mach-pxa/mfp-pxa2xx.c                     |   43 ++-
 arch/arm/mach-pxa/mioa701.c                        |    2 +-
 arch/arm/mach-pxa/mxm8x10.c                        |    2 +-
 arch/arm/mach-pxa/palmld.c                         |    2 +-
 arch/arm/mach-pxa/palmt5.c                         |    2 +-
 arch/arm/mach-pxa/palmtc.c                         |    2 +-
 arch/arm/mach-pxa/palmtx.c                         |    2 +-
 arch/arm/mach-pxa/pcm990-baseboard.c               |    2 +-
 arch/arm/mach-pxa/poodle.c                         |    5 +-
 arch/arm/mach-pxa/pxa3xx.c                         |    1 -
 arch/arm/mach-pxa/raumfeld.c                       |    2 +-
 arch/arm/mach-pxa/sharpsl.h                        |   23 -
 arch/arm/mach-pxa/sharpsl_pm.c                     |    1 -
 arch/arm/mach-pxa/spitz.c                          |    6 +-
 arch/arm/mach-pxa/spitz_pm.c                       |   28 +-
 arch/arm/mach-pxa/ssp.c                            |  510 ----------------
 arch/arm/mach-pxa/stargate2.c                      |    5 +-
 arch/arm/mach-pxa/tosa.c                           |    2 +-
 arch/arm/mach-pxa/trizeps4.c                       |    2 +-
 arch/arm/mach-pxa/vpac270.c                        |  615 ++++++++++++++++++++
 arch/arm/mach-pxa/z2.c                             |  609 +++++++++++++++++++
 arch/arm/mach-pxa/zeus.c                           |    2 +-
 arch/arm/mach-pxa/zylonite.c                       |    6 +-
 arch/arm/mm/Kconfig                                |    2 +-
 arch/arm/plat-pxa/Kconfig                          |    5 +
 arch/arm/plat-pxa/Makefile                         |    1 +
 arch/arm/plat-pxa/include/plat/mfp.h               |    7 +
 .../regs-ssp.h => plat-pxa/include/plat/ssp.h}     |  128 +++--
 arch/arm/plat-pxa/mfp.c                            |    1 +
 arch/arm/plat-pxa/ssp.c                            |  224 +++++++
 drivers/input/keyboard/Kconfig                     |   48 --
 drivers/input/keyboard/Makefile                    |    3 -
 drivers/input/keyboard/corgikbd.c                  |  414 -------------
 drivers/input/keyboard/spitzkbd.c                  |  496 ----------------
 drivers/input/keyboard/tosakbd.c                   |  431 --------------
 drivers/input/touchscreen/Kconfig                  |   16 -
 drivers/input/touchscreen/Makefile                 |    1 -
 drivers/input/touchscreen/corgi_ts.c               |  385 ------------
 drivers/mmc/host/pxamci.c                          |    2 +-
 drivers/pcmcia/Kconfig                             |    3 +-
 drivers/pcmcia/Makefile                            |    1 +
 drivers/pcmcia/pxa2xx_vpac270.c                    |  229 ++++++++
 drivers/spi/pxa2xx_spi.c                           |   25 +-
 sound/soc/pxa/Kconfig                              |    1 +
 sound/soc/pxa/pxa-ssp.c                            |  135 +++---
 81 files changed, 2667 insertions(+), 3791 deletions(-)
 create mode 100644 arch/arm/mach-mmp/include/mach/regs-smc.h
 delete mode 100644 arch/arm/mach-pxa/corgi_lcd.c
 delete mode 100644 arch/arm/mach-pxa/corgi_ssp.c
 delete mode 100644 arch/arm/mach-pxa/include/mach/pxa2xx-gpio.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/ssp.h
 create mode 100644 arch/arm/mach-pxa/include/mach/vpac270.h
 create mode 100644 arch/arm/mach-pxa/include/mach/z2.h
 delete mode 100644 arch/arm/mach-pxa/ssp.c
 create mode 100644 arch/arm/mach-pxa/vpac270.c
 create mode 100644 arch/arm/mach-pxa/z2.c
 rename arch/arm/{mach-pxa/include/mach/regs-ssp.h =>
plat-pxa/include/plat/ssp.h} (75%)
 create mode 100644 arch/arm/plat-pxa/ssp.c
 delete mode 100644 drivers/input/keyboard/corgikbd.c
 delete mode 100644 drivers/input/keyboard/spitzkbd.c
 delete mode 100644 drivers/input/keyboard/tosakbd.c
 delete mode 100644 drivers/input/touchscreen/corgi_ts.c
 create mode 100644 drivers/pcmcia/pxa2xx_vpac270.c
