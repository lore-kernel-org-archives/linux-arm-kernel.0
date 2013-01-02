From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Jan 2013 14:23:37 -0800
Subject: [PATCH 00/26] ARM: SAMSUNG: cleanup header files
Message-ID: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is cleanup Samsung headers in each mach/ directoires.
Still remains some headers in Samsung mach/ and plat/ but they will be
cleaned up soon.

Note, if there is no problem on this, most of Samsung patches for v3.9
should be rebased on this because this touches many Samsung stuff...

Any problems, please kindly let me know.
Thanks and Happy New Year.

- Kukjin

Kukjin Kim (26):
      gpio: samsung: remove inclusion <mach/regs-clock.h>
      cpufreq: exynos: cleanup exynos-cpufreq header
      ARM: S5P64X0: remove gpiolib.c file in mach-s5p64x0
      ARM: S5P64X0: move i2c.h into local directory
      ARM: S5P64X0: move s5p64x0-clock.h into local directory
      ARM: S5PV210: move regs-sys.h into setup-usb-phy.c file
      ARM: EXYNOS: move mach/pmu.h file into common.h
      ARM: SAMSUNG: cleanup mach/regs-audss.h file
      ARM: SAMSUNG: cleanup mach/gpio-fns.h gpio-track.h and gpio-nrs.h
      ARM: S3C24XX: make anubis-cpld, anubis-irq and anubis-map local
      ARM: S3C24XX: make bast-cpld.h, bast-irq.h and bast-map.h local
      ARM: S3C24XX: make gta02.h local
      ARM: S3C24XX: make h1940.h and h1940-latch.h local
      ARM: S3C24XX: make osiris-cpld.h and osiris-map.h local
      ARM: S3C24XX: make otom-map.h local
      ARM: S3C24XX: make vr1000-cpld.h, vr1000-irq.h and vr1000-map.h local
      ARM: S3C2416: remove regs-s3c2416-mem.h and regs-s3c2416.h
      ARM: S3C2412: cleanup regs-s3c2412.h
      ARM: S3C24XX: remove idle.h
      ARM: S3C24XX: remove dsc.c and make regs-dsc.h local
      ARM: S3C64XX: make crag6410.h local
      ARM: S3C64XX: make regs-gpio-memport.h local
      ARM: S3C64XX: make regs-modem.h local
      ARM: S3C64XX: make regs-srom.h local
      ARM: S3C64XX: make regs-sys.h local
      ARM: S3C64XX: make regs-syscon-power.h local

 arch/arm/mach-exynos/common.c                      |    1 -
 arch/arm/mach-exynos/common.h                      |   20 +
 arch/arm/mach-exynos/cpuidle.c                     |    3 +-
 arch/arm/mach-exynos/dev-audio.c                   |    3 +-
 arch/arm/mach-exynos/include/mach/pmu.h            |   34 --
 arch/arm/mach-exynos/include/mach/regs-audss.h     |   18 -
 arch/arm/mach-exynos/pm.c                          |    3 +-
 arch/arm/mach-exynos/pmu.c                         |    3 +-
 arch/arm/mach-s3c2440/Makefile                     |    2 -
 arch/arm/mach-s3c2440/dsc.c                        |   54 ---
 arch/arm/mach-s3c24xx/anubis.h                     |   53 ++
 arch/arm/mach-s3c24xx/bast-ide.c                   |   18 +-
 arch/arm/mach-s3c24xx/bast-irq.c                   |   19 +-
 arch/arm/mach-s3c24xx/bast.h                       |  197 ++++++++
 arch/arm/mach-s3c24xx/{include/mach => }/gta02.h   |   14 +-
 arch/arm/mach-s3c24xx/h1940-bluetooth.c            |    6 +-
 .../{include/mach/h1940-latch.h => h1940.h}        |   22 +-
 arch/arm/mach-s3c24xx/include/mach/anubis-cpld.h   |   25 -
 arch/arm/mach-s3c24xx/include/mach/anubis-irq.h    |   21 -
 arch/arm/mach-s3c24xx/include/mach/anubis-map.h    |   38 --
 arch/arm/mach-s3c24xx/include/mach/bast-cpld.h     |   53 --
 arch/arm/mach-s3c24xx/include/mach/bast-irq.h      |   29 --
 arch/arm/mach-s3c24xx/include/mach/bast-map.h      |  146 ------
 arch/arm/mach-s3c24xx/include/mach/gpio-fns.h      |    1 -
 arch/arm/mach-s3c24xx/include/mach/gpio-nrs.h      |   97 ----
 arch/arm/mach-s3c24xx/include/mach/gpio-track.h    |   33 --
 arch/arm/mach-s3c24xx/include/mach/gpio.h          |   87 +++-
 arch/arm/mach-s3c24xx/include/mach/h1940.h         |   24 -
 arch/arm/mach-s3c24xx/include/mach/idle.h          |   24 -
 arch/arm/mach-s3c24xx/include/mach/osiris-cpld.h   |   30 --
 arch/arm/mach-s3c24xx/include/mach/regs-gpio.h     |    2 -
 arch/arm/mach-s3c24xx/include/mach/regs-s3c2412.h  |   23 -
 .../mach-s3c24xx/include/mach/regs-s3c2416-mem.h   |   30 --
 arch/arm/mach-s3c24xx/include/mach/regs-s3c2416.h  |   24 -
 arch/arm/mach-s3c24xx/include/mach/vr1000-cpld.h   |   18 -
 arch/arm/mach-s3c24xx/include/mach/vr1000-irq.h    |   26 -
 arch/arm/mach-s3c24xx/include/mach/vr1000-map.h    |  110 -----
 arch/arm/mach-s3c24xx/mach-anubis.c                |   13 +-
 arch/arm/mach-s3c24xx/mach-at2440evb.c             |    1 +
 arch/arm/mach-s3c24xx/mach-bast.c                  |   52 +-
 arch/arm/mach-s3c24xx/mach-gta02.c                 |   59 ++-
 arch/arm/mach-s3c24xx/mach-h1940.c                 |   37 +-
 arch/arm/mach-s3c24xx/mach-osiris.c                |   27 +-
 arch/arm/mach-s3c24xx/mach-otom.c                  |   20 +-
 arch/arm/mach-s3c24xx/mach-rx1950.c                |   31 +-
 arch/arm/mach-s3c24xx/mach-rx3715.c                |   16 +-
 arch/arm/mach-s3c24xx/mach-smdk2413.c              |    1 -
 arch/arm/mach-s3c24xx/mach-smdk2416.c              |    1 -
 arch/arm/mach-s3c24xx/mach-smdk2440.c              |    1 -
 arch/arm/mach-s3c24xx/mach-smdk2443.c              |    1 -
 arch/arm/mach-s3c24xx/mach-vr1000.c                |   37 +-
 arch/arm/mach-s3c24xx/mach-vstms.c                 |    1 -
 .../{include/mach/osiris-map.h => osiris.h}        |   23 +-
 .../{include/mach/otom-map.h => otom.h}            |   20 +-
 arch/arm/mach-s3c24xx/pm-s3c2410.c                 |    6 +-
 arch/arm/mach-s3c24xx/pm-s3c2412.c                 |    8 +-
 .../arm/mach-s3c24xx/{include/mach => }/regs-dsc.h |    0
 arch/arm/mach-s3c24xx/s3c2412.c                    |   29 +-
 arch/arm/mach-s3c24xx/s3c244x.c                    |    3 +-
 arch/arm/mach-s3c24xx/simtec-audio.c               |    5 +-
 arch/arm/mach-s3c24xx/simtec-nor.c                 |    3 +-
 arch/arm/mach-s3c24xx/simtec-usb.c                 |    8 +-
 arch/arm/mach-s3c24xx/vr1000.h                     |  118 +++++
 arch/arm/mach-s3c64xx/clock.c                      |    3 +-
 arch/arm/mach-s3c64xx/cpuidle.c                    |    3 +-
 .../arm/mach-s3c64xx/{include/mach => }/crag6410.h |    0
 arch/arm/mach-s3c64xx/dma.c                        |    4 +-
 arch/arm/mach-s3c64xx/include/mach/regs-sys.h      |   31 --
 arch/arm/mach-s3c64xx/mach-anw6410.c               |    2 +-
 arch/arm/mach-s3c64xx/mach-crag6410-module.c       |    2 +-
 arch/arm/mach-s3c64xx/mach-crag6410.c              |    9 +-
 arch/arm/mach-s3c64xx/mach-mini6410.c              |    4 +-
 arch/arm/mach-s3c64xx/mach-real6410.c              |    4 +-
 arch/arm/mach-s3c64xx/mach-smartq.c                |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |    6 +-
 arch/arm/mach-s3c64xx/pm.c                         |    9 +-
 .../{include/mach => }/regs-gpio-memport.h         |    9 +-
 .../mach-s3c64xx/{include/mach => }/regs-modem.h   |   11 +-
 .../mach-s3c64xx/{include/mach => }/regs-srom.h    |   11 +-
 arch/arm/mach-s3c64xx/regs-sys.h                   |   30 ++
 .../{include/mach => }/regs-syscon-power.h         |    9 +-
 arch/arm/mach-s3c64xx/setup-usb-phy.c              |    3 +-
 arch/arm/mach-s5p64x0/clock-s5p6440.c              |    2 +-
 arch/arm/mach-s5p64x0/clock-s5p6450.c              |    2 +-
 .../{include/mach/s5p64x0-clock.h => clock.h}      |    9 +-
 arch/arm/mach-s5p64x0/gpiolib.c                    |  508 --------------------
 arch/arm/mach-s5p64x0/{include/mach => }/i2c.h     |    3 +-
 arch/arm/mach-s5p64x0/mach-smdk6440.c              |    2 +-
 arch/arm/mach-s5p64x0/mach-smdk6450.c              |    2 +-
 arch/arm/mach-s5p64x0/setup-i2c0.c                 |    2 +-
 arch/arm/mach-s5p64x0/setup-i2c1.c                 |    2 +-
 arch/arm/mach-s5pv210/dev-audio.c                  |    3 +-
 arch/arm/mach-s5pv210/include/mach/regs-audss.h    |   18 -
 arch/arm/mach-s5pv210/include/mach/regs-sys.h      |   15 -
 arch/arm/mach-s5pv210/setup-usb-phy.c              |    7 +-
 arch/arm/plat-samsung/include/plat/gpio-core.h     |   13 +-
 arch/arm/plat-samsung/include/plat/gpio-fns.h      |    1 -
 drivers/cpufreq/exynos-cpufreq.c                   |    4 +-
 .../cpufreq.h => drivers/cpufreq/exynos-cpufreq.h  |    3 +-
 drivers/cpufreq/exynos4210-cpufreq.c               |    3 +-
 drivers/cpufreq/exynos4x12-cpufreq.c               |    3 +-
 drivers/cpufreq/exynos5250-cpufreq.c               |    3 +-
 drivers/gpio/gpio-samsung.c                        |    2 -
 sound/soc/samsung/h1940_uda1380.c                  |   13 +-
 sound/soc/samsung/neo1973_wm8753.c                 |    8 +-
 105 files changed, 836 insertions(+), 1776 deletions(-)
