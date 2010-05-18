From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 18 May 2010 11:47:43 +0100
Subject: first tree for samsung
Message-ID: <20100518104743.GK26401@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the state of the tree since the first round of Russell bound
updates. Unfortunately some fo these archs do not build without
being ontop of RMK's trees so have yet to be fully tested

Russell, since there's some dependecny, do you mind pulling this
into your tree, or should I wait for Linus to merge yours and then
send mine?

The following changes since commit 63b1f51b2405573d47bf5b9ab6e7cd5c697d3dcc:
  Ben Dooks (1):
        ARM: SAMSUNG: Update S3C2416 entry with S3C2450

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-rmk/samsung

Arnaud Patard (3):
      ARM: h1940: fix touchscreen support
      ARM: S3C24XX: fix s3c2410fb platdata passing
      ARM: S3C24XX: s3c24xx_mci_set_platdata should be marked __init

Atul Dahiya (1):
      ARM: SAMSUNG: Move RTC device definitions in plat-samsung

Ben Dooks (31):
      ARM: n30: Fixup gpiolib calls for mmc power
      ARM: n30: Just call s3c24xx_init_irq() directly from machine definition
      ARM: SAMSUNG: Add spinlock locking to GPIO banks
      ARM: SAMSUNG: Remove old email address for ben-linux at fluff.org
      ARM: S3C2443: Add initial defines for framebuffer support
      ARM: S3C2443: Fix definition of LCD clock bit
      ARM: SAMSUNG: Set S3C_FB_MAX_WIN in <plat/fb.h>
      ARM: SMDK2416: Add support for framebuffer device and ensure correct setup
      ARM: S3C24XX: Start cleanup of GPIO numbering
      ARM: S3C24XX: Update missed gpio calls to use gpiolib
      ARM: S3C24XX: Remove macros mapping GPIO number to base
      ARM: S3C24XX: Add note on GPIO bank sizes
      ARM: SAMSUNG: Fix additional increment when running through gpios
      ARM: Merge for-2635/samsung-bugfix
      ARM: Merge for-2635/s3c24xx-general
      ARM: Merge for-2635/s5p-general
      ARM: Merge for-2635/samsung-dma
      ARM: Merge for-2635/samsung-hwmon
      ARM: Merge for-2635/samsung-clock
      ARM: Merge for-2635/acer-n35
      ARM: Merge for-2635/rx1950
      ARM: Merge for-2635/gpio2
      ARM: Merge for-2635/s3c6410-clock
      ARM: Merge for-2635/s5p6440-clock
      ARM: Merge for-2635/s5pv210-clock
      ARM: Merge for-2635/fb-updates1
      yARM: Merge for-2635/s5p-dma
      ARM: Merge for-2635/s5p-audio
      ARM: Merge for-2635/samsung-ts
      ARM: Merge for-2635/samsung-rtc
      ARM: Merge for-2635/s5pc100-fixes

Jassi Brar (16):
      ARM: S3C6410: Define clk_src2 register
      ARM: S3C6410: Declare IISCDCLK_V4 Clock
      ARM: S3C6410: Declare possible sources of audio-bus2
      ARM: S3C6410: Declare IISv4 audio-bus clock
      S3C: DMA: Change argument of s3c2410_dma_devconfig
      S3C: DMA: Add api driver for PL330
      S5P6440: DMA: Add platform devices for PL330 DMACs
      S5P6442: DMA: Add platform devices for PL330 DMACs
      S5PV210: DMA: Add platform devices for PL330 DMACs
      ARM: S5PV210: Add audio platform devices
      ARM: SMDKV210: Add audio devices on board
      ARM: SMDKC110: Add audio devices on board
      ARM: S5P6442: Add audio platform devices
      ARM: SMDK6442: Add audio devices on board
      ARM: S5P6440: Add audio platform devices
      ARM: SMDK6440: Add audio devices on board

Jongpill Lee (3):
      ARM: S5P6440: Bug fix on PWM Timer
      ARM: S5P6442: Bug fix on PWM Timer
      ARM: S5PV210: Bug fix on PWM Timer

Kukjin Kim (1):
      ARM: SAMSUNG: Remove static of S5P SoCs sysclass

