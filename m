From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 04 Oct 2011 22:21:21 +0900
Subject: [GIT PULL] Samsung cleanup-2 for v3.2
Message-ID: <019a01cc8298$823f7b20$86be7160$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

This is second cleanup for Samsung stuff for v3.2 and includes cleanup
header files in plat-s3c24xx and plat-s5p to merge into one plat-samsung
directory.

Please pull from:
  git://github.com/kgene/linux-samsung.git next-samsung-cleanup-2

And this is based on previous Samsung cleanup branch, next-samsung-cleanup
which has been merged in arm-soc because of dependency.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 4c59de052e7167a3bcf3f32c5ea4c9a5ef07386a:

  Merge branch 'next/topic-plat-samsung-1' into next-samsung-cleanup
(2011-09-17 11:05:43 +0900)

are available in the git repository at:

 git://github.com/kgene/linux-samsung.git next-samsung-cleanup-2

Kukjin Kim (6):
      ARM: SAMSUNG: Cleanup mach/clkdev.h
      ARM: SAMSUNG: Consolidate plat/pwm-clock.h
      ARM: SAMSUNG: Consolidate plat/pll.h
      ARM: SAMSUNG: Moving each SoC support header files
      ARM: SAMSUNG: Move S3C24XX header files to plat-samsung
      ARM: SAMSUNG: Move S5P header files to plat-samsung

Thomas Abraham (1):
      ARM: SAMSUNG: remove sdhci default configuration setup platform helper

arch/arm/mach-exynos4/include/mach/clkdev.h        |    7 -
 arch/arm/mach-exynos4/setup-sdhci.c                |   47 ---
 arch/arm/mach-s3c2410/mach-h1940.c                 |    6 +-
 arch/arm/mach-s3c2416/clock.c                      |    1 -
 arch/arm/mach-s3c2416/setup-sdhci.c                |   37 ---
 arch/arm/mach-s3c64xx/clock.c                      |    5 +-
 arch/arm/mach-s3c64xx/cpu.c                        |    4 +-
 arch/arm/mach-s3c64xx/include/mach/clkdev.h        |    7 -
 arch/arm/mach-s3c64xx/include/mach/pll.h           |   45 ---
 arch/arm/mach-s3c64xx/include/mach/pwm-clock.h     |   56 ----
 arch/arm/mach-s3c64xx/mach-anw6410.c               |    2 +-
 arch/arm/mach-s3c64xx/mach-crag6410.c              |    2 +-
 arch/arm/mach-s3c64xx/mach-hmt.c                   |    2 +-
 arch/arm/mach-s3c64xx/mach-mini6410.c              |    2 +-
 arch/arm/mach-s3c64xx/mach-ncp.c                   |    2 +-
 arch/arm/mach-s3c64xx/mach-real6410.c              |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq5.c               |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq7.c               |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6400.c              |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |    2 +-
 arch/arm/mach-s3c64xx/s3c6400.c                    |    2 +-
 arch/arm/mach-s3c64xx/s3c6410.c                    |    4 +-
 arch/arm/mach-s3c64xx/setup-sdhci.c                |   48 ---
 arch/arm/mach-s5p64x0/include/mach/clkdev.h        |    7 -
 arch/arm/mach-s5p64x0/include/mach/pwm-clock.h     |   68 ----
 arch/arm/mach-s5pc100/include/mach/clkdev.h        |    7 -
 arch/arm/mach-s5pc100/include/mach/pwm-clock.h     |   56 ----
 arch/arm/mach-s5pc100/setup-sdhci.c                |   42 ---
 arch/arm/mach-s5pv210/include/mach/clkdev.h        |    7 -
 arch/arm/mach-s5pv210/include/mach/pwm-clock.h     |   70 -----
 arch/arm/mach-s5pv210/setup-sdhci.c                |   41 ---
 arch/arm/plat-s3c24xx/include/mach/clkdev.h        |    7 -
 arch/arm/plat-s3c24xx/include/mach/pwm-clock.h     |   55 ----
 arch/arm/plat-s3c24xx/include/plat/pll.h           |   62 ----
 arch/arm/plat-s3c24xx/include/plat/regs-iis.h      |   68 ----
 arch/arm/plat-s3c24xx/include/plat/regs-spi.h      |   81 -----
 arch/arm/plat-s5p/include/plat/pll.h               |  152 ---------
.../include/plat/audio-simtec.h                    |    2 +-
 .../include/plat/camport.h                         |    6 +-
 .../include/plat/common-smdk.h                     |    2 +-
 .../include/plat/cpu-freq-core.h                   |    5 +-
 .../{plat-s5p => plat-samsung}/include/plat/ehci.h |    6 +-
 .../include/plat/exynos4.h                         |    2 +-
 .../include/plat/fiq.h                             |    2 +-
 .../include/plat/irq.h                             |   25 +-
 .../{plat-s5p => plat-samsung}/include/plat/irqs.h |    8 +-
 .../include/plat/mci.h                             |   10 +-
 .../{plat-s5p => plat-samsung}/include/plat/mfc.h  |    6 +-
 .../include/plat/mipi_csis.h                       |    6 +-
 arch/arm/plat-samsung/include/plat/pll.h           |  323
