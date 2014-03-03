From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 03 Mar 2014 09:52:18 +0000 (GMT)
Subject: [GIT PULL 1/6] Samsung cleanup for v3.15
Message-ID: <28897112.260351393840336798.JavaMail.weblogic@epml16>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git tags/samsung-cleanup

for you to fetch changes up to d9671ca923445aa870ecc34df3db01dd602d87fc:

  ARM: EXYNOS: Remove uncompress.h (2014-02-24 09:39:18 +0900)

----------------------------------------------------------------
Samsung cleanup for v3.15
- Use generic uncompress.h for exynos and
  remove exynos accordingly
  (other uncompress.h files will be removed)
- move into s3c24xx 
- remove unused header files
- cleanup exynos related non-DT stuffs
- use inclusion instead of
  
- remove unneeded Kconfig entries:
  S3C24XX_GPIO_EXTRA64 and S3C24XX_GPIO_EXTRA128
- remove unneeded function s3c24xx_init_cpu()
- remove obsolete s3c24xx 

----------------------------------------------------------------
Heiko Stuebner (2):
      ARM: SAMSUNG: remove obsolete tick.h
      ARM: SAMSUNG: remove unneeded s3c24xx_init_cpu()

Paul Bolle (1):
      ARM: S3C24XX: get rid of unneeded selects

Sachin Kamat (4):
      ARM: SAMSUNG: Remove platform dependency from samsung.S
      ARM: S3C24XX: Move rtc-core.h from plat to mach
      ARM: debug: Use generic uncompress.h for exynos
      ARM: EXYNOS: Remove uncompress.h

Tushar Behera (4):
      ARM: SAMSUNG: Replace inclusion of plat/regs-serial.h header file
      ARM: SAMSUNG: Delete unused plat/regs-serial.h header file
      ARM: SAMSUNG: Remove Exynos specific code from devs, s5p-pm-irq and pm-gpio.c
      ARM: EXYNOS: Remove unused header file from pm_domains.c

