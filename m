From: ben-linux@fluff.org (Ben Dooks)
Date: Sun, 23 May 2010 16:30:35 +0100
Subject: please pull bjdooks' for-rmk/samsung3
Message-ID: <20100523153035.GA1830@fluff.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Updates for various Samsung platforms, mostly as discussed
on the list for a while and some post-shuffle fixes and
defconfig updates.

The following changes since commit 7a9b149212f3716c598afe973b6261fd58453b7a:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6 (2010-05-20 21:26:12 -0700)

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-rmk/samsung3

Banajit Goswami (4):
      ARM: SAMSUNG: Move WDT device definitions in plat-samsung
      ARM: SMDK6410: Add Watchdog support for SMDK6410
      ARM: S5P6440: Add Watchdog support for S5P6440
      ARM: S5PV210: Add Watchdog support for S5PV210

Ben Dooks (29):
      ARM: S5PV210: Remove limiting choice of machine to build
      ARM: S5PV210: Fixup machine Kconfig order
      ARM: Merge for-2635-4/s5pc1xx-removal
      ARM: Merge for-2635-4/ts-machines
      ARM: Merge for-2635-4/s5pv210-boards
      ARM: Merge for-2635-4/s5p-devs
      ARM: Merge for-2635-4/spi-devs
      ARM: Merge for-2635-4/watchdog
      ARM: Merge for-2635-4/onenand
      ARM: SAMSUNG: Fixup convert arm to arch_gettimeoffset()
      ARM: SAMSUNG: Fixup merge problem
      ARM: S5PV210: Fixup ADC device change
      ARM: S5PV210: Add temporary <mach/regs-fb.h>
      ARM: S5P6440: Add locking to GPIO calls
      ARM: SAMSUNG: Make ADC client SMP safe
      ARM: SAMSUNG: Add support for interrupt wakeup-sources
      ARM: S3C64XX: PM: Synchronise wakeup mask on suspend
      ARM: S5PC100: Fix definition of IRQ_EINT()
      ARM: S5PC100: Fixup merge problems
      ARM: s5pc100_defconfig: change ARCH_S5PC1XX to ARCH_S5PC100
      ARM: s3c2410_defconfig: Update s3c2410_defconfig to v2.6.34
      ARM: s3c6400_defconfig: Update s3c6400_defconfig to v2.6.34
      ARM: s5p6440_defconfig: Update s5p6440_defconfig to v2.6.34
      ARM: s5p6442_defconfig: Update s5p6442_defconfig to v2.6.34
      ARM: s5pc110_defconfig: Update s5pc110_defconfig to v2.6.34
      ARM: s5pv210_defconfig: Update s5pv210_defconfig to v2.6.34
      ARM: s3c6400_defconfig: enable power management
      ARM: s3c6400_defconfig: enable sound as modules
      ARM: s3c6400_defconfig: Add NAND driver

Jassi Brar (7):
      ARM: S5PC100: Add audio platform devices
      ARM: SMDKC100: Add audio devices on board
      ARM: S5PC100: Define SPI platform devices
      ARM: S5PV210: Define SPI platform devices
      ARM: S5P6442: Define SPI platform devices
      ARM: S5P6440: Define SPI platform devices
      ARM: S5PC100: DMA: Add platform devices for PL330 DMACs

Jongpill Lee (1):
      ARM: S5PV210: Add IRQ_EINT interrupt support.

Joonyoung Shim (1):
      ARM: S5PV210: Add GONI board support

Marek Szyprowski (13):
      ARM: SMDKC100: fix frame buffer definitions
      ARM: SMDKC100: remove magic values from uart setup structures
      ARM: S5PV210: add Aquila board
      ARM: S5PV210: add support for s3c-fb driver on Aquila machine
      ARM: S5PC100: Move sdhci helpers from plat-s5pc1xx to mach-s5pc100
      ARM: SAMSUNG: move S5PC100 support from plat-s5pc1xx to plat-s5p framework
      ARM: S5PC100: Add support for gpio interrupt
      ARM: S5PC100: use common plat-s5p external interrupt code
      ARM: remove obsolete plat-s5pc1xx directory
      ARM: SAMSUNG: Add platform support code for OneNAND controller
      ARM: S5PV210: add framebuffer platform helpers for s5pv210 based machines
      ARM: S5PV210: add common I2C device helpers
      ARM: S5PV210: add common HSMMC device helpers

Maurus Cuelenaere (1):
      ARM: S3C6410: Add basic support for SmartQ machines

Naveen Krishna Ch (3):
      ARM: S3C64XX: Add Touchscreen support for S3C64XX
      ARM: S5P6440: Add Touchscreen support for S5P6440
      ARM: S5PV210: Add Touchscreen support for S5PV210

