From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 25 Feb 2010 00:09:19 +0000
Subject: [PULL] Pull request for for-rmk/samsung5
Message-ID: <20100225000919.GA28433@fluff.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for the late request, but haven't been very well. Quite a bit of
this update has been on list for a while, but only just been merged
together into one tree.

This is the last of the Samsung updates that need to go via RMK, they
are mostly plat-s3c/plat-s3c64xx and machine squashed and the new
S5P6442 and S5PV210 code.

Included are some updates for the current code to avoid build or runtime
problems with other updates such as via the ASoC tree.

I will be doing a seperate set of updates direct to Linus once these are
merged to fix and outstanding problems, any updates such as S3C2443 clock
rewrite and anything else not directly relying on arch/arm modifications.

There will also be a set of documentation updates to deal with the current
shifts and outline anything else that needs to be done.

Anything urgent, please cc: me directly.

The following changes since commit ab5d97db1c6ced3e95c00d097931471707032b1f:
  Ben Dooks (1):
        ARM: SAMSUNG: Fix bad use of __initdata for s3c_register_clocks()

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-rmk/samsung5

Atul Dahiya (1):
      ARM: S5P: Change S5P_TIMER_IRQ based to 11 for SAMSUNG S5P series.

Ben Dooks (45):
      ARM: S3C6400: Update s3c6400_defconfig for bigger initrds for SMDK6410
      ARM: S3C64XX: Update s3c6400_defconfig for current kernel
      ARM: S3C64XX: Merge mach-s3c6400 and mach-s3c6410
      ARM: S3C64XX: Remove useless IO descriptor from S3C6410
      ARM: S3C64XX: Squash SDHCI setup into one file
      ARM: SAMSUNG: Add documentation to the clock registration calls.
      ARM: SAMSUNG: Add error printing to s3c24xx_register_clocks
      ARM: Merge next-smdk6410-defconfig
      ARM: S3C24XX: Merge s3c2442 and s3c2440 machines into mach-s3c2440
      ARM: S3C2442: Merge s3c2442.c and clock.c
      ARM: S3C2440: Fix SMDK2440 SoC selection
      ARM: S3C244X: Move S3C2442 code into S3C2440
      ARM: S3C24XX: Remove old mach-s3c2442
      ARM: S3C24XX: Move S3C2440/S3C2442 plat-s3c24xx support to mach-s3c2440
      ARM: S3C244X: Merge plat-s3c24xx s3c2440.h and s3c2442.h into s3c244x.h
      ARM: SAMSUNG: Add DMA masks to hsotg device
      ARM: SAMSUNG: Add SERIAL_SAMSUNG_UARTS_4 Kconfig option
      ARM: SAMSUNG: Use PLAT_SAMSUNG instead of PLAT_S3C
      ARM: S3C64XX: Make audio device code built unconditionally
      ARM: Merge next-samsung-devupdates2
      ARM: Merge next-samsung-s3c244x-merge
      ARM: S3C64XX: Move headers into machine include directory
      ARM: S3C64XX: Move IRQ support into mach-s3c64xx
      ARM: S3C64XX: Move device and device setup into mach-s3c64xx
      ARM: S3C64XX: Move core support to mach-s3c64xx
      ARM: S3C64XX: Merge s3c6400-init.c into cpu.c
      ARM: S3C64XX: Merge s3c6400-clock.c and clock.c into mach-s3c64xx
      ARM: S3C64XX: Combine the clock init code
      ARM: S3C64XX: Remove plat-s3c64xx Kconfig and PLAT_S3C64XX
      ARM: SAMSUNG: Move pm-core.h to machine directory
      ARM: SAMSUNG: Remove dma-plat.h to allow plat-s3c64xx to be removed
      ARM: S3C64XX: Eliminate plat-s3c64xx
      ARM: Merge next-samsung-s3c64xx-platdeletion
      ARM: SAMSUNG: Move common headers from plat-s3c to plat-samsung
      ARM: SAMSUNG: Move map-base to plat-samsung
      ARM: SAMSUNG: Move pm.c to plat-samsung
      ARM: SAMSUNG: Move DMA support to plat-samsung
      ARM: SAMSUNG: Move the last build from plat-s3c to plat-samsung
      ARM: SAMSUNG: Move plat-s3c Kconfig entries to plat-samsung and plat-s3c24xx
      ARM: S3C24XX: Move audio-simtec.h to plat-s3c24xx
      ARM: SAMSUNG: Select NO_IOPORT for plat-samsung
      ARM: SAMSUNG: Move include/mach files out of plat-s3c
      ARM: SAMSUNG: Eliminate plat-s3c
      ARM: S5P6442: Add <mach/*.h> files missing from original commit
      ARM: SAMSUNG: Fix UART number for S5P6442

Jassi Brar (5):
      ARM: S3C64XX: SPI: Make platform device compilation selectable
      ARM: SMDK2443: Enable AC97 device
      ARM: S3C2443: GPIO: Correct AC97 pin defines
      ARM: S3C64XX: Add AC97 platform resources
      ARM: S3C64XX: Declare IISv4 PCLK for S3C6410

Kukjin Kim (17):
      ARM: S5P6440: Move CPU specific code in plat-s5p to machine directory
      ARM: S5P6440: Move common memory map definitions for S5P
      ARM: S5P6442: Add Samsung S5P6442 CPU support
      ARM: S5P6442: Add clock support for S5P6442
      ARM: S5P6442: Add IRQ support
      ARM: S5P6442: Update Kconfig and Makefiles
      ARM: S5P6442: Add SMDK6442 board support file
      ARM: S5P6442: Add S5P6442 configuration file
      ARM: S5P6442: Add serial port support
      ARM: S5PV210: Add Samsung S5PV210 CPU support
      ARM: S5PV210: Add clock support for S5PV210
      ARM: S5PV210: Add IRQ support
      ARM: S5PV210: Update Kconfig and Makefiles
      ARM: S5PV210: Add SMDKV210 board support file
      ARM: S5PV210: Add SMDKC110 board support file
      ARM: S5PV210: Add S5PV210 configuration file
      ARM: S5PV210: Add S5PC110 configuration file

Mark Brown (4):
      ARM: SMDK6410: Add initial support for WM1192-EV1 PMIC board
      ARM: SMDK6410: Add support for PMIC LED on WM1192-EV1 PMIC module
      ARM: SMDK6410: Register IISv4 device
      ARM: S3C64XX: Add initial support for board specific IRQs

Maurus Cuelenaere (1):
      ARM: SAMSUNG: Add support for 12bit ADC

Michel Pollet (1):
      ARM: S3C2412: SoC has the fractional baud rate register

Vasily Khoruzhick (2):
      ARM: SAMSUNG: Add resources description for s3c24xx ts driver
      ARM: SAMSUNG: adc: disable/enable IRQ on suspend/resume

 arch/arm/Kconfig                                   |   44 +-
 arch/arm/Kconfig.debug                             |    2 +-
 arch/arm/Makefile                                  |   14 +-
 arch/arm/configs/s3c6400_defconfig                 |  360 ++++++---
 arch/arm/configs/s5p6442_defconfig                 |  883 +++++++++++++++++++
 arch/arm/configs/s5pc110_defconfig                 |  894 ++++++++++++++++++++
 arch/arm/configs/s5pv210_defconfig                 |  894 ++++++++++++++++++++
 arch/arm/mach-s3c2410/dma.c                        |    2 +-
 .../plat => mach-s3c2410/include/mach}/pm-core.h   |    2 +-
 arch/arm/mach-s3c2410/include/mach/regs-gpio.h     |   10 +-
 .../include/mach/timex.h                           |    2 -
 .../include/mach/vmalloc.h                         |    2 +-
 arch/arm/mach-s3c2412/dma.c                        |    2 +-
 arch/arm/mach-s3c2440/Kconfig                      |   74 ++-
 arch/arm/mach-s3c2440/Makefile                     |   11 +
 arch/arm/mach-s3c2440/dma.c                        |    2 +-
 arch/arm/mach-s3c2440/dsc.c                        |    2 +-
 .../include/mach/gta02.h                           |    0 
 .../{mach-s3c2442 => mach-s3c2440}/mach-gta02.c    |    0 
 arch/arm/mach-s3c2440/mach-nexcoder.c              |    2 +-
 arch/arm/mach-s3c2440/mach-smdk2440.c              |    2 +-
 arch/arm/mach-s3c2440/s3c2440.c                    |    2 +-
 .../clock.c => mach-s3c2440/s3c2442.c}             |   16 +-
 .../{plat-s3c24xx => mach-s3c2440}/s3c244x-clock.c |    0 
 .../{plat-s3c24xx => mach-s3c2440}/s3c244x-irq.c   |    0 
 arch/arm/{plat-s3c24xx => mach-s3c2440}/s3c244x.c  |    3 +-
 arch/arm/mach-s3c2442/Kconfig                      |   37 -
 arch/arm/mach-s3c2442/Makefile                     |   18 -
 arch/arm/mach-s3c2442/s3c2442.c                    |   34 -
 arch/arm/mach-s3c2443/dma.c                        |    2 +-
 arch/arm/mach-s3c2443/mach-smdk2443.c              |   10 +-
 .../{plat-s3c => mach-s3c24a0}/include/mach/io.h   |    4 +-
 arch/arm/mach-s3c6400/Kconfig                      |   30 -
 arch/arm/mach-s3c6400/Makefile                     |   23 -
 arch/arm/mach-s3c6400/include/mach/dma.h           |   70 --
 arch/arm/mach-s3c6400/include/mach/irqs.h          |   16 -
 arch/arm/mach-s3c6400/include/mach/regs-clock.h    |   16 -
 arch/arm/mach-s3c6410/Kconfig                      |  109 ---
 arch/arm/mach-s3c6410/Makefile                     |   26 -
 arch/arm/mach-s3c6410/setup-sdhci.c                |   68 --
 arch/arm/mach-s3c64xx/Kconfig                      |  180 ++++
 arch/arm/{plat-s3c64xx => mach-s3c64xx}/Makefile   |   54 +-
 .../{mach-s3c6400 => mach-s3c64xx}/Makefile.boot   |    0 
 .../s3c6400-clock.c => mach-s3c64xx/clock.c}       |  311 +++++++-
 arch/arm/{plat-s3c64xx => mach-s3c64xx}/cpu.c      |   10 +-
 arch/arm/{plat-s3c64xx => mach-s3c64xx}/cpufreq.c  |    0 
 arch/arm/{plat-s3c64xx => mach-s3c64xx}/dev-adc.c  |    0 
 .../arm/{plat-s3c64xx => mach-s3c64xx}/dev-audio.c |   87 ++-
 arch/arm/{plat-s3c64xx => mach-s3c64xx}/dev-rtc.c  |    0 
 arch/arm/{plat-s3c64xx => mach-s3c64xx}/dev-spi.c  |    5 +-
 arch/arm/{plat-s3c64xx => mach-s3c64xx}/dev-uart.c |    0 
 arch/arm/{plat-s3c64xx => mach-s3c64xx}/dma.c      |    3 +-
 arch/arm/{plat-s3c64xx => mach-s3c64xx}/gpiolib.c  |    2 +-
 .../include/mach/debug-macro.S                     |    0 
 .../dma-plat.h => mach-s3c64xx/include/mach/dma.h} |   79 ++-
 .../include/mach/entry-macro.S                     |    2 +-
 .../include/mach}/gpio-bank-a.h                    |    2 +-
 .../include/mach}/gpio-bank-b.h                    |    2 +-
 .../include/mach}/gpio-bank-c.h                    |    2 +-
 .../include/mach}/gpio-bank-d.h                    |    2 +-
 .../include/mach}/gpio-bank-e.h                    |    2 +-
 .../include/mach}/gpio-bank-f.h                    |    2 +-
 .../include/mach}/gpio-bank-g.h                    |    2 +-
 .../include/mach}/gpio-bank-h.h                    |    2 +-
 .../include/mach}/gpio-bank-i.h                    |    2 +-
 .../include/mach}/gpio-bank-j.h                    |    2 +-
 .../include/mach}/gpio-bank-n.h                    |    2 +-
 .../include/mach}/gpio-bank-o.h                    |    2 +-
 .../include/mach}/gpio-bank-p.h                    |    2 +-
 .../include/mach}/gpio-bank-q.h                    |    2 +-
 .../include/mach/gpio.h                            |    6 +-
 .../include/mach/hardware.h                        |    0 
 .../{plat-s3c => mach-s3c64xx}/include/mach/io.h   |    4 +-
 .../plat => mach-s3c64xx/include/mach}/irqs.h      |   12 +-
 .../include/mach/map.h                             |    0 
 .../include/mach/memory.h                          |    0 
 .../plat => mach-s3c64xx/include/mach}/pll.h       |    0 
 .../plat => mach-s3c64xx/include/mach}/pm-core.h   |    4 +-
 .../include/mach/pwm-clock.h                       |    0 
 .../include/mach}/regs-clock.h                     |    0 
 .../include/mach/regs-fb.h                         |    0 
 .../include/mach}/regs-gpio-memport.h              |    0 
 .../plat => mach-s3c64xx/include/mach}/regs-gpio.h |    0 
 .../include/mach/regs-irq.h                        |    0 
 .../include/mach}/regs-modem.h                     |    0 
 .../plat => mach-s3c64xx/include/mach}/regs-srom.h |    0 
 .../plat => mach-s3c64xx/include/mach}/regs-sys.h  |    0 
 .../include/mach}/regs-syscon-power.h              |    0 
 .../plat => mach-s3c64xx/include/mach}/s3c6400.h   |    6 +-
 .../plat => mach-s3c64xx/include/mach}/s3c6410.h   |    2 +-
 .../include/mach}/spi-clocks.h                     |    2 +-
 .../include/mach/system.h                          |    0 
 .../include/mach/tick.h                            |    0 
 .../include/mach/timex.h                           |    6 +-
 .../include/mach/uncompress.h                      |    0 
 .../include/mach/vmalloc.h                         |    4 +-
 arch/arm/{plat-s3c64xx => mach-s3c64xx}/irq-eint.c |    2 +-
 arch/arm/{plat-s3c64xx => mach-s3c64xx}/irq-pm.c   |    2 +-
 arch/arm/{plat-s3c64xx => mach-s3c64xx}/irq.c      |    0 
 .../{mach-s3c6410 => mach-s3c64xx}/mach-anw6410.c  |    8 +-
 arch/arm/{mach-s3c6410 => mach-s3c64xx}/mach-hmt.c |    2 +-
 arch/arm/{mach-s3c6410 => mach-s3c64xx}/mach-ncp.c |    4 +-
 .../{mach-s3c6400 => mach-s3c64xx}/mach-smdk6400.c |    4 +-
 .../{mach-s3c6410 => mach-s3c64xx}/mach-smdk6410.c |  299 ++++++--
 arch/arm/{plat-s3c64xx => mach-s3c64xx}/pm.c       |   12 +-
 arch/arm/{mach-s3c6400 => mach-s3c64xx}/s3c6400.c  |   11 +-
 .../{mach-s3c6410/cpu.c => mach-s3c64xx/s3c6410.c} |   24 +-
 .../setup-fb-24bpp.c                               |    0 
 .../{plat-s3c64xx => mach-s3c64xx}/setup-i2c0.c    |    2 +-
 .../{plat-s3c64xx => mach-s3c64xx}/setup-i2c1.c    |    2 +-
 .../setup-sdhci-gpio.c                             |    0 
 .../{mach-s3c6400 => mach-s3c64xx}/setup-sdhci.c   |   15 +-
 arch/arm/{plat-s3c64xx => mach-s3c64xx}/sleep.S    |    6 +-
 arch/arm/mach-s5p6440/Kconfig                      |    2 -
 arch/arm/mach-s5p6440/Makefile                     |    2 +-
 .../s5p6440-clock.c => mach-s5p6440/clock.c}       |    2 +-
 arch/arm/mach-s5p6440/{s5p6440-gpio.c => gpio.c}   |    2 +-
 arch/arm/mach-s5p6440/include/mach/debug-macro.S   |    4 +-
 .../{plat-s3c => mach-s5p6440}/include/mach/io.h   |    4 +-
 arch/arm/mach-s5p6440/include/mach/map.h           |   65 +--
 arch/arm/mach-s5p6440/include/mach/regs-clock.h    |    2 +-
 arch/arm/mach-s5p6440/include/mach/tick.h          |    2 +-
 .../include/mach/timex.h                           |    6 +-
 .../include/mach/vmalloc.h                         |    9 +-
 .../s5p6440-init.c => mach-s5p6440/init.c}         |    4 +-
 arch/arm/mach-s5p6440/mach-smdk6440.c              |    4 +-
 arch/arm/mach-s5p6442/Kconfig                      |   24 +
 arch/arm/mach-s5p6442/Makefile                     |   19 +
 arch/arm/mach-s5p6442/Makefile.boot                |    2 +
 arch/arm/mach-s5p6442/clock.c                      |  396 +++++++++
 arch/arm/mach-s5p6442/cpu.c                        |  121 +++
 .../include/mach/debug-macro.S                     |   21 +-
 arch/arm/mach-s5p6442/include/mach/entry-macro.S   |   48 ++
 arch/arm/mach-s5p6442/include/mach/gpio.h          |  123 +++
 arch/arm/mach-s5p6442/include/mach/hardware.h      |   18 +
 .../{plat-s3c => mach-s5p6442}/include/mach/io.h   |    7 +-
 arch/arm/mach-s5p6442/include/mach/irqs.h          |   86 ++
 arch/arm/mach-s5p6442/include/mach/map.h           |   58 ++
 arch/arm/mach-s5p6442/include/mach/memory.h        |   19 +
 .../include/mach/pwm-clock.h                       |   33 +-
 arch/arm/mach-s5p6442/include/mach/regs-clock.h    |  103 +++
 .../include/mach/regs-irq.h                        |   13 +-
 arch/arm/mach-s5p6442/include/mach/system.h        |   26 +
 arch/arm/mach-s5p6442/include/mach/tick.h          |   26 +
 .../include/mach/timex.h                           |    8 +-
 .../include/mach/uncompress.h                      |   12 +-
 .../include/mach/vmalloc.h                         |    9 +-
 .../s5p6440-init.c => mach-s5p6442/init.c}         |   24 +-
 arch/arm/mach-s5p6442/mach-smdk6442.c              |   91 ++
 .../{plat-s3c => mach-s5pc100}/include/mach/io.h   |    4 +-
 .../include/mach/timex.h                           |    6 +-
 .../include/mach/vmalloc.h                         |    9 +-
 arch/arm/mach-s5pv210/Kconfig                      |   40 +
 arch/arm/mach-s5pv210/Makefile                     |   20 +
 arch/arm/mach-s5pv210/Makefile.boot                |    2 +
 arch/arm/mach-s5pv210/clock.c                      |  454 ++++++++++
 arch/arm/mach-s5pv210/cpu.c                        |  126 +++
 .../include/mach/debug-macro.S                     |   15 +-
 arch/arm/mach-s5pv210/include/mach/entry-macro.S   |   54 ++
 arch/arm/mach-s5pv210/include/mach/gpio.h          |  129 +++
 arch/arm/mach-s5pv210/include/mach/hardware.h      |   18 +
 arch/arm/mach-s5pv210/include/mach/io.h            |   26 +
 arch/arm/mach-s5pv210/include/mach/irqs.h          |  146 ++++
 arch/arm/mach-s5pv210/include/mach/map.h           |   65 ++
 arch/arm/mach-s5pv210/include/mach/memory.h        |   23 +
 .../include/mach/pwm-clock.h                       |   33 +-
 arch/arm/mach-s5pv210/include/mach/regs-clock.h    |  169 ++++
 .../include/mach/regs-irq.h                        |   13 +-
 arch/arm/mach-s5pv210/include/mach/system.h        |   26 +
 arch/arm/mach-s5pv210/include/mach/tick.h          |   26 +
 .../include/mach/timex.h                           |   15 +-
 .../include/mach/uncompress.h                      |   12 +-
 arch/arm/mach-s5pv210/include/mach/vmalloc.h       |   22 +
 .../s5p6440-init.c => mach-s5pv210/init.c}         |   24 +-
 arch/arm/mach-s5pv210/mach-smdkc110.c              |   98 +++
 arch/arm/mach-s5pv210/mach-smdkv210.c              |   98 +++
 arch/arm/plat-s3c/Kconfig                          |   96 ---
 arch/arm/plat-s3c/Makefile                         |   23 -
 arch/arm/plat-s3c24xx/Kconfig                      |   53 +-
 arch/arm/plat-s3c24xx/Makefile                     |    7 -
 arch/arm/plat-s3c24xx/cpu.c                        |    4 +-
 arch/arm/plat-s3c24xx/devs.c                       |   18 +
 arch/arm/plat-s3c24xx/dma.c                        |    2 +-
 .../include/plat/audio-simtec.h                    |    2 +-
 arch/arm/plat-s3c24xx/include/plat/s3c2440.h       |   17 -
 arch/arm/plat-s3c24xx/include/plat/s3c2442.h       |   17 -
 arch/arm/plat-s3c24xx/{ => include/plat}/s3c244x.h |   14 +-
 arch/arm/plat-s3c64xx/Kconfig                      |   75 --
 arch/arm/plat-s3c64xx/clock.c                      |  304 -------
 arch/arm/plat-s3c64xx/s3c6400-init.c               |   29 -
 arch/arm/plat-s5p/Kconfig                          |   19 +-
 arch/arm/plat-s5p/Makefile                         |    5 -
 arch/arm/plat-s5p/clock.c                          |   13 +
 arch/arm/plat-s5p/cpu.c                            |   39 +-
 arch/arm/plat-s5p/dev-uart.c                       |    2 +
 arch/arm/plat-s5p/include/plat/irqs.h              |    9 +-
 arch/arm/plat-s5p/include/plat/map-s5p.h           |   34 +
 arch/arm/plat-s5p/include/plat/s5p-clock.h         |    2 +
 arch/arm/plat-s5p/include/plat/s5p6442.h           |   33 +
 arch/arm/plat-s5p/include/plat/s5pv210.h           |   33 +
 arch/arm/plat-s5p/irq.c                            |    7 +-
 arch/arm/plat-samsung/Kconfig                      |   66 ++
 arch/arm/plat-samsung/Makefile                     |    7 +
 arch/arm/plat-samsung/adc.c                        |   26 +-
 arch/arm/plat-samsung/clock.c                      |   20 +-
 arch/arm/plat-samsung/dev-usb-hsotg.c              |    7 +
 arch/arm/{plat-s3c => plat-samsung}/dma.c          |    4 +-
 .../include/plat/audio.h                           |   10 +-
 arch/arm/plat-samsung/include/plat/clock.h         |    1 -
 .../include/plat/cpu-freq.h                        |    2 +-
 .../{plat-s3c => plat-samsung}/include/plat/cpu.h  |    2 +-
 .../include/plat/debug-macro.S                     |   14 +-
 .../{plat-s3c => plat-samsung}/include/plat/devs.h |    5 +-
 .../include/plat/dma-s3c24xx.h}                    |    4 +-
 .../{plat-s3c => plat-samsung}/include/plat/dma.h  |    2 +-
 .../{plat-s3c => plat-samsung}/include/plat/fb.h   |    2 +-
 .../include/plat/map-base.h                        |    0 
 .../{plat-s3c => plat-samsung}/include/plat/pm.h   |    2 +-
 arch/arm/plat-samsung/include/plat/regs-adc.h      |    1 +
 .../include/plat/regs-fb-v4.h                      |    2 +-
 .../include/plat/regs-fb.h                         |    2 +-
 .../include/plat/regs-serial.h                     |    2 +-
 arch/arm/plat-samsung/include/plat/sdhci.h         |   43 +-
 .../include/plat/uncompress.h                      |    2 +-
 .../include/plat/usb-control.h                     |    2 +-
 arch/arm/{plat-s3c => plat-samsung}/init.c         |    0 
 arch/arm/{plat-s3c => plat-samsung}/pm.c           |    2 +-
 arch/arm/{plat-s3c => plat-samsung}/time.c         |    2 +-
 drivers/serial/Kconfig                             |   20 +-
 drivers/serial/s3c2412.c                           |    1 +
 230 files changed, 7363 insertions(+), 1703 deletions(-)
 create mode 100644 arch/arm/configs/s5p6442_defconfig
 create mode 100644 arch/arm/configs/s5pc110_defconfig
 create mode 100644 arch/arm/configs/s5pv210_defconfig
 rename arch/arm/{plat-s3c24xx/include/plat => mach-s3c2410/include/mach}/pm-core.h (97%)
 copy arch/arm/{plat-s3c => mach-s3c2410}/include/mach/timex.h (99%)
 copy arch/arm/{plat-s3c => mach-s3c2410}/include/mach/vmalloc.h (91%)
 rename arch/arm/{mach-s3c2442 => mach-s3c2440}/include/mach/gta02.h (100%)
 rename arch/arm/{mach-s3c2442 => mach-s3c2440}/mach-gta02.c (100%)
 rename arch/arm/{mach-s3c2442/clock.c => mach-s3c2440/s3c2442.c} (92%)
 rename arch/arm/{plat-s3c24xx => mach-s3c2440}/s3c244x-clock.c (100%)
 rename arch/arm/{plat-s3c24xx => mach-s3c2440}/s3c244x-irq.c (100%)
 rename arch/arm/{plat-s3c24xx => mach-s3c2440}/s3c244x.c (98%)
 delete mode 100644 arch/arm/mach-s3c2442/Kconfig
 delete mode 100644 arch/arm/mach-s3c2442/Makefile
 delete mode 100644 arch/arm/mach-s3c2442/s3c2442.c
 copy arch/arm/{plat-s3c => mach-s3c24a0}/include/mach/io.h (72%)
 delete mode 100644 arch/arm/mach-s3c6400/Kconfig
 delete mode 100644 arch/arm/mach-s3c6400/Makefile
 delete mode 100644 arch/arm/mach-s3c6400/include/mach/dma.h
 delete mode 100644 arch/arm/mach-s3c6400/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-s3c6400/include/mach/regs-clock.h
 delete mode 100644 arch/arm/mach-s3c6410/Kconfig
 delete mode 100644 arch/arm/mach-s3c6410/Makefile
 delete mode 100644 arch/arm/mach-s3c6410/setup-sdhci.c
 create mode 100644 arch/arm/mach-s3c64xx/Kconfig
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/Makefile (56%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/Makefile.boot (100%)
 rename arch/arm/{plat-s3c64xx/s3c6400-clock.c => mach-s3c64xx/clock.c} (66%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/cpu.c (94%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/cpufreq.c (100%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/dev-adc.c (100%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/dev-audio.c (75%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/dev-rtc.c (100%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/dev-spi.c (98%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/dev-uart.c (100%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/dma.c (99%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/gpiolib.c (99%)
 copy arch/arm/{mach-s3c6400 => mach-s3c64xx}/include/mach/debug-macro.S (100%)
 rename arch/arm/{plat-s3c64xx/include/plat/dma-plat.h => mach-s3c64xx/include/mach/dma.h} (53%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/include/mach/entry-macro.S (95%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/gpio-bank-a.h (96%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/gpio-bank-b.h (97%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/gpio-bank-c.h (96%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/gpio-bank-d.h (96%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/gpio-bank-e.h (96%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/gpio-bank-f.h (97%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/gpio-bank-g.h (95%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/gpio-bank-h.h (97%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/gpio-bank-i.h (96%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/gpio-bank-j.h (95%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/gpio-bank-n.h (96%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/gpio-bank-o.h (97%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/gpio-bank-p.h (97%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/gpio-bank-q.h (96%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/include/mach/gpio.h (96%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/include/mach/hardware.h (100%)
 copy arch/arm/{plat-s3c => mach-s3c64xx}/include/mach/io.h (72%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/irqs.h (96%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/include/mach/map.h (100%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/include/mach/memory.h (100%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/pll.h (100%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/pm-core.h (97%)
 copy arch/arm/{mach-s3c6400 => mach-s3c64xx}/include/mach/pwm-clock.h (100%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/regs-clock.h (100%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/include/mach/regs-fb.h (100%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/regs-gpio-memport.h (100%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/regs-gpio.h (100%)
 copy arch/arm/{mach-s3c6400 => mach-s3c64xx}/include/mach/regs-irq.h (100%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/regs-modem.h (100%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/regs-srom.h (100%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/regs-sys.h (100%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/regs-syscon-power.h (100%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/s3c6400.h (87%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/s3c6410.h (93%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/spi-clocks.h (89%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/include/mach/system.h (100%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/include/mach/tick.h (100%)
 copy arch/arm/{plat-s3c => mach-s3c64xx}/include/mach/timex.h (89%)
 copy arch/arm/{mach-s3c6400 => mach-s3c64xx}/include/mach/uncompress.h (100%)
 copy arch/arm/{plat-s3c => mach-s3c64xx}/include/mach/vmalloc.h (86%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/irq-eint.c (99%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/irq-pm.c (99%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/irq.c (100%)
 rename arch/arm/{mach-s3c6410 => mach-s3c64xx}/mach-anw6410.c (97%)
 rename arch/arm/{mach-s3c6410 => mach-s3c64xx}/mach-hmt.c (99%)
 rename arch/arm/{mach-s3c6410 => mach-s3c64xx}/mach-ncp.c (97%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/mach-smdk6400.c (97%)
 rename arch/arm/{mach-s3c6410 => mach-s3c64xx}/mach-smdk6410.c (69%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/pm.c (95%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/s3c6400.c (87%)
 rename arch/arm/{mach-s3c6410/cpu.c => mach-s3c64xx/s3c6410.c} (81%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/setup-fb-24bpp.c (100%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/setup-i2c0.c (96%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/setup-i2c1.c (96%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/setup-sdhci-gpio.c (100%)
 rename arch/arm/{mach-s3c6400 => mach-s3c64xx}/setup-sdhci.c (78%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/sleep.S (97%)
 rename arch/arm/{plat-s5p/s5p6440-clock.c => mach-s5p6440/clock.c} (99%)
 rename arch/arm/mach-s5p6440/{s5p6440-gpio.c => gpio.c} (99%)
 copy arch/arm/{plat-s3c => mach-s5p6440}/include/mach/io.h (72%)
 copy arch/arm/{plat-s3c => mach-s5p6440}/include/mach/timex.h (89%)
 copy arch/arm/{plat-s3c => mach-s5p6440}/include/mach/vmalloc.h (57%)
 copy arch/arm/{plat-s5p/s5p6440-init.c => mach-s5p6440/init.c} (94%)
 create mode 100644 arch/arm/mach-s5p6442/Kconfig
 create mode 100644 arch/arm/mach-s5p6442/Makefile
 create mode 100644 arch/arm/mach-s5p6442/Makefile.boot
 create mode 100644 arch/arm/mach-s5p6442/clock.c
 create mode 100644 arch/arm/mach-s5p6442/cpu.c
 copy arch/arm/{mach-s3c6400 => mach-s5p6442}/include/mach/debug-macro.S (57%)
 create mode 100644 arch/arm/mach-s5p6442/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-s5p6442/include/mach/gpio.h
 create mode 100644 arch/arm/mach-s5p6442/include/mach/hardware.h
 copy arch/arm/{plat-s3c => mach-s5p6442}/include/mach/io.h (54%)
 create mode 100644 arch/arm/mach-s5p6442/include/mach/irqs.h
 create mode 100644 arch/arm/mach-s5p6442/include/mach/map.h
 create mode 100644 arch/arm/mach-s5p6442/include/mach/memory.h
 copy arch/arm/{mach-s3c6400 => mach-s5p6442}/include/mach/pwm-clock.h (60%)
 create mode 100644 arch/arm/mach-s5p6442/include/mach/regs-clock.h
 copy arch/arm/{mach-s3c6400 => mach-s5p6442}/include/mach/regs-irq.h (52%)
 create mode 100644 arch/arm/mach-s5p6442/include/mach/system.h
 create mode 100644 arch/arm/mach-s5p6442/include/mach/tick.h
 copy arch/arm/{plat-s3c => mach-s5p6442}/include/mach/timex.h (83%)
 copy arch/arm/{mach-s3c6400 => mach-s5p6442}/include/mach/uncompress.h (61%)
 copy arch/arm/{plat-s3c => mach-s5p6442}/include/mach/vmalloc.h (57%)
 copy arch/arm/{plat-s5p/s5p6440-init.c => mach-s5p6442/init.c} (55%)
 create mode 100644 arch/arm/mach-s5p6442/mach-smdk6442.c
 rename arch/arm/{plat-s3c => mach-s5pc100}/include/mach/io.h (72%)
 copy arch/arm/{plat-s3c => mach-s5pc100}/include/mach/timex.h (89%)
 rename arch/arm/{plat-s3c => mach-s5pc100}/include/mach/vmalloc.h (57%)
 create mode 100644 arch/arm/mach-s5pv210/Kconfig
 create mode 100644 arch/arm/mach-s5pv210/Makefile
 create mode 100644 arch/arm/mach-s5pv210/Makefile.boot
 create mode 100644 arch/arm/mach-s5pv210/clock.c
 create mode 100644 arch/arm/mach-s5pv210/cpu.c
 rename arch/arm/{mach-s3c6400 => mach-s5pv210}/include/mach/debug-macro.S (75%)
 create mode 100644 arch/arm/mach-s5pv210/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-s5pv210/include/mach/gpio.h
 create mode 100644 arch/arm/mach-s5pv210/include/mach/hardware.h
 create mode 100644 arch/arm/mach-s5pv210/include/mach/io.h
 create mode 100644 arch/arm/mach-s5pv210/include/mach/irqs.h
 create mode 100644 arch/arm/mach-s5pv210/include/mach/map.h
 create mode 100644 arch/arm/mach-s5pv210/include/mach/memory.h
 rename arch/arm/{mach-s3c6400 => mach-s5pv210}/include/mach/pwm-clock.h (59%)
 create mode 100644 arch/arm/mach-s5pv210/include/mach/regs-clock.h
 rename arch/arm/{mach-s3c6400 => mach-s5pv210}/include/mach/regs-irq.h (52%)
 create mode 100644 arch/arm/mach-s5pv210/include/mach/system.h
 create mode 100644 arch/arm/mach-s5pv210/include/mach/tick.h
 rename arch/arm/{plat-s3c => mach-s5pv210}/include/mach/timex.h (66%)
 rename arch/arm/{mach-s3c6400 => mach-s5pv210}/include/mach/uncompress.h (61%)
 create mode 100644 arch/arm/mach-s5pv210/include/mach/vmalloc.h
 rename arch/arm/{plat-s5p/s5p6440-init.c => mach-s5pv210/init.c} (55%)
 create mode 100644 arch/arm/mach-s5pv210/mach-smdkc110.c
 create mode 100644 arch/arm/mach-s5pv210/mach-smdkv210.c
 delete mode 100644 arch/arm/plat-s3c/Kconfig
 delete mode 100644 arch/arm/plat-s3c/Makefile
 rename arch/arm/{plat-s3c => plat-s3c24xx}/include/plat/audio-simtec.h (95%)
 delete mode 100644 arch/arm/plat-s3c24xx/include/plat/s3c2440.h
 delete mode 100644 arch/arm/plat-s3c24xx/include/plat/s3c2442.h
 rename arch/arm/plat-s3c24xx/{ => include/plat}/s3c244x.h (72%)
 delete mode 100644 arch/arm/plat-s3c64xx/Kconfig
 delete mode 100644 arch/arm/plat-s3c64xx/clock.c
 delete mode 100644 arch/arm/plat-s3c64xx/s3c6400-init.c
 create mode 100644 arch/arm/plat-s5p/include/plat/map-s5p.h
 create mode 100644 arch/arm/plat-s5p/include/plat/s5p6442.h
 create mode 100644 arch/arm/plat-s5p/include/plat/s5pv210.h
 rename arch/arm/{plat-s3c => plat-samsung}/dma.c (96%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/audio.h (64%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/cpu-freq.h (98%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/cpu.h (97%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/debug-macro.S (81%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/devs.h (95%)
 rename arch/arm/{plat-s3c24xx/include/plat/dma-plat.h => plat-samsung/include/plat/dma-s3c24xx.h} (95%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/dma.h (98%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/fb.h (98%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/map-base.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/pm.h (99%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-fb-v4.h (99%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-fb.h (99%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-serial.h (99%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/uncompress.h (98%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/usb-control.h (95%)
 rename arch/arm/{plat-s3c => plat-samsung}/init.c (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/pm.c (99%)
 rename arch/arm/{plat-s3c => plat-samsung}/time.c (99%)
