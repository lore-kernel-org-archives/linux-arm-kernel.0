From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 08 Mar 2012 03:08:03 -0800
Subject: [GIT PULL] Samsung Cleanup S3C24XX for v3.4
Message-ID: <4F589313.1050706@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull cleanup s3c24xx from following:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/cleanup-s3c24xx

As I said before, this is including merge of mach-s3c24.. directories 
into just one mach-s3c24xx directory.

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit a5f17d1f4c2831b9b9bf8b1a537cdbac995d6e13:

   Merge tag 'v3.3-rc2' into depends/rmk/for-armsoc (2012-02-07 15:05:20 
-0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/cleanup-s3c24xx

Heiko Stuebner (17):
       ARM: S3C24XX: remove unused spi gpio setup functions
       ARM: S3C24XX: move spi-s3c24xx platdata out of mach
       ARM: S3C24XX: Remove extern declaration of clk_msysclk
       ARM: S3C24XX: move common S3C2443 clock definitions to clock.h
       ARM: S3C2410: move s3c2410_baseclk_add to clock.h
       ARM: S3C24XX: Move s3c2443-clock.c to mach-s3c24xx
       ARM: S3C24XX: Move common-smdk code to mach directory
       ARM: S3C24XX: move simtec-specific code to mach directory
       ARM: S3C24XX: Consolidate Simtec extensions
       ARM: S3C24XX: Move device setup files to mach directory
       ARM: S3C24XX: Fix indentation of dma-s3c2443
       ARM: S3C24XX: Reuse S3C2443 dma for S3C2416
       ARM: S3C24XX: remove obsolete S3C2416_DMA option
       ARM: S3C24XX: remove XXX_setup_clocks method from S3C2443
       ARM: S3C24XX: add get_rate for clk_h on S3C2416/2443
       ARM: S3C24XX: add get_rate for clk_p on S3C2416/2443
       ARM: S3C24XX: remove call to s3c24xx_setup_clocks

Kukjin Kim (8):
       ARM: S3C24XX: change the ARCH_S3C2410 to ARCH_S3C24XX
       ARM: S3C2410: move mach-s3c2410/* into mach-s3c24xx/
       ARM: S3C2412: move mach-s3c2412/* into mach-s3c24xx/
       ARM: S3C2416: move mach-s3c2416/* into mach-s3c24xx/
       ARM: S3C2440: move mach-s3c2440/* into mach-s3c24xx/
       ARM: S3C2443: move mach-s3c2443/* into mach-s3c24xx/
       ARM: s3c2410_defconfig: update s3c2410_defconfig
       Merge branch 'topic/cleanup-s3c24xx' into next/cleanup-s3c24xx

  arch/arm/Kconfig                                   |   27 +-
  arch/arm/Makefile                                  |    2 +-
  arch/arm/boot/compressed/head.S                    |    2 +-
  arch/arm/configs/mini2440_defconfig                |    2 +-
  arch/arm/configs/s3c2410_defconfig                 |   57 +--
  arch/arm/configs/tct_hammer_defconfig              |    2 +-
  arch/arm/mach-s3c2410/Kconfig                      |  154 ------
  arch/arm/mach-s3c2410/Makefile                     |   26 -
  arch/arm/mach-s3c2410/usb-simtec.h                 |   16 -
  arch/arm/mach-s3c2412/Kconfig                      |   85 ---
  arch/arm/mach-s3c2412/Makefile                     |   12 -
  arch/arm/mach-s3c2416/Kconfig                      |   60 ---
  arch/arm/mach-s3c2416/Makefile                     |   22 -
  arch/arm/mach-s3c2440/Kconfig                      |  165 ------
  arch/arm/mach-s3c2440/Makefile                     |   26 +-
  arch/arm/mach-s3c2440/common.h                     |   17 -
  arch/arm/mach-s3c2443/Kconfig                      |   32 --
  arch/arm/mach-s3c2443/Makefile                     |   20 -
  arch/arm/mach-s3c24xx/Kconfig                      |  538 
++++++++++++++++++++
  arch/arm/mach-s3c24xx/Makefile                     |   95 ++++
  .../{mach-s3c2410 => mach-s3c24xx}/Makefile.boot   |    0
  arch/arm/{mach-s3c2410 => mach-s3c24xx}/bast-ide.c |    0
  arch/arm/{mach-s3c2410 => mach-s3c24xx}/bast-irq.c |    0
  .../clock.c => mach-s3c24xx/clock-s3c2412.c}       |    0
  .../clock.c => mach-s3c24xx/clock-s3c2416.c}       |    1 -
  .../clock.c => mach-s3c24xx/clock-s3c2440.c}       |    0
  .../clock.c => mach-s3c24xx/clock-s3c2443.c}       |    7 -
  .../clock-s3c244x.c}                               |    0
  .../common-s3c2443.c}                              |   88 +++-
  .../{plat-s3c24xx => mach-s3c24xx}/common-smdk.c   |    0
  arch/arm/{mach-s3c2410 => mach-s3c24xx}/common.h   |    6 +
  .../dma.c => mach-s3c24xx/dma-s3c2410.c}           |    0
  .../dma.c => mach-s3c24xx/dma-s3c2412.c}           |    0
  .../dma.c => mach-s3c24xx/dma-s3c2440.c}           |    0
  .../dma.c => mach-s3c24xx/dma-s3c2443.c}           |   30 +-
  .../h1940-bluetooth.c                              |    0
  .../include/mach/anubis-cpld.h                     |    0
  .../include/mach/anubis-irq.h                      |    0
  .../include/mach/anubis-map.h                      |    0
  .../include/mach/bast-cpld.h                       |    0
  .../include/mach/bast-irq.h                        |    0
  .../include/mach/bast-map.h                        |    0
  .../include/mach/bast-pmu.h                        |    0
  .../include/mach/debug-macro.S                     |    0
  .../include/mach/dma.h                             |    0
  .../include/mach/entry-macro.S                     |    0
  .../include/mach/fb.h                              |    0
  .../include/mach/gpio-fns.h                        |    0
  .../include/mach/gpio-nrs.h                        |    0
  .../include/mach/gpio-track.h                      |    0
  .../include/mach/gpio.h                            |    0
  .../include/mach/gta02.h                           |    0
  .../include/mach/h1940-latch.h                     |    0
  .../include/mach/h1940.h                           |    0
  .../include/mach/hardware.h                        |    0
  .../include/mach/idle.h                            |    0
  .../include/mach/io.h                              |    0
  .../include/mach/irqs.h                            |    0
  .../include/mach/leds-gpio.h                       |    0
  .../include/mach/map.h                             |    0
  .../include/mach/osiris-cpld.h                     |    0
  .../include/mach/osiris-map.h                      |    0
  .../include/mach/otom-map.h                        |    0
  .../include/mach/pm-core.h                         |    0
  .../include/mach/regs-clock.h                      |    0
  .../include/mach/regs-dsc.h                        |    0
  .../include/mach/regs-gpio.h                       |    0
  .../include/mach/regs-gpioj.h                      |    0
  .../include/mach/regs-irq.h                        |    0
  .../include/mach/regs-lcd.h                        |    0
  .../include/mach/regs-mem.h                        |    0
  .../include/mach/regs-power.h                      |    0
  .../include/mach/regs-s3c2412-mem.h                |    0
  .../include/mach/regs-s3c2412.h                    |    0
  .../include/mach/regs-s3c2416-mem.h                |    0
  .../include/mach/regs-s3c2416.h                    |    0
  .../include/mach/regs-s3c2443-clock.h              |    0
  .../include/mach/regs-sdi.h                        |    0
  .../include/mach/tick.h                            |    0
  .../include/mach/timex.h                           |    0
  .../include/mach/uncompress.h                      |    0
  .../include/mach/vr1000-cpld.h                     |    0
  .../include/mach/vr1000-irq.h                      |    0
  .../include/mach/vr1000-map.h                      |    0
  .../irq.c => mach-s3c24xx/irq-s3c2412.c}           |    0
  .../irq.c => mach-s3c24xx/irq-s3c2416.c}           |    0
  .../irq.c => mach-s3c24xx/irq-s3c2440.c}           |    0
  .../irq.c => mach-s3c24xx/irq-s3c2443.c}           |    0
  .../s3c244x-irq.c => mach-s3c24xx/irq-s3c244x.c}   |    0
  .../{mach-s3c2410 => mach-s3c24xx}/mach-amlm5900.c |    0
  .../{mach-s3c2440 => mach-s3c24xx}/mach-anubis.c   |    1 +
  .../mach-at2440evb.c                               |    0
  .../arm/{mach-s3c2410 => mach-s3c24xx}/mach-bast.c |    3 +-
  .../{mach-s3c2440 => mach-s3c24xx}/mach-gta02.c    |    2 +-
  .../{mach-s3c2410 => mach-s3c24xx}/mach-h1940.c    |    0
  .../arm/{mach-s3c2412 => mach-s3c24xx}/mach-jive.c |    0
  .../{mach-s3c2440 => mach-s3c24xx}/mach-mini2440.c |    0
  arch/arm/{mach-s3c2410 => mach-s3c24xx}/mach-n30.c |    0
  .../{mach-s3c2440 => mach-s3c24xx}/mach-nexcoder.c |    0
  .../mach-osiris-dvs.c                              |    0
  .../{mach-s3c2440 => mach-s3c24xx}/mach-osiris.c   |    0
  .../arm/{mach-s3c2410 => mach-s3c24xx}/mach-otom.c |    0
  .../{mach-s3c2410 => mach-s3c24xx}/mach-qt2410.c   |    0
  .../{mach-s3c2440 => mach-s3c24xx}/mach-rx1950.c   |    0
  .../{mach-s3c2440 => mach-s3c24xx}/mach-rx3715.c   |    0
  .../{mach-s3c2410 => mach-s3c24xx}/mach-smdk2410.c |    0
  .../{mach-s3c2412 => mach-s3c24xx}/mach-smdk2413.c |    0
  .../{mach-s3c2416 => mach-s3c24xx}/mach-smdk2416.c |    0
  .../{mach-s3c2440 => mach-s3c24xx}/mach-smdk2440.c |    0
  .../{mach-s3c2443 => mach-s3c24xx}/mach-smdk2443.c |    0
  .../mach-tct_hammer.c                              |    0
  .../{mach-s3c2410 => mach-s3c24xx}/mach-vr1000.c   |    3 +-
  .../{mach-s3c2412 => mach-s3c24xx}/mach-vstms.c    |    0
  arch/arm/{mach-s3c2410 => mach-s3c24xx}/pm-h1940.S |    0
  .../pm.c => mach-s3c24xx/pm-s3c2410.c}             |    0
  .../pm.c => mach-s3c24xx/pm-s3c2412.c}             |    0
  .../pm.c => mach-s3c24xx/pm-s3c2416.c}             |    0
  arch/arm/{mach-s3c2410 => mach-s3c24xx}/s3c2410.c  |    0
  arch/arm/{mach-s3c2412 => mach-s3c24xx}/s3c2412.c  |    0
  arch/arm/{mach-s3c2416 => mach-s3c24xx}/s3c2416.c  |    0
  arch/arm/{mach-s3c2440 => mach-s3c24xx}/s3c2440.c  |    0
  arch/arm/{mach-s3c2440 => mach-s3c24xx}/s3c2442.c  |    0
  arch/arm/{mach-s3c2443 => mach-s3c24xx}/s3c2443.c  |    0
  arch/arm/{mach-s3c2440 => mach-s3c24xx}/s3c244x.c  |    0
  .../arm/{plat-s3c24xx => mach-s3c24xx}/setup-i2c.c |    0
  .../setup-sdhci-gpio.c                             |    0
  arch/arm/{plat-s3c24xx => mach-s3c24xx}/setup-ts.c |    0
  .../{plat-s3c24xx => mach-s3c24xx}/simtec-audio.c  |    2 +
  .../nor-simtec.c => mach-s3c24xx/simtec-nor.c}     |    2 +-
  .../pm-simtec.c => mach-s3c24xx/simtec-pm.c}       |    0
  .../usb-simtec.c => mach-s3c24xx/simtec-usb.c}     |    2 +-
  .../nor-simtec.h => mach-s3c24xx/simtec.h}         |    9 +-
  .../sleep.S => mach-s3c24xx/sleep-s3c2410.S}       |    0
  .../sleep.S => mach-s3c24xx/sleep-s3c2412.S}       |    0
  arch/arm/plat-s3c24xx/Kconfig                      |   57 +--
  arch/arm/plat-s3c24xx/Makefile                     |   19 +-
  arch/arm/plat-s3c24xx/spi-bus0-gpe11_12_13.c       |   36 --
  arch/arm/plat-s3c24xx/spi-bus1-gpd8_9_10.c         |   38 --
  arch/arm/plat-s3c24xx/spi-bus1-gpg5_6_7.c          |   36 --
  arch/arm/plat-samsung/Kconfig                      |    4 +-
  arch/arm/plat-samsung/include/plat/audio-simtec.h  |    3 -
  arch/arm/plat-samsung/include/plat/clock.h         |   22 +-
  arch/arm/plat-samsung/include/plat/regs-dma.h      |    2 +-
  arch/arm/plat-samsung/include/plat/s3c2410.h       |    2 -
  arch/arm/plat-samsung/include/plat/s3c2443.h       |   20 -
  drivers/input/touchscreen/Kconfig                  |    2 +-
  drivers/leds/Kconfig                               |    2 +-
  drivers/mmc/host/Kconfig                           |    2 +-
  drivers/mtd/nand/Kconfig                           |    2 +-
  drivers/rtc/Kconfig                                |    2 +-
  drivers/spi/Kconfig                                |    2 +-
  drivers/spi/spi-s3c24xx.c                          |    2 +-
  drivers/usb/Kconfig                                |    2 +-
  drivers/usb/gadget/Kconfig                         |    4 +-
  drivers/usb/host/ohci-hcd.c                        |    2 +-
  drivers/video/Kconfig                              |    2 +-
  drivers/watchdog/Kconfig                           |    2 +-
  .../mach/spi.h => include/linux/spi/s3c24xx.h      |   20 +-
  sound/soc/samsung/Kconfig                          |   12 +-
  159 files changed, 827 insertions(+), 986 deletions(-)
  delete mode 100644 arch/arm/mach-s3c2410/usb-simtec.h
  delete mode 100644 arch/arm/mach-s3c2416/Kconfig
  delete mode 100644 arch/arm/mach-s3c2416/Makefile
  delete mode 100644 arch/arm/mach-s3c2440/common.h
  delete mode 100644 arch/arm/mach-s3c2443/Kconfig
  delete mode 100644 arch/arm/mach-s3c2443/Makefile
  create mode 100644 arch/arm/mach-s3c24xx/Kconfig
  create mode 100644 arch/arm/mach-s3c24xx/Makefile
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/Makefile.boot (100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/bast-ide.c (100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/bast-irq.c (100%)
  rename arch/arm/{mach-s3c2412/clock.c => mach-s3c24xx/clock-s3c2412.c} 
(100%)
  rename arch/arm/{mach-s3c2416/clock.c => mach-s3c24xx/clock-s3c2416.c} 
(99%)
  rename arch/arm/{mach-s3c2440/clock.c => mach-s3c24xx/clock-s3c2440.c} 
(100%)
  rename arch/arm/{mach-s3c2443/clock.c => mach-s3c24xx/clock-s3c2443.c} 
(97%)
  rename arch/arm/{mach-s3c2440/s3c244x-clock.c => 
mach-s3c24xx/clock-s3c244x.c} (100%)
  rename arch/arm/{plat-s3c24xx/s3c2443-clock.c => 
mach-s3c24xx/common-s3c2443.c} (89%)
  rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/common-smdk.c (100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/common.h (80%)
  rename arch/arm/{mach-s3c2410/dma.c => mach-s3c24xx/dma-s3c2410.c} (100%)
  rename arch/arm/{mach-s3c2412/dma.c => mach-s3c24xx/dma-s3c2412.c} (100%)
  rename arch/arm/{mach-s3c2440/dma.c => mach-s3c24xx/dma-s3c2440.c} (100%)
  rename arch/arm/{mach-s3c2443/dma.c => mach-s3c24xx/dma-s3c2443.c} (85%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/h1940-bluetooth.c (100%)
  rename arch/arm/{mach-s3c2410 => 
mach-s3c24xx}/include/mach/anubis-cpld.h (100%)
  rename arch/arm/{mach-s3c2410 => 
mach-s3c24xx}/include/mach/anubis-irq.h (100%)
  rename arch/arm/{mach-s3c2410 => 
mach-s3c24xx}/include/mach/anubis-map.h (100%)
  rename arch/arm/{mach-s3c2410 => 
mach-s3c24xx}/include/mach/bast-cpld.h (100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/bast-irq.h 
(100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/bast-map.h 
(100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/bast-pmu.h 
(100%)
  rename arch/arm/{mach-s3c2410 => 
mach-s3c24xx}/include/mach/debug-macro.S (100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/dma.h (100%)
  rename arch/arm/{mach-s3c2410 => 
mach-s3c24xx}/include/mach/entry-macro.S (100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/fb.h (100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/gpio-fns.h 
(100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/gpio-nrs.h 
(100%)
  rename arch/arm/{mach-s3c2410 => 
mach-s3c24xx}/include/mach/gpio-track.h (100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/gpio.h (100%)
  rename arch/arm/{mach-s3c2440 => mach-s3c24xx}/include/mach/gta02.h (100%)
  rename arch/arm/{mach-s3c2410 => 
mach-s3c24xx}/include/mach/h1940-latch.h (100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/h1940.h (100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/hardware.h 
(100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/idle.h (100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/io.h (100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/irqs.h (100%)
  rename arch/arm/{mach-s3c2410 => 
mach-s3c24xx}/include/mach/leds-gpio.h (100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/map.h (100%)
  rename arch/arm/{mach-s3c2410 => 
mach-s3c24xx}/include/mach/osiris-cpld.h (100%)
  rename arch/arm/{mach-s3c2410 => 
mach-s3c24xx}/include/mach/osiris-map.h (100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/otom-map.h 
(100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/pm-core.h 
(100%)
  rename arch/arm/{mach-s3c2410 => 
mach-s3c24xx}/include/mach/regs-clock.h (100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/regs-dsc.h 
(100%)
  rename arch/arm/{mach-s3c2410 => 
mach-s3c24xx}/include/mach/regs-gpio.h (100%)
  rename arch/arm/{mach-s3c2410 => 
mach-s3c24xx}/include/mach/regs-gpioj.h (100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/regs-irq.h 
(100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/regs-lcd.h 
(100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/regs-mem.h 
(100%)
  rename arch/arm/{mach-s3c2410 => 
mach-s3c24xx}/include/mach/regs-power.h (100%)
  rename arch/arm/{mach-s3c2410 => 
mach-s3c24xx}/include/mach/regs-s3c2412-mem.h (100%)
  rename arch/arm/{mach-s3c2410 => 
mach-s3c24xx}/include/mach/regs-s3c2412.h (100%)
  rename arch/arm/{mach-s3c2410 => 
mach-s3c24xx}/include/mach/regs-s3c2416-mem.h (100%)
  rename arch/arm/{mach-s3c2410 => 
mach-s3c24xx}/include/mach/regs-s3c2416.h (100%)
  rename arch/arm/{mach-s3c2410 => 
mach-s3c24xx}/include/mach/regs-s3c2443-clock.h (100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/regs-sdi.h 
(100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/tick.h (100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/include/mach/timex.h (100%)
  rename arch/arm/{mach-s3c2410 => 
mach-s3c24xx}/include/mach/uncompress.h (100%)
  rename arch/arm/{mach-s3c2410 => 
mach-s3c24xx}/include/mach/vr1000-cpld.h (100%)
  rename arch/arm/{mach-s3c2410 => 
mach-s3c24xx}/include/mach/vr1000-irq.h (100%)
  rename arch/arm/{mach-s3c2410 => 
mach-s3c24xx}/include/mach/vr1000-map.h (100%)
  rename arch/arm/{mach-s3c2412/irq.c => mach-s3c24xx/irq-s3c2412.c} (100%)
  rename arch/arm/{mach-s3c2416/irq.c => mach-s3c24xx/irq-s3c2416.c} (100%)
  rename arch/arm/{mach-s3c2440/irq.c => mach-s3c24xx/irq-s3c2440.c} (100%)
  rename arch/arm/{mach-s3c2443/irq.c => mach-s3c24xx/irq-s3c2443.c} (100%)
  rename arch/arm/{mach-s3c2440/s3c244x-irq.c => 
mach-s3c24xx/irq-s3c244x.c} (100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/mach-amlm5900.c (100%)
  rename arch/arm/{mach-s3c2440 => mach-s3c24xx}/mach-anubis.c (99%)
  rename arch/arm/{mach-s3c2440 => mach-s3c24xx}/mach-at2440evb.c (100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/mach-bast.c (99%)
  rename arch/arm/{mach-s3c2440 => mach-s3c24xx}/mach-gta02.c (99%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/mach-h1940.c (100%)
  rename arch/arm/{mach-s3c2412 => mach-s3c24xx}/mach-jive.c (100%)
  rename arch/arm/{mach-s3c2440 => mach-s3c24xx}/mach-mini2440.c (100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/mach-n30.c (100%)
  rename arch/arm/{mach-s3c2440 => mach-s3c24xx}/mach-nexcoder.c (100%)
  rename arch/arm/{mach-s3c2440 => mach-s3c24xx}/mach-osiris-dvs.c (100%)
  rename arch/arm/{mach-s3c2440 => mach-s3c24xx}/mach-osiris.c (100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/mach-otom.c (100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/mach-qt2410.c (100%)
  rename arch/arm/{mach-s3c2440 => mach-s3c24xx}/mach-rx1950.c (100%)
  rename arch/arm/{mach-s3c2440 => mach-s3c24xx}/mach-rx3715.c (100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/mach-smdk2410.c (100%)
  rename arch/arm/{mach-s3c2412 => mach-s3c24xx}/mach-smdk2413.c (100%)
  rename arch/arm/{mach-s3c2416 => mach-s3c24xx}/mach-smdk2416.c (100%)
  rename arch/arm/{mach-s3c2440 => mach-s3c24xx}/mach-smdk2440.c (100%)
  rename arch/arm/{mach-s3c2443 => mach-s3c24xx}/mach-smdk2443.c (100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/mach-tct_hammer.c (100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/mach-vr1000.c (99%)
  rename arch/arm/{mach-s3c2412 => mach-s3c24xx}/mach-vstms.c (100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/pm-h1940.S (100%)
  rename arch/arm/{mach-s3c2410/pm.c => mach-s3c24xx/pm-s3c2410.c} (100%)
  rename arch/arm/{mach-s3c2412/pm.c => mach-s3c24xx/pm-s3c2412.c} (100%)
  rename arch/arm/{mach-s3c2416/pm.c => mach-s3c24xx/pm-s3c2416.c} (100%)
  rename arch/arm/{mach-s3c2410 => mach-s3c24xx}/s3c2410.c (100%)
  rename arch/arm/{mach-s3c2412 => mach-s3c24xx}/s3c2412.c (100%)
  rename arch/arm/{mach-s3c2416 => mach-s3c24xx}/s3c2416.c (100%)
  rename arch/arm/{mach-s3c2440 => mach-s3c24xx}/s3c2440.c (100%)
  rename arch/arm/{mach-s3c2440 => mach-s3c24xx}/s3c2442.c (100%)
  rename arch/arm/{mach-s3c2443 => mach-s3c24xx}/s3c2443.c (100%)
  rename arch/arm/{mach-s3c2440 => mach-s3c24xx}/s3c244x.c (100%)
  rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/setup-i2c.c (100%)
  rename arch/arm/{mach-s3c2416 => mach-s3c24xx}/setup-sdhci-gpio.c (100%)
  rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/setup-ts.c (100%)
  rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/simtec-audio.c (98%)
  rename arch/arm/{mach-s3c2410/nor-simtec.c => 
mach-s3c24xx/simtec-nor.c} (98%)
  rename arch/arm/{plat-s3c24xx/pm-simtec.c => mach-s3c24xx/simtec-pm.c} 
(100%)
  rename arch/arm/{mach-s3c2410/usb-simtec.c => 
mach-s3c24xx/simtec-usb.c} (99%)
  rename arch/arm/{mach-s3c2410/nor-simtec.h => mach-s3c24xx/simtec.h} (63%)
  rename arch/arm/{mach-s3c2410/sleep.S => mach-s3c24xx/sleep-s3c2410.S} 
(100%)
  rename arch/arm/{mach-s3c2412/sleep.S => mach-s3c24xx/sleep-s3c2412.S} 
(100%)
  delete mode 100644 arch/arm/plat-s3c24xx/spi-bus0-gpe11_12_13.c
  delete mode 100644 arch/arm/plat-s3c24xx/spi-bus1-gpd8_9_10.c
  delete mode 100644 arch/arm/plat-s3c24xx/spi-bus1-gpg5_6_7.c
  rename arch/arm/mach-s3c2410/include/mach/spi.h => 
include/linux/spi/s3c24xx.h (56%)