Marek Szyprowski (3):
      ARM: Samsung: fix broken timer irq base
      ARM: SMDKC100: fix frame buffer definitions
      ARM: SMDKC100: remove magic values from uart setup structures

Maurus Cuelenaere (2):
      ARM: SAMSUNG: Move HWMON from plat-s3c24xx to plat-samsung
      ARM: S3C64XX: Add USB external clock definition

Mike Solovyev (1):
      ARM: h1940: framebuffer configuration fix

Naveen Krishna (1):
      ARM: SAMSUNG: Moving ADC device definition to plat-samsung.

Pannaga Bhushan (1):
      ARM: S5PV210: Add S5PV210 GPIO support.

Pinkava J (7):
      ARM: n30: Enable Acer n35 if Acer n30 is selected
      ARM: n30: fix: suspended wrong USB port on Acer n35
      ARM: n30: Add RTC platform device for Acer n30 / Acer n35
      ARM: n35: Add support for LEDs on Acer n35
      ARM: n35: Enable wake-up by Power button on Acer n35
      ARM: n30: Add support for MMC card reader on Acer n30 / Acer n35
      ARM: n30: Add support for power on/off on Acer n30 / Acer n35 MMC card reader

Thomas Abraham (27):
      ARM: S5P: Add USB External Crystal clock definition
      ARM: S5P6440: Register apll/mpll/epll mout clocks.
      ARM: S5P6440: Change dout_mpll clock type to clksrc_clk clock type.
      ARM: S5P6440: Remove usage of clk_arm and add clk_armclk clock
      ARM: S5P6440: Remove usage of clk_h and add clk_hclk clock
      ARM: S5P6440: Remove usage of clk_p and add clk_pclk clock
      ARM: S5P6440: Remove usage of clk_h_low and add clk_hclk_low clock
      ARM: S5P6440: Remove usage of clk_p_low and add clk_pclk_low clock
      ARM: S5P6440: Add clocks of type 'struct clk'.
      ARM: S5P6440: Rename clkset_mmc_spi to clkset_group1
      ARM: S5P6440: Add clocks of type 'struct clksrc_clk'.
      ARM: S5PV210: Rearrange the system clock definitions
      ARM: S5PV210: Register apll/mpll/epll clksrc_clk clocks
      ARM: S5PV210: Rearrange assignment of clock for fout apll/mpll/epll clocks
      ARM: S5PV210: Add armclk of clksrc_clk clock type
      ARM: S5PV210: Remove usage of clk_h200 clock and add clk_hclk_msys clock
      ARM: S5PV210: Remove usage of clk_h166 and add clk_hclk_dsys clock
      ARM: S5PV210: Remove usage of clk_h133 and add clk_hclk_psys clock
      ARM: S5PV210: Remove usage of clk_p100 and add clk_pclk_msys clock
      ARM: S5PV210: Fix clk_get_rate issue with the clk_h100 clock
      ARM: S5PV210: Remove usage of clk_p83 and add clk_pclk_dsys clock\
      ARM: S5PV210: Remove usage of clk_p66 and add clk_pclk_psys clock
      ARM: S5PV210: Add support for VPLL
      ARM: S5PV210: Add new system clocks
      ARM: S5PV210: Add sclk_dac, sclk_mixer and sclk_hdmi clocks
      ARM: S5PV210: Add sclk_audio and sclk_spdif clocks.
      ARM: S5PV210: Add sclk clocks of type 'struct clksrc_clk' clock

