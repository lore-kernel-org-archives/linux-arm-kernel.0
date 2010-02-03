From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 3 Feb 2010 02:11:05 +0000
Subject: [PULL] Please pull bjdooks' for-rmk/samsung4
Message-ID: <20100203021105.GA2379@fluff.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please pull bjdooks' for-rmk/samsung4. 

This has some of the s3c64xx updates before a proposed merge of plat-s3c64xx,
the S5P updates needed before merging the next S5P SoCs and the s3c244x
squash of mach-s3c2442 into mach-s3c2440

The plat-s3c64xx squash will be sent as soon as it is re-based and the
organisation of it is sorted out.

The following changes since commit ab5d97db1c6ced3e95c00d097931471707032b1f:
  Ben Dooks (1):
        ARM: SAMSUNG: Fix bad use of __initdata for s3c_register_clocks()

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-rmk/samsung4

Atul Dahiya (1):
      ARM: S5P: Change S5P_TIMER_IRQ based to 11 for SAMSUNG S5P series.

Ben Dooks (18):
      ARM: S3C6400: Update s3c6400_defconfig for bigger initrds for SMDK6410
      ARM: S3C64XX: Update s3c6400_defconfig for current kernel
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

Jassi Brar (1):
      ARM: S3C64XX: SPI: Make platform device compilation selectable

Kukjin Kim (2):
      ARM: S5P6440: Move CPU specific code in plat-s5p to machine directory
      ARM: S5P6440: Move common memory map definitions for S5P

Maurus Cuelenaere (1):
      ARM: SAMSUNG: Add support for 12bit ADC

Michel Pollet (1):
      ARM: S3C2412: SoC has the fractional baud rate register

 arch/arm/Kconfig                                   |    1 -
 arch/arm/Makefile                                  |    2 +-
 arch/arm/configs/s3c6400_defconfig                 |  360 ++++++++++++++------
 arch/arm/mach-s3c2440/Kconfig                      |   74 ++++-
 arch/arm/mach-s3c2440/Makefile                     |   11 +
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
 arch/arm/mach-s3c2442/Kconfig                      |   37 --
 arch/arm/mach-s3c2442/Makefile                     |   18 -
 arch/arm/mach-s3c2442/s3c2442.c                    |   34 --
 arch/arm/mach-s3c2443/mach-smdk2443.c              |    2 +-
 arch/arm/mach-s5p6440/Kconfig                      |    2 -
 arch/arm/mach-s5p6440/Makefile                     |    2 +-
 .../s5p6440-clock.c => mach-s5p6440/clock.c}       |    2 +-
 arch/arm/mach-s5p6440/{s5p6440-gpio.c => gpio.c}   |    2 +-
 arch/arm/mach-s5p6440/include/mach/debug-macro.S   |    4 +-
 arch/arm/mach-s5p6440/include/mach/map.h           |   65 +---
 arch/arm/mach-s5p6440/include/mach/regs-clock.h    |    2 +-
 arch/arm/mach-s5p6440/include/mach/tick.h          |    2 +-
 .../s5p6440-init.c => mach-s5p6440/init.c}         |    4 +-
 arch/arm/mach-s5p6440/mach-smdk6440.c              |    4 +-
 arch/arm/plat-s3c24xx/Kconfig                      |   41 ---
 arch/arm/plat-s3c24xx/Makefile                     |    7 -
 arch/arm/plat-s3c24xx/cpu.c                        |    4 +-
 arch/arm/plat-s3c24xx/include/plat/s3c2440.h       |   17 -
 arch/arm/plat-s3c24xx/include/plat/s3c2442.h       |   17 -
 arch/arm/plat-s3c24xx/{ => include/plat}/s3c244x.h |   14 +-
 arch/arm/plat-s3c64xx/Makefile                     |    9 +-
 arch/arm/plat-s5p/Kconfig                          |   16 -
 arch/arm/plat-s5p/Makefile                         |    5 -
 arch/arm/plat-s5p/cpu.c                            |   19 +-
 arch/arm/plat-s5p/include/plat/irqs.h              |    4 +-
 arch/arm/plat-s5p/include/plat/map-s5p.h           |   32 ++
 arch/arm/plat-s5p/irq.c                            |    5 +-
 arch/arm/plat-samsung/Kconfig                      |    6 +
 arch/arm/plat-samsung/adc.c                        |   24 +-
 arch/arm/plat-samsung/clock.c                      |   20 +-
 arch/arm/plat-samsung/dev-usb-hsotg.c              |    7 +
 arch/arm/plat-samsung/include/plat/regs-adc.h      |    1 +
 drivers/serial/Kconfig                             |   18 +-
 drivers/serial/s3c2412.c                           |    1 +
 49 files changed, 527 insertions(+), 395 deletions(-)
 rename arch/arm/{mach-s3c2442 => mach-s3c2440}/include/mach/gta02.h (100%)
 rename arch/arm/{mach-s3c2442 => mach-s3c2440}/mach-gta02.c (100%)
 rename arch/arm/{mach-s3c2442/clock.c => mach-s3c2440/s3c2442.c} (92%)
 rename arch/arm/{plat-s3c24xx => mach-s3c2440}/s3c244x-clock.c (100%)
 rename arch/arm/{plat-s3c24xx => mach-s3c2440}/s3c244x-irq.c (100%)
 rename arch/arm/{plat-s3c24xx => mach-s3c2440}/s3c244x.c (98%)
 delete mode 100644 arch/arm/mach-s3c2442/Kconfig
 delete mode 100644 arch/arm/mach-s3c2442/Makefile
 delete mode 100644 arch/arm/mach-s3c2442/s3c2442.c
 rename arch/arm/{plat-s5p/s5p6440-clock.c => mach-s5p6440/clock.c} (99%)
 rename arch/arm/mach-s5p6440/{s5p6440-gpio.c => gpio.c} (99%)
 rename arch/arm/{plat-s5p/s5p6440-init.c => mach-s5p6440/init.c} (94%)
 delete mode 100644 arch/arm/plat-s3c24xx/include/plat/s3c2440.h
 delete mode 100644 arch/arm/plat-s3c24xx/include/plat/s3c2442.h
 rename arch/arm/plat-s3c24xx/{ => include/plat}/s3c244x.h (72%)
 create mode 100644 arch/arm/plat-s5p/include/plat/map-s5p.h

-- 
Ben (ben at fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
