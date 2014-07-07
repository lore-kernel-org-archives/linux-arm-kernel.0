From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 08 Jul 2014 07:59:36 +0900
Subject: [GIT PULL] Samsung cleanup for S5P SoCs for 3.17
Message-ID: <53BB2658.4050808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a497c3ba1d97fc69c1e78e7b96435ba8c2cb42ee:

   Linux 3.16-rc2 (2014-06-21 19:02:54 -1000)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/s5p-cleanup

for you to fetch changes up to 58595ebd9306691441ccf88973b97d4f8eaa8279:

   ASoC: Samsung: remove s5pc100 related codes (2014-07-08 07:29:05 +0900)

----------------------------------------------------------------
Cleanup S5P SoCs for 3.17
- removing s5p64x0 SoCs and s5pc100 SoC in mainline because
   no more user and if it is required next time, it will be
   supported with DT.

----------------------------------------------------------------
Kukjin Kim (13):
       ARM: S5P64X0: no more support S5P6440 and S5P6450 SoCs
       gpio: samsung: remove s5p64x0 related gpio codes
       spi: s3c64xx: remove s5p64x0 related spi codes
       ASoC: samsung: no more support for S5P6440 and S5P6450 SoCs
       video: fbdev: s3c-fb: remove s5p64x0 related fimd codes
       serial: samsung: no more support for S5P6440 and S5P6450 SoCs
       ARM: S5PC100: no more support S5PC100 SoC
       gpio: samsung: remov s5pc100 related gpio codes
       spi: s3c64xx: remove s5pc100 related spi codes
       serial: samsung: no more support for S5PC100 SoC
       mtd: onenand: remove s5pc100 related onenand codes
       video: fbdev: s3c-fb: remove s5pc100 related fimd and fb codes
       ASoC: Samsung: remove s5pc100 related codes

  Documentation/arm/Samsung/Overview.txt             |   11 -
  .../arm/Samsung/clksrc-change-registers.awk        |    1 -
  .../devicetree/bindings/spi/spi-samsung.txt        |    1 -
  .../devicetree/bindings/video/samsung-fimd.txt     |    2 -
  arch/arm/Kconfig                                   |   43 +-
  arch/arm/Makefile                                  |    2 -
  arch/arm/configs/s5p64x0_defconfig                 |   68 -
  arch/arm/configs/s5pc100_defconfig                 |   49 -
  arch/arm/mach-s5p64x0/Kconfig                      |  102 --
  arch/arm/mach-s5p64x0/Makefile                     |   36 -
  arch/arm/mach-s5p64x0/Makefile.boot                |    2 -
  arch/arm/mach-s5p64x0/clock-s5p6440.c              |  632 ---------
  arch/arm/mach-s5p64x0/clock-s5p6450.c              |  701 ----------
  arch/arm/mach-s5p64x0/clock.c                      |  236 ----
  arch/arm/mach-s5p64x0/clock.h                      |   38 -
  arch/arm/mach-s5p64x0/common.c                     |  490 -------
  arch/arm/mach-s5p64x0/common.h                     |   56 -
  arch/arm/mach-s5p64x0/dev-audio.c                  |  176 ---
  arch/arm/mach-s5p64x0/dma.c                        |  128 --
  arch/arm/mach-s5p64x0/i2c.h                        |   16 -
  arch/arm/mach-s5p64x0/include/mach/debug-macro.S   |   32 -
  arch/arm/mach-s5p64x0/include/mach/dma.h           |   26 -
  arch/arm/mach-s5p64x0/include/mach/gpio.h          |  132 --
  arch/arm/mach-s5p64x0/include/mach/hardware.h      |   18 -
  arch/arm/mach-s5p64x0/include/mach/irqs.h          |  148 ---
  arch/arm/mach-s5p64x0/include/mach/map.h           |   96 --
  arch/arm/mach-s5p64x0/include/mach/pm-core.h       |  119 --
  arch/arm/mach-s5p64x0/include/mach/regs-clock.h    |   98 --
  arch/arm/mach-s5p64x0/include/mach/regs-gpio.h     |   68 -
  arch/arm/mach-s5p64x0/include/mach/regs-irq.h      |   18 -
  arch/arm/mach-s5p64x0/irq-pm.c                     |   98 --
  arch/arm/mach-s5p64x0/mach-smdk6440.c              |  280 ----
  arch/arm/mach-s5p64x0/mach-smdk6450.c              |  299 -----
  arch/arm/mach-s5p64x0/pm.c                         |  202 ---
  arch/arm/mach-s5p64x0/setup-fb-24bpp.c             |   29 -
  arch/arm/mach-s5p64x0/setup-i2c0.c                 |   38 -
  arch/arm/mach-s5p64x0/setup-i2c1.c                 |   38 -
  arch/arm/mach-s5p64x0/setup-sdhci-gpio.c           |  104 --
  arch/arm/mach-s5p64x0/setup-spi.c                  |   38 -
  arch/arm/mach-s5pc100/Kconfig                      |   81 --
  arch/arm/mach-s5pc100/Makefile                     |   32 -
  arch/arm/mach-s5pc100/Makefile.boot                |    2 -
  arch/arm/mach-s5pc100/clock.c                      | 1361 