++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/pll6553x.h      |   51 ---
 .../mach => plat-samsung/include/plat}/pwm-clock.h |   39 ++-
 .../include/plat/regs-dma.h                        |  112 ++++----
 arch/arm/plat-samsung/include/plat/regs-iis.h      |   70 +++++
 arch/arm/plat-samsung/include/plat/regs-spi.h      |   48 +++
 .../include/plat/regs-srom.h                       |    8 +-
 .../include/plat/regs-udc.h                        |  132 ++++----
 .../include/plat/reset.h                           |    8 +-
 .../include/plat/s3c2410.h                         |    2 +-
 .../include/plat/s3c2412.h                         |    2 +-
 .../include/plat/s3c2416.h                         |    2 +-
 .../include/plat/s3c2443.h                         |    2 +-
 .../include/plat/s3c244x.h                         |    2 +-
 .../mach => plat-samsung/include/plat}/s3c6400.h   |    2 +-
 .../mach => plat-samsung/include/plat}/s3c6410.h   |    2 +-
 .../include/plat/s5p-clock.h                       |    2 +-
 .../include/plat/s5p-time.h                        |    2 +-
 .../include/plat/s5p6440.h                         |    2 +-
 .../include/plat/s5p6450.h                         |    2 +-
 .../include/plat/s5pc100.h                         |    2 +-
 .../include/plat/s5pv210.h                         |    2 +-
 arch/arm/plat-samsung/include/plat/sdhci.h         |   57 ----
 .../include/plat/sysmmu.h                          |    6 +-
 .../include/plat/system-reset.h                    |    2 +-
 .../include/plat/udc.h                             |    4 +-
 .../include/plat/usb-phy.h                         |    6 +-
 arch/arm/plat-samsung/platformdata.c               |    2 -
 arch/arm/plat-samsung/pwm-clock.c                  |   13 +-
 78 files changed, 693 insertions(+), 1306 deletions(-)
 delete mode 100644 arch/arm/mach-exynos4/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/pll.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/pwm-clock.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/pwm-clock.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/pwm-clock.h
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/pwm-clock.h
 delete mode 100644 arch/arm/plat-s3c24xx/include/mach/clkdev.h
 delete mode 100644 arch/arm/plat-s3c24xx/include/mach/pwm-clock.h
 delete mode 100644 arch/arm/plat-s3c24xx/include/plat/pll.h
 delete mode 100644 arch/arm/plat-s3c24xx/include/plat/regs-iis.h
 delete mode 100644 arch/arm/plat-s3c24xx/include/plat/regs-spi.h
 delete mode 100644 arch/arm/plat-s5p/include/plat/pll.h
 rename arch/arm/{plat-s3c24xx => plat-samsung}/include/plat/audio-simtec.h
(95%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/camport.h (86%)
 rename arch/arm/{plat-s3c24xx => plat-samsung}/include/plat/common-smdk.h
(87%)
 rename arch/arm/{plat-s3c24xx => plat-samsung}/include/plat/cpu-freq-core.h
(98%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/ehci.h (84%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/exynos4.h (94%)
 rename arch/arm/{plat-s3c24xx => plat-samsung}/include/plat/fiq.h (88%)
 rename arch/arm/{plat-s3c24xx => plat-samsung}/include/plat/irq.h (81%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/irqs.h (96%)
 rename arch/arm/{plat-s3c24xx => plat-samsung}/include/plat/mci.h (90%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/mfc.h (90%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/mipi_csis.h (90%)
 create mode 100644 arch/arm/plat-samsung/include/plat/pll.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/pll6553x.h
 rename arch/arm/{mach-exynos4/include/mach =>
plat-samsung/include/plat}/pwm-clock.h (68%)
 rename arch/arm/{plat-s3c24xx => plat-samsung}/include/plat/regs-dma.h
(58%)
 create mode 100644 arch/arm/plat-samsung/include/plat/regs-iis.h
 create mode 100644 arch/arm/plat-samsung/include/plat/regs-spi.h
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/regs-srom.h (89%)
 rename arch/arm/{plat-s3c24xx => plat-samsung}/include/plat/regs-udc.h
(51%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/reset.h (66%)
 rename arch/arm/{plat-s3c24xx => plat-samsung}/include/plat/s3c2410.h (93%)
 rename arch/arm/{plat-s3c24xx => plat-samsung}/include/plat/s3c2412.h (92%)
 rename arch/arm/{plat-s3c24xx => plat-samsung}/include/plat/s3c2416.h (92%)
 rename arch/arm/{plat-s3c24xx => plat-samsung}/include/plat/s3c2443.h (96%)
 rename arch/arm/{plat-s3c24xx => plat-samsung}/include/plat/s3c244x.h (94%)
 rename arch/arm/{mach-s3c64xx/include/mach =>
plat-samsung/include/plat}/s3c6400.h (94%)
 rename arch/arm/{mach-s3c64xx/include/mach =>
plat-samsung/include/plat}/s3c6410.h (93%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/s5p-clock.h (96%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/s5p-time.h (94%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/s5p6440.h (94%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/s5p6450.h (94%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/s5pc100.h (94%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/s5pv210.h (94%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/sysmmu.h (96%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/system-reset.h
(92%)
 rename arch/arm/{plat-s3c24xx => plat-samsung}/include/plat/udc.h (95%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/usb-phy.h (83%)