Pinkava J (1):
      ARM: SAMSUNG: fix suspend/resume on if some GPIO banks not present

 arch/arm/Kconfig                                   |   13 +-
 arch/arm/Makefile                                  |    3 +-
 arch/arm/configs/s3c2410_defconfig                 |  638 +++++++-------
 arch/arm/configs/s3c6400_defconfig                 |  222 ++++-
 arch/arm/configs/s5p6440_defconfig                 |   60 +-
 arch/arm/configs/s5p6442_defconfig                 |   44 +-
 arch/arm/configs/s5pc100_defconfig                 |    2 +-
 arch/arm/configs/s5pc110_defconfig                 |   24 +-
 arch/arm/configs/s5pv210_defconfig                 |   24 +-
 arch/arm/mach-s3c2410/include/mach/map.h           |    1 +
 arch/arm/mach-s3c64xx/Kconfig                      |   40 +
 arch/arm/mach-s3c64xx/Makefile                     |    4 +
 arch/arm/mach-s3c64xx/dev-onenand1.c               |   55 ++
 arch/arm/mach-s3c64xx/include/mach/irqs.h          |    4 +
 arch/arm/mach-s3c64xx/include/mach/map.h           |   14 +
 arch/arm/mach-s3c64xx/mach-smartq.c                |  363 ++++++++
 arch/arm/mach-s3c64xx/mach-smartq.h                |   20 +
 arch/arm/mach-s3c64xx/mach-smartq5.c               |  185 ++++
 arch/arm/mach-s3c64xx/mach-smartq7.c               |  201 +++++
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |   13 +
 arch/arm/mach-s3c64xx/pm.c                         |   20 +
 arch/arm/mach-s3c64xx/s3c6400.c                    |    4 +
 arch/arm/mach-s3c64xx/s3c6410.c                    |    3 +
 arch/arm/mach-s5p6440/Kconfig                      |    4 +
 arch/arm/mach-s5p6440/Makefile                     |    1 +
 arch/arm/mach-s5p6440/cpu.c                        |    1 +
 arch/arm/mach-s5p6440/dev-spi.c                    |  176 ++++
 arch/arm/mach-s5p6440/gpio.c                       |   15 +
 arch/arm/mach-s5p6440/include/mach/map.h           |    8 +
 arch/arm/mach-s5p6440/include/mach/spi-clocks.h    |   17 +
 arch/arm/mach-s5p6440/mach-smdk6440.c              |   13 +
 arch/arm/mach-s5p6442/Makefile                     |    1 +
 arch/arm/mach-s5p6442/dev-spi.c                    |  123 +++
 arch/arm/mach-s5p6442/include/mach/map.h           |    2 +
 arch/arm/mach-s5p6442/include/mach/spi-clocks.h    |   17 +
 arch/arm/mach-s5pc100/Kconfig                      |   26 +-
 arch/arm/mach-s5pc100/Makefile                     |   14 +-
 arch/arm/mach-s5pc100/cpu.c                        |   60 +-
 arch/arm/mach-s5pc100/dev-audio.c                  |  287 +++++++
 arch/arm/mach-s5pc100/dev-spi.c                    |  233 ++++++
 arch/arm/mach-s5pc100/dma.c                        |  167 ++++
 arch/arm/mach-s5pc100/gpiolib.c                    |   36 +-
 arch/arm/mach-s5pc100/include/mach/debug-macro.S   |    6 +-
 arch/arm/mach-s5pc100/include/mach/dma.h           |   26 +
 arch/arm/mach-s5pc100/include/mach/entry-macro.S   |    8 +-
 arch/arm/mach-s5pc100/include/mach/gpio.h          |    7 +
 arch/arm/mach-s5pc100/include/mach/irqs.h          |  102 +++-
 arch/arm/mach-s5pc100/include/mach/map.h           |  124 ++--
 arch/arm/mach-s5pc100/include/mach/regs-clock.h    |    6 +
 arch/arm/mach-s5pc100/include/mach/regs-gpio.h     |   40 +-
 arch/arm/mach-s5pc100/include/mach/regs-irq.h      |    7 +-
 arch/arm/mach-s5pc100/include/mach/spi-clocks.h    |   18 +
 arch/arm/mach-s5pc100/include/mach/system.h        |    9 +-
 arch/arm/mach-s5pc100/include/mach/tick.h          |    4 +-
 .../s5pc100-init.c => mach-s5pc100/init.c}         |    7 +-
 arch/arm/{plat-s5pc1xx => mach-s5pc100}/irq-gpio.c |   78 +-
 arch/arm/mach-s5pc100/mach-smdkc100.c              |   56 +-
 .../setup-sdhci-gpio.c                             |    4 +-
 arch/arm/mach-s5pv210/Kconfig                      |   62 ++-
 arch/arm/mach-s5pv210/Makefile                     |   10 +
 arch/arm/mach-s5pv210/cpu.c                        |   16 +
 arch/arm/mach-s5pv210/dev-onenand.c                |   50 ++
 arch/arm/mach-s5pv210/dev-spi.c                    |  178 ++++
 arch/arm/mach-s5pv210/include/mach/irqs.h          |   36 +-
 arch/arm/mach-s5pv210/include/mach/map.h           |   26 +
 arch/arm/mach-s5pv210/include/mach/regs-clock.h    |    1 +
 arch/arm/mach-s5pv210/include/mach/regs-fb.h       |   21 +
 arch/arm/mach-s5pv210/include/mach/regs-gpio.h     |   44 +
 arch/arm/mach-s5pv210/include/mach/spi-clocks.h    |   17 +
 arch/arm/mach-s5pv210/mach-aquila.c                |  149 ++++
 arch/arm/mach-s5pv210/mach-goni.c                  |   98 +++
 arch/arm/mach-s5pv210/mach-smdkc110.c              |    1 +
 arch/arm/mach-s5pv210/mach-smdkv210.c              |   12 +
 arch/arm/mach-s5pv210/setup-fb-24bpp.c             |   62 ++
 arch/arm/mach-s5pv210/setup-i2c0.c                 |    9 +-
 arch/arm/mach-s5pv210/setup-i2c1.c                 |   30 +
 arch/arm/mach-s5pv210/setup-i2c2.c                 |   30 +
 arch/arm/mach-s5pv210/setup-sdhci-gpio.c           |  104 +++
 arch/arm/mach-s5pv210/setup-sdhci.c                |   63 ++
 arch/arm/plat-s3c24xx/devs.c                       |   26 -
 arch/arm/plat-s5p/Kconfig                          |    7 +-
 arch/arm/plat-s5p/Makefile                         |    2 +
 arch/arm/plat-s5p/cpu.c                            |   10 +
 arch/arm/plat-s5p/include/plat/s5pc100.h           |   33 +
 arch/arm/plat-s5p/irq-eint.c                       |  213 +++++
 arch/arm/plat-s5pc1xx/Kconfig                      |   47 -
 arch/arm/plat-s5pc1xx/Makefile                     |   26 -
 arch/arm/plat-s5pc1xx/clock.c                      |  709 ----------------
 arch/arm/plat-s5pc1xx/cpu.c                        |  122 ---
 arch/arm/plat-s5pc1xx/dev-uart.c                   |  145 ----
 arch/arm/plat-s5pc1xx/include/plat/gpio-ext.h      |   44 -
 arch/arm/plat-s5pc1xx/include/plat/irqs.h          |  198 -----
 arch/arm/plat-s5pc1xx/include/plat/pll.h           |   38 -
 arch/arm/plat-s5pc1xx/include/plat/regs-clock.h    |  252 ------
 arch/arm/plat-s5pc1xx/include/plat/regs-power.h    |   84 --
 arch/arm/plat-s5pc1xx/include/plat/s5pc100.h       |   64 --
 arch/arm/plat-s5pc1xx/irq-eint.c                   |  281 -------
 arch/arm/plat-s5pc1xx/irq.c                        |   75 --
 arch/arm/plat-s5pc1xx/s5pc100-clock.c              |  876 --------------------
 arch/arm/plat-samsung/Kconfig                      |   26 +-
 arch/arm/plat-samsung/Makefile                     |    5 +
 arch/arm/plat-samsung/adc.c                        |   26 +-
 arch/arm/plat-samsung/dev-i2c2.c                   |   70 ++
 arch/arm/plat-samsung/dev-onenand.c                |   55 ++
 arch/arm/plat-samsung/dev-wdt.c                    |   40 +
 arch/arm/plat-samsung/include/plat/devs.h          |   20 +
 arch/arm/plat-samsung/include/plat/fb.h            |    7 +
 arch/arm/plat-samsung/include/plat/iic-core.h      |    7 +
 arch/arm/plat-samsung/include/plat/iic.h           |    2 +
 arch/arm/plat-samsung/include/plat/onenand-core.h  |   37 +
 arch/arm/plat-samsung/include/plat/regs-onenand.h  |   63 ++
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h   |    4 +
 arch/arm/plat-samsung/include/plat/sdhci.h         |   55 ++
 arch/arm/plat-samsung/include/plat/wakeup-mask.h   |   44 +
 arch/arm/plat-samsung/pm-gpio.c                    |    8 +-
 arch/arm/plat-samsung/wakeup-mask.c                |   47 +
 116 files changed, 4783 insertions(+), 3664 deletions(-)
 create mode 100644 arch/arm/mach-s3c64xx/dev-onenand1.c
 create mode 100644 arch/arm/mach-s3c64xx/mach-smartq.c
 create mode 100644 arch/arm/mach-s3c64xx/mach-smartq.h
 create mode 100644 arch/arm/mach-s3c64xx/mach-smartq5.c
 create mode 100644 arch/arm/mach-s3c64xx/mach-smartq7.c
 create mode 100644 arch/arm/mach-s5p6440/dev-spi.c
 create mode 100644 arch/arm/mach-s5p6440/include/mach/spi-clocks.h
 create mode 100644 arch/arm/mach-s5p6442/dev-spi.c
 create mode 100644 arch/arm/mach-s5p6442/include/mach/spi-clocks.h
 create mode 100644 arch/arm/mach-s5pc100/dev-audio.c
 create mode 100644 arch/arm/mach-s5pc100/dev-spi.c
 create mode 100644 arch/arm/mach-s5pc100/dma.c
 create mode 100644 arch/arm/mach-s5pc100/include/mach/dma.h
 create mode 100644 arch/arm/mach-s5pc100/include/mach/spi-clocks.h
 rename arch/arm/{plat-s5pc1xx/s5pc100-init.c => mach-s5pc100/init.c} (68%)
 rename arch/arm/{plat-s5pc1xx => mach-s5pc100}/irq-gpio.c (72%)
 rename arch/arm/{plat-s5pc1xx => mach-s5pc100}/setup-sdhci-gpio.c (95%)
 create mode 100644 arch/arm/mach-s5pv210/dev-onenand.c
 create mode 100644 arch/arm/mach-s5pv210/dev-spi.c
 create mode 100644 arch/arm/mach-s5pv210/include/mach/regs-fb.h
 create mode 100644 arch/arm/mach-s5pv210/include/mach/regs-gpio.h
 create mode 100644 arch/arm/mach-s5pv210/include/mach/spi-clocks.h
 create mode 100644 arch/arm/mach-s5pv210/mach-aquila.c
 create mode 100644 arch/arm/mach-s5pv210/mach-goni.c
 create mode 100644 arch/arm/mach-s5pv210/setup-fb-24bpp.c
 create mode 100644 arch/arm/mach-s5pv210/setup-i2c1.c
 create mode 100644 arch/arm/mach-s5pv210/setup-i2c2.c
 create mode 100644 arch/arm/mach-s5pv210/setup-sdhci-gpio.c
 create mode 100644 arch/arm/mach-s5pv210/setup-sdhci.c
 create mode 100644 arch/arm/plat-s5p/include/plat/s5pc100.h
 create mode 100644 arch/arm/plat-s5p/irq-eint.c
 delete mode 100644 arch/arm/plat-s5pc1xx/Kconfig
 delete mode 100644 arch/arm/plat-s5pc1xx/Makefile
 delete mode 100644 arch/arm/plat-s5pc1xx/clock.c
 delete mode 100644 arch/arm/plat-s5pc1xx/cpu.c
 delete mode 100644 arch/arm/plat-s5pc1xx/dev-uart.c
 delete mode 100644 arch/arm/plat-s5pc1xx/include/plat/gpio-ext.h
 delete mode 100644 arch/arm/plat-s5pc1xx/include/plat/irqs.h
 delete mode 100644 arch/arm/plat-s5pc1xx/include/plat/pll.h
 delete mode 100644 arch/arm/plat-s5pc1xx/include/plat/regs-clock.h
 delete mode 100644 arch/arm/plat-s5pc1xx/include/plat/regs-power.h
 delete mode 100644 arch/arm/plat-s5pc1xx/include/plat/s5pc100.h
 delete mode 100644 arch/arm/plat-s5pc1xx/irq-eint.c
 delete mode 100644 arch/arm/plat-s5pc1xx/irq.c
 delete mode 100644 arch/arm/plat-s5pc1xx/s5pc100-clock.c
 create mode 100644 arch/arm/plat-samsung/dev-i2c2.c
 create mode 100644 arch/arm/plat-samsung/dev-onenand.c
 create mode 100644 arch/arm/plat-samsung/dev-wdt.c
 create mode 100644 arch/arm/plat-samsung/include/plat/onenand-core.h
 create mode 100644 arch/arm/plat-samsung/include/plat/regs-onenand.h
 create mode 100644 arch/arm/plat-samsung/include/plat/wakeup-mask.h
 create mode 100644 arch/arm/plat-samsung/wakeup-mask.c

-- 
Ben (ben at fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