--------------------
  arch/arm/mach-s5pc100/common.c                     |  255 ----
  arch/arm/mach-s5pc100/common.h                     |   30 -
  arch/arm/mach-s5pc100/dev-audio.c                  |  239 ----
  arch/arm/mach-s5pc100/dma.c                        |  130 --
  arch/arm/mach-s5pc100/include/mach/debug-macro.S   |   39 -
  arch/arm/mach-s5pc100/include/mach/dma.h           |   26 -
  arch/arm/mach-s5pc100/include/mach/entry-macro.S   |   19 -
  arch/arm/mach-s5pc100/include/mach/gpio.h          |  144 ---
  arch/arm/mach-s5pc100/include/mach/hardware.h      |   14 -
  arch/arm/mach-s5pc100/include/mach/irqs.h          |  115 --
  arch/arm/mach-s5pc100/include/mach/map.h           |  137 --
  arch/arm/mach-s5pc100/include/mach/regs-clock.h    |   80 --
  arch/arm/mach-s5pc100/include/mach/regs-gpio.h     |   38 -
  arch/arm/mach-s5pc100/include/mach/regs-irq.h      |   18 -
  arch/arm/mach-s5pc100/mach-smdkc100.c              |  264 ----
  arch/arm/mach-s5pc100/setup-fb-24bpp.c             |   35 -
  arch/arm/mach-s5pc100/setup-i2c0.c                 |   28 -
  arch/arm/mach-s5pc100/setup-i2c1.c                 |   28 -
  arch/arm/mach-s5pc100/setup-ide.c                  |   57 -
  arch/arm/mach-s5pc100/setup-keypad.c               |   23 -
  arch/arm/mach-s5pc100/setup-sdhci-gpio.c           |   70 -
  arch/arm/mach-s5pc100/setup-spi.c                  |   41 -
  arch/arm/plat-samsung/Kconfig                      |   14 +-
  arch/arm/plat-samsung/adc.c                        |    2 +-
  arch/arm/plat-samsung/include/plat/cpu.h           |   29 -
  arch/arm/plat-samsung/include/plat/devs.h          |   17 -
  arch/arm/plat-samsung/include/plat/fb.h            |   14 -
  arch/arm/plat-samsung/include/plat/s5p-clock.h     |    2 +-
  arch/arm/plat-samsung/include/plat/sdhci.h         |   77 --
  drivers/gpio/gpio-samsung.c                        |  722 -----------
  drivers/irqchip/Kconfig                            |    1 -
  drivers/mtd/onenand/Kconfig                        |    4 +-
  drivers/mtd/onenand/samsung.c                      |   25 +-
  drivers/spi/spi-s3c64xx.c                          |   22 -
  drivers/tty/serial/Kconfig                         |    1 -
  drivers/tty/serial/samsung.c                       |    4 +-
  drivers/video/fbdev/Kconfig                        |    4 +-
  drivers/video/fbdev/s3c-fb.c                       |   65 -
  include/linux/platform_data/asoc-s3c.h             |    9 -
  include/video/samsung_fimd.h                       |    2 +-
  sound/soc/samsung/Kconfig                          |    4 +-
  sound/soc/samsung/smdk_wm8580pcm.c                 |    2 +-
  85 files changed, 19 insertions(+), 8978 deletions(-)
  delete mode 100644 arch/arm/configs/s5p64x0_defconfig
  delete mode 100644 arch/arm/configs/s5pc100_defconfig
  delete mode 100644 arch/arm/mach-s5p64x0/Kconfig
  delete mode 100644 arch/arm/mach-s5p64x0/Makefile
  delete mode 100644 arch/arm/mach-s5p64x0/Makefile.boot
  delete mode 100644 arch/arm/mach-s5p64x0/clock-s5p6440.c
  delete mode 100644 arch/arm/mach-s5p64x0/clock-s5p6450.c
  delete mode 100644 arch/arm/mach-s5p64x0/clock.c
  delete mode 100644 arch/arm/mach-s5p64x0/clock.h
  delete mode 100644 arch/arm/mach-s5p64x0/common.c
  delete mode 100644 arch/arm/mach-s5p64x0/common.h
  delete mode 100644 arch/arm/mach-s5p64x0/dev-audio.c
  delete mode 100644 arch/arm/mach-s5p64x0/dma.c
  delete mode 100644 arch/arm/mach-s5p64x0/i2c.h
  delete mode 100644 arch/arm/mach-s5p64x0/include/mach/debug-macro.S
  delete mode 100644 arch/arm/mach-s5p64x0/include/mach/dma.h
  delete mode 100644 arch/arm/mach-s5p64x0/include/mach/gpio.h
  delete mode 100644 arch/arm/mach-s5p64x0/include/mach/hardware.h
  delete mode 100644 arch/arm/mach-s5p64x0/include/mach/irqs.h
  delete mode 100644 arch/arm/mach-s5p64x0/include/mach/map.h
  delete mode 100644 arch/arm/mach-s5p64x0/include/mach/pm-core.h
  delete mode 100644 arch/arm/mach-s5p64x0/include/mach/regs-clock.h
  delete mode 100644 arch/arm/mach-s5p64x0/include/mach/regs-gpio.h
  delete mode 100644 arch/arm/mach-s5p64x0/include/mach/regs-irq.h
  delete mode 100644 arch/arm/mach-s5p64x0/irq-pm.c
  delete mode 100644 arch/arm/mach-s5p64x0/mach-smdk6440.c
  delete mode 100644 arch/arm/mach-s5p64x0/mach-smdk6450.c
  delete mode 100644 arch/arm/mach-s5p64x0/pm.c
  delete mode 100644 arch/arm/mach-s5p64x0/setup-fb-24bpp.c
  delete mode 100644 arch/arm/mach-s5p64x0/setup-i2c0.c
  delete mode 100644 arch/arm/mach-s5p64x0/setup-i2c1.c
  delete mode 100644 arch/arm/mach-s5p64x0/setup-sdhci-gpio.c
  delete mode 100644 arch/arm/mach-s5p64x0/setup-spi.c
  delete mode 100644 arch/arm/mach-s5pc100/Kconfig
  delete mode 100644 arch/arm/mach-s5pc100/Makefile
  delete mode 100644 arch/arm/mach-s5pc100/Makefile.boot
  delete mode 100644 arch/arm/mach-s5pc100/clock.c
  delete mode 100644 arch/arm/mach-s5pc100/common.c
  delete mode 100644 arch/arm/mach-s5pc100/common.h
  delete mode 100644 arch/arm/mach-s5pc100/dev-audio.c
  delete mode 100644 arch/arm/mach-s5pc100/dma.c
  delete mode 100644 arch/arm/mach-s5pc100/include/mach/debug-macro.S
  delete mode 100644 arch/arm/mach-s5pc100/include/mach/dma.h
  delete mode 100644 arch/arm/mach-s5pc100/include/mach/entry-macro.S
  delete mode 100644 arch/arm/mach-s5pc100/include/mach/gpio.h
  delete mode 100644 arch/arm/mach-s5pc100/include/mach/hardware.h
  delete mode 100644 arch/arm/mach-s5pc100/include/mach/irqs.h
  delete mode 100644 arch/arm/mach-s5pc100/include/mach/map.h
  delete mode 100644 arch/arm/mach-s5pc100/include/mach/regs-clock.h
  delete mode 100644 arch/arm/mach-s5pc100/include/mach/regs-gpio.h
  delete mode 100644 arch/arm/mach-s5pc100/include/mach/regs-irq.h
  delete mode 100644 arch/arm/mach-s5pc100/mach-smdkc100.c
  delete mode 100644 arch/arm/mach-s5pc100/setup-fb-24bpp.c
  delete mode 100644 arch/arm/mach-s5pc100/setup-i2c0.c
  delete mode 100644 arch/arm/mach-s5pc100/setup-i2c1.c
  delete mode 100644 arch/arm/mach-s5pc100/setup-ide.c
  delete mode 100644 arch/arm/mach-s5pc100/setup-keypad.c
  delete mode 100644 arch/arm/mach-s5pc100/setup-sdhci-gpio.c
  delete mode 100644 arch/arm/mach-s5pc100/setup-spi.c