arch/arm/Kconfig.debug                             |    5 +-
arch/arm/include/debug/samsung.S                   |    2 +-
arch/arm/mach-exynos/common.c                      |    2 +-
arch/arm/mach-exynos/include/mach/uncompress.h     |   48 --------------------
arch/arm/mach-exynos/pm_domains.c                  |    2 -
arch/arm/mach-s3c24xx/Kconfig                      |    2 -
arch/arm/mach-s3c24xx/clock-s3c2410.c              |    3 +-
arch/arm/mach-s3c24xx/clock-s3c2412.c              |    3 +-
arch/arm/mach-s3c24xx/clock-s3c2440.c              |    2 +-
arch/arm/mach-s3c24xx/common.c                     |    3 +-
arch/arm/mach-s3c24xx/dma-s3c2410.c                |    2 +-
arch/arm/mach-s3c24xx/dma-s3c2412.c                |    2 +-
arch/arm/mach-s3c24xx/dma-s3c2440.c                |    2 +-
arch/arm/mach-s3c24xx/dma-s3c2443.c                |    2 +-
arch/arm/mach-s3c24xx/include/mach/debug-macro.S   |    2 +-
.../plat => mach-s3c24xx/include/mach}/rtc-core.h  |   13 +++---
arch/arm/mach-s3c24xx/include/mach/tick.h          |   15 ------
arch/arm/mach-s3c24xx/mach-amlm5900.c              |    2 +-
arch/arm/mach-s3c24xx/mach-anubis.c                |    2 +-
arch/arm/mach-s3c24xx/mach-at2440evb.c             |    2 +-
arch/arm/mach-s3c24xx/mach-bast.c                  |    2 +-
arch/arm/mach-s3c24xx/mach-gta02.c                 |    2 +-
arch/arm/mach-s3c24xx/mach-h1940.c                 |    2 +-
arch/arm/mach-s3c24xx/mach-jive.c                  |    2 +-
arch/arm/mach-s3c24xx/mach-mini2440.c              |    2 +-
arch/arm/mach-s3c24xx/mach-n30.c                   |    2 +-
arch/arm/mach-s3c24xx/mach-nexcoder.c              |    2 +-
arch/arm/mach-s3c24xx/mach-osiris.c                |    2 +-
arch/arm/mach-s3c24xx/mach-otom.c                  |    2 +-
arch/arm/mach-s3c24xx/mach-qt2410.c                |    2 +-
arch/arm/mach-s3c24xx/mach-rx1950.c                |    2 +-
arch/arm/mach-s3c24xx/mach-rx3715.c                |    2 +-
arch/arm/mach-s3c24xx/mach-s3c2416-dt.c            |    2 +-
arch/arm/mach-s3c24xx/mach-smdk2410.c              |    2 +-
arch/arm/mach-s3c24xx/mach-smdk2413.c              |    2 +-
arch/arm/mach-s3c24xx/mach-smdk2416.c              |    2 +-
arch/arm/mach-s3c24xx/mach-smdk2440.c              |    2 +-
arch/arm/mach-s3c24xx/mach-smdk2443.c              |    2 +-
arch/arm/mach-s3c24xx/mach-tct_hammer.c            |    2 +-
arch/arm/mach-s3c24xx/mach-vr1000.c                |    2 +-
arch/arm/mach-s3c24xx/mach-vstms.c                 |    2 +-
arch/arm/mach-s3c24xx/pm.c                         |    2 +-
arch/arm/mach-s3c24xx/s3c2410.c                    |    2 +-
arch/arm/mach-s3c24xx/s3c2412.c                    |    2 +-
arch/arm/mach-s3c24xx/s3c2416.c                    |    2 +-
arch/arm/mach-s3c24xx/s3c2443.c                    |    2 +-
arch/arm/mach-s3c24xx/s3c244x.c                    |    2 +-
arch/arm/mach-s3c24xx/sleep-s3c2410.S              |    2 +-
arch/arm/mach-s3c24xx/sleep.S                      |    2 +-
arch/arm/mach-s3c64xx/common.c                     |    2 +-
arch/arm/mach-s3c64xx/include/mach/debug-macro.S   |    2 +-
arch/arm/mach-s3c64xx/include/mach/tick.h          |   31 -------------
arch/arm/mach-s3c64xx/irq-pm.c                     |    2 +-
arch/arm/mach-s3c64xx/mach-anw6410.c               |    2 +-
arch/arm/mach-s3c64xx/mach-crag6410.c              |    2 +-
arch/arm/mach-s3c64xx/mach-hmt.c                   |    2 +-
arch/arm/mach-s3c64xx/mach-mini6410.c              |    2 +-
arch/arm/mach-s3c64xx/mach-ncp.c                   |    2 +-
arch/arm/mach-s3c64xx/mach-real6410.c              |    2 +-
arch/arm/mach-s3c64xx/mach-smartq.c                |    2 +-
arch/arm/mach-s3c64xx/mach-smdk6400.c              |    3 +-
arch/arm/mach-s3c64xx/mach-smdk6410.c              |    2 +-
arch/arm/mach-s3c64xx/s3c6400.c                    |    2 +-
arch/arm/mach-s3c64xx/s3c6410.c                    |    2 +-
arch/arm/mach-s5p64x0/common.c                     |    2 +-
arch/arm/mach-s5p64x0/include/mach/debug-macro.S   |    3 +-
arch/arm/mach-s5p64x0/irq-pm.c                     |    2 +-
arch/arm/mach-s5p64x0/mach-smdk6440.c              |    2 +-
arch/arm/mach-s5p64x0/mach-smdk6450.c              |    2 +-
arch/arm/mach-s5pc100/common.c                     |    2 +-
arch/arm/mach-s5pc100/include/mach/debug-macro.S   |    2 +-
arch/arm/mach-s5pc100/include/mach/tick.h          |   31 -------------
arch/arm/mach-s5pc100/mach-smdkc100.c              |    2 +-
arch/arm/mach-s5pv210/common.c                     |    2 +-
arch/arm/mach-s5pv210/include/mach/debug-macro.S   |    2 +-
arch/arm/mach-s5pv210/mach-aquila.c                |    2 +-
arch/arm/mach-s5pv210/mach-goni.c                  |    2 +-
arch/arm/mach-s5pv210/mach-smdkc110.c              |    2 +-
arch/arm/mach-s5pv210/mach-smdkv210.c              |    2 +-
arch/arm/mach-s5pv210/mach-torbreck.c              |    2 +-
arch/arm/plat-samsung/clock.c                      |    2 +-
arch/arm/plat-samsung/cpu.c                        |    7 ---
arch/arm/plat-samsung/devs.c                       |   12 ++---
arch/arm/plat-samsung/include/plat/cpu.h           |    1 -
arch/arm/plat-samsung/include/plat/regs-serial.h   |    1 -
arch/arm/plat-samsung/include/plat/uncompress.h    |    2 +-
arch/arm/plat-samsung/init.c                       |    3 +-
arch/arm/plat-samsung/pm-gpio.c                    |    5 +-
arch/arm/plat-samsung/pm.c                         |    3 +-
arch/arm/plat-samsung/s5p-irq-pm.c                 |   13 ------
90 files changed, 90 insertions(+), 255 deletions(-)
delete mode 100644 arch/arm/mach-exynos/include/mach/uncompress.h
rename arch/arm/{plat-samsung/include/plat => mach-s3c24xx/include/mach}/rtc-core.h (69%)
delete mode 100644 arch/arm/mach-s3c24xx/include/mach/tick.h
delete mode 100644 arch/arm/mach-s3c64xx/include/mach/tick.h
delete mode 100644 arch/arm/mach-s5pc100/include/mach/tick.h
delete mode 100644 arch/arm/plat-samsung/include/plat/regs-serial.h 