Vasily Khoruzhick (5):
      ARM: S3C2440: Add HP iPAQ RX1950 machine support
      ARM: S3C24XX: Locate kernel at 0x30108000 if PM_H1940 is enabled
      ARM: RX1950: Add suspend/resume support for RX1950
      ARM: RX1950: configure GPG13-15 as input before suspend
      ARM: S3C244X: fix gpiolib port J support

 arch/arm/Makefile                                  |    2 +
 arch/arm/mach-s3c2410/Kconfig                      |    8 +
 arch/arm/mach-s3c2410/Makefile.boot                |   10 +-
 arch/arm/mach-s3c2410/include/mach/gpio-nrs.h      |   25 +-
 arch/arm/mach-s3c2410/include/mach/gpio-track.h    |    4 +-
 arch/arm/mach-s3c2410/include/mach/gpio.h          |    8 +
 arch/arm/mach-s3c2410/include/mach/irqs.h          |    3 +
 arch/arm/mach-s3c2410/include/mach/map.h           |    3 +
 arch/arm/mach-s3c2410/include/mach/regs-gpio.h     |   22 +-
 .../mach-s3c2410/include/mach/regs-s3c2443-clock.h |    3 +-
 arch/arm/mach-s3c2410/mach-bast.c                  |    2 +-
 arch/arm/mach-s3c2410/mach-h1940.c                 |    9 +-
 arch/arm/mach-s3c2410/mach-n30.c                   |   76 ++-
 arch/arm/mach-s3c2410/pm.c                         |   15 +-
 arch/arm/mach-s3c2412/gpio.c                       |   20 +-
 arch/arm/mach-s3c2412/mach-jive.c                  |    2 +-
 arch/arm/mach-s3c2412/mach-smdk2413.c              |    6 +-
 arch/arm/mach-s3c2416/Kconfig                      |    1 +
 arch/arm/mach-s3c2416/mach-smdk2416.c              |   62 +-
 arch/arm/mach-s3c2416/s3c2416.c                    |    2 +
 arch/arm/mach-s3c2440/Kconfig                      |   13 +
 arch/arm/mach-s3c2440/Makefile                     |    1 +
 arch/arm/mach-s3c2440/mach-rx1950.c                |  582 ++++++++++
 arch/arm/mach-s3c2440/mach-rx3715.c                |    2 +-
 arch/arm/mach-s3c2440/mach-smdk2440.c              |    2 +-
 arch/arm/mach-s3c2443/mach-smdk2443.c              |    2 +-
 arch/arm/mach-s3c64xx/Kconfig                      |    1 +
 arch/arm/mach-s3c64xx/Makefile                     |    2 -
 arch/arm/mach-s3c64xx/clock.c                      |   36 +
 arch/arm/mach-s3c64xx/dma.c                        |    2 +-
 arch/arm/mach-s3c64xx/include/mach/map.h           |    3 +
 arch/arm/mach-s3c64xx/include/mach/regs-clock.h    |    1 +
 arch/arm/mach-s3c64xx/mach-smdk6400.c              |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |    2 +-
 arch/arm/mach-s3c64xx/s3c6410.c                    |    2 +
 arch/arm/mach-s5p6440/Kconfig                      |    1 +
 arch/arm/mach-s5p6440/Makefile                     |    5 +-
 arch/arm/mach-s5p6440/clock.c                      |  350 ++++--
 arch/arm/mach-s5p6440/cpu.c                        |    2 +-
 arch/arm/mach-s5p6440/dev-audio.c                  |  127 ++
 arch/arm/mach-s5p6440/dma.c                        |  105 ++
 arch/arm/mach-s5p6440/include/mach/dma.h           |   26 +
 arch/arm/mach-s5p6440/include/mach/map.h           |    8 +
 arch/arm/mach-s5p6440/include/mach/pwm-clock.h     |   24 +-
 arch/arm/mach-s5p6440/mach-smdk6440.c              |    1 +
 arch/arm/mach-s5p6442/Kconfig                      |    1 +
 arch/arm/mach-s5p6442/Makefile                     |    5 +-
 arch/arm/mach-s5p6442/cpu.c                        |    2 +-
 arch/arm/mach-s5p6442/dev-audio.c                  |  197 ++++
 arch/arm/mach-s5p6442/dma.c                        |  105 ++
 arch/arm/mach-s5p6442/include/mach/dma.h           |   26 +
 arch/arm/mach-s5p6442/include/mach/map.h           |   11 +
 arch/arm/mach-s5p6442/include/mach/pwm-clock.h     |   21 +-
 arch/arm/mach-s5p6442/mach-smdk6442.c              |    1 +
 arch/arm/mach-s5pc100/mach-smdkc100.c              |   43 +-
 arch/arm/mach-s5pv210/Kconfig                      |    1 +
 arch/arm/mach-s5pv210/Makefile                     |    6 +-
 arch/arm/mach-s5pv210/clock.c                      |  833 ++++++++++++--
 arch/arm/mach-s5pv210/cpu.c                        |    2 +-
 arch/arm/mach-s5pv210/dev-audio.c                  |  327 ++++++
 arch/arm/mach-s5pv210/dma.c                        |  168 +++
 arch/arm/mach-s5pv210/gpiolib.c                    |  257 ++++
 arch/arm/mach-s5pv210/include/mach/dma.h           |   26 +
 arch/arm/mach-s5pv210/include/mach/gpio.h          |   18 +-
 arch/arm/mach-s5pv210/include/mach/map.h           |   17 +
 arch/arm/mach-s5pv210/include/mach/pwm-clock.h     |   21 +-
 arch/arm/mach-s5pv210/mach-smdkc110.c              |    2 +
 arch/arm/mach-s5pv210/mach-smdkv210.c              |    2 +
 arch/arm/mm/mmu.c                                  |    5 +-
 arch/arm/plat-s3c24xx/devs.c                       |   19 +-
 arch/arm/plat-s3c24xx/dma.c                        |    2 +-
 arch/arm/plat-s3c24xx/gpio.c                       |    8 +-
 arch/arm/plat-s5p/clock.c                          |   13 +
 arch/arm/plat-s5p/include/plat/irqs.h              |    2 +-
 arch/arm/plat-s5p/include/plat/s5p-clock.h         |    2 +
 arch/arm/plat-samsung/Kconfig                      |   21 +
 arch/arm/plat-samsung/Makefile                     |    6 +
 arch/arm/{mach-s3c64xx => plat-samsung}/dev-adc.c  |    8 +-
 arch/arm/plat-samsung/dev-fb.c                     |    1 -
 arch/arm/plat-samsung/dev-hwmon.c                  |   42 +
 arch/arm/{mach-s3c64xx => plat-samsung}/dev-rtc.c  |   28 +-
 arch/arm/plat-samsung/gpio-config.c                |   12 +-
 arch/arm/plat-samsung/gpio.c                       |   15 +-
 arch/arm/plat-samsung/include/plat/clock.h         |    1 +
 arch/arm/plat-samsung/include/plat/cpu.h           |    3 +
 arch/arm/plat-samsung/include/plat/devs.h          |   16 +
 arch/arm/plat-samsung/include/plat/dma.h           |    4 +-
 arch/arm/plat-samsung/include/plat/fb.h            |    7 +
 arch/arm/plat-samsung/include/plat/gpio-core.h     |   14 +
 arch/arm/plat-samsung/include/plat/hwmon.h         |   10 +
 arch/arm/plat-samsung/include/plat/s3c-dma-pl330.h |   78 ++
 .../plat-samsung/include/plat/s3c-pl330-pdata.h    |   32 +
 arch/arm/plat-samsung/pm-gpio.c                    |    4 +-
 arch/arm/plat-samsung/s3c-pl330.c                  | 1224 ++++++++++++++++++++
 94 files changed, 4852 insertions(+), 402 deletions(-)
 create mode 100644 arch/arm/mach-s3c2440/mach-rx1950.c
 create mode 100644 arch/arm/mach-s5p6440/dev-audio.c
 create mode 100644 arch/arm/mach-s5p6440/dma.c
 create mode 100644 arch/arm/mach-s5p6440/include/mach/dma.h
 create mode 100644 arch/arm/mach-s5p6442/dev-audio.c
 create mode 100644 arch/arm/mach-s5p6442/dma.c
 create mode 100644 arch/arm/mach-s5p6442/include/mach/dma.h
 create mode 100644 arch/arm/mach-s5pv210/dev-audio.c
 create mode 100644 arch/arm/mach-s5pv210/dma.c
 create mode 100644 arch/arm/mach-s5pv210/gpiolib.c
 create mode 100644 arch/arm/mach-s5pv210/include/mach/dma.h
 rename arch/arm/{mach-s3c64xx => plat-samsung}/dev-adc.c (86%)
 create mode 100644 arch/arm/plat-samsung/dev-hwmon.c
 rename arch/arm/{mach-s3c64xx => plat-samsung}/dev-rtc.c (58%)
 create mode 100644 arch/arm/plat-samsung/include/plat/s3c-dma-pl330.h
 create mode 100644 arch/arm/plat-samsung/include/plat/s3c-pl330-pdata.h
 create mode 100644 arch/arm/plat-samsung/s3c-pl330.c

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
