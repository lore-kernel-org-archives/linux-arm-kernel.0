From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 19 Sep 2011 19:37:27 +0900
Subject: [GIT PULL] Samsung boards for v3.2
Message-ID: <001a01cc76b8$208e52c0$61aaf840$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

This is for Samsung boards for v3.2.

Please pull from:
  git://github.com/kgene/linux-samsung.git next-samsung-board

As you see, the next-samsung-board includes new board, SMDK4212. Of course
to support new SoC, EXYNOS4212 is required for it but current
arch/arm/mach-exynos4 (ARCH_EXYNOS4) can support it so I merged it into
next-samsung-board not next-samsung-soc and to support handling of cupid and
rev. in Samsung stuff for it. As I remember, you said -soc branch of arm-soc
is for adding new architecture like arch/arm/mach-xxxx.

As a note, this includes samsung-fixes-2 which has been already pulled in
your tree too.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit b6fd41e29dea9c6753b1843a77e50433e6123bcb:

  Linux 3.1-rc6 (2011-09-12 14:02:02 -0700)

are available in the git repository at:
  git://github.com/kgene/linux-samsung.git next-samsung-board

Ajay Kumar (1):
      ARM: SAMSUNG: Fix mask value for S5P64X0 CPU IDs

Banajit Goswami (1):
      ARM: S3C64XX: Remove un-used code backlight code on SMDK6410

Changhwan Youn (1):
      ARM: EXYNOS4: restart clocksource while system resumes

JeongHyeon Kim (1):
      ARM: EXYNOS4: Add support for ORIGEN board

Jonghwan Choi (2):
      ARM: EXYNOS4: Fix wrong pll type for vpll
      ARM: EXYNOS4: Add support PM for EXYNOS4212

Kukjin Kim (14):
      ARM: EXYNOS4: Turn the mach-smdkc210.c into mach-smdv310.c
      ARM: SAMSUNG: Add support for detecting CPU at runtime
      ARM: S5P64X0: Use soc_is_s5p64x0() to distinguish cpu at runtime
      ARM: SAMSUNG: Add support for handling of cpu revision
      ARM: EXYNOS4: Use samsung_rev() to distinguish silicon revision
      ARM: EXYNOS4: Fix return type of local_timer_setup()
      ARM: EXYNOS4: Fix routing timer interrupt to offline CPU
      ARM: SAMSUNG: fix to prevent declaring duplicated
      Merge branch 'next/topic-cpuid-rev' into next/topic-add-exynos4212
      Merge branch 'next/topic-cleanup-smdkv310' into
next/topic-add-exynos4212
      ARM: EXYNOS4: Add support new EXYNOS4212 SoC
      ARM: EXYNOS4: Add support clock for EXYNOS4212
      ARM: EXYNOS4: Add support SMDK4212 Board
      Merge branch 'next-samsung-board-v3.1' into next-samsung-board

Marek Szyprowski (1):
      ARM: SAMSUNG: fix watchdog reset issue with clk_get()

Mark Brown (1):
      ARM: SAMSUNG: Fix mask for S3C64xx CPU IDs

Thomas Abraham (1):
      ARM: EXYNOS4: fix incorrect pad configuration for keypad row lines

 arch/arm/configs/exynos4_defconfig                 |    1 +
 arch/arm/mach-exynos4/Kconfig                      |   57 +++-
 arch/arm/mach-exynos4/Makefile                     |   11 +-
 arch/arm/mach-exynos4/clock-exynos4210.c           |  139 +++++++++
 arch/arm/mach-exynos4/clock-exynos4212.c           |  118 ++++++++
 arch/arm/mach-exynos4/clock.c                      |  218 +++++++++-----
 arch/arm/mach-exynos4/cpu.c                        |   40 +++-
 arch/arm/mach-exynos4/include/mach/exynos4-clock.h |   43 +++
 arch/arm/mach-exynos4/include/mach/map.h           |    3 +-
 arch/arm/mach-exynos4/include/mach/regs-clock.h    |   54 +++--
 arch/arm/mach-exynos4/mach-origen.c                |  108 +++++++
 arch/arm/mach-exynos4/mach-smdk4212.c              |  292
++++++++++++++++++
 arch/arm/mach-exynos4/mach-smdkc210.c              |  309
--------------------
 arch/arm/mach-exynos4/mach-smdkv310.c              |   78 +++++
 arch/arm/mach-exynos4/mct.c                        |   10 +-
 arch/arm/mach-exynos4/platsmp.c                    |   10 +-
 arch/arm/mach-exynos4/pm.c                         |   79 +-----
 arch/arm/mach-exynos4/setup-keypad.c               |   11 +-
 arch/arm/mach-s3c64xx/cpu.c                        |   22 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |   39 ---
 arch/arm/mach-s5p64x0/dev-spi.c                    |    8 +-
 arch/arm/mach-s5p64x0/dma.c                        |    7 +-
 arch/arm/mach-s5p64x0/gpiolib.c                    |    7 +-
 arch/arm/mach-s5p64x0/irq-eint.c                   |    3 +-
 arch/arm/plat-s3c24xx/cpu.c                        |    9 +-
 arch/arm/plat-s5p/cpu.c                            |   37 ++-
 arch/arm/plat-s5p/include/plat/exynos4.h           |    5 +-
 arch/arm/plat-s5p/include/plat/pll.h               |   55 ++++-
 arch/arm/plat-samsung/Makefile                     |    2 +-
 arch/arm/plat-samsung/clock.c                      |   11 +
 arch/arm/plat-samsung/cpu.c                        |   58 ++++
 arch/arm/plat-samsung/include/plat/clock.h         |    8 +
 arch/arm/plat-samsung/include/plat/cpu.h           |  105 +++++++-
 .../arm/plat-samsung/include/plat/watchdog-reset.h |   10 +-
 34 files changed, 1360 insertions(+), 607 deletions(-)
 create mode 100644 arch/arm/mach-exynos4/clock-exynos4210.c
 create mode 100644 arch/arm/mach-exynos4/clock-exynos4212.c
 create mode 100644 arch/arm/mach-exynos4/include/mach/exynos4-clock.h
 create mode 100644 arch/arm/mach-exynos4/mach-origen.c
 create mode 100644 arch/arm/mach-exynos4/mach-smdk4212.c
 delete mode 100644 arch/arm/mach-exynos4/mach-smdkc210.c
 create mode 100644 arch/arm/plat-samsung/cpu.c
