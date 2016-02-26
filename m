From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 26 Feb 2016 09:05:02 +0900
Subject: [GIT PULL 1/2] ARM: EXYNOS: mach/soc changes for v4.6, 2nd
Message-ID: <1456445103-23314-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,


Second pull request for v4.6 with mach/soc changes. This does
not contain any external dependencies.

It includes movement of PMU code to separate driver (drivers/soc) but
it does not have commits doing the same for the SROM controller driver
(that part I will send separately).


Kind regards,
Krzysztof


Cc: Pankaj Dubey <pankaj.dubey@samsung.com>



The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.6-2

for you to fetch changes up to 15925cfcf83361b4eb8c7ffb51ad29b5f1e32a23:

  ARM: s3c24xx: Avoid warning for inb/outb (2016-02-26 08:44:52 +0900)

----------------------------------------------------------------
Samsung Exynos (and older platforms) improvements for v4.6:
1. Split out Exynos PMU driver implementation from arm/mach-exynos
   to the drivers/soc/samsung which will allow re-use of it on ARM64.
2. Use generic DT cpufreq driver on Exynos542x/5800.
3. Minor cleanups.

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: s3c24xx: Avoid warning for inb/outb

Bartlomiej Zolnierkiewicz (2):
      ARM: EXYNOS: Use generic cpufreq driver for Exynos5420
      ARM: EXYNOS: Use generic cpufreq driver for Exynos5422/5800

Geliang Tang (1):
      ARM: plat-samsung: use to_platform_device()

Krzysztof Kozlowski (1):
      drivers: soc: samsung: Enable COMPILE_TEST

Masahiro Yamada (1):
      ARM: s3c64xx: use "depends on" instead of "if" after prompt

Pankaj Dubey (12):
      ARM: EXYNOS: Remove unused static mapping of CMU for exynos5
      ARM: EXYNOS: Code cleanup in map.h
      ARM: EXYNOS: Correct header comment in Kconfig file
      ARM: EXYNOS: Move pmu specific headers under "linux/soc/samsung"
      ARM: EXYNOS: Split up exynos3250 SoC specific PMU data
      ARM: EXYNOS: Split up exynos4 SoC specific PMU data
      ARM: EXYNOS: Split up exynos5250 SoC specific PMU data
      ARM: EXYNOS: Split up exynos5420 SoC specific PMU data
      drivers: soc: Add support for Exynos PMU driver
      MAINTAINERS: Add maintainers entry for drivers/soc/samsung
      ARM: EXYNOS: Cleanup header files inclusion
      ARM: SAMSUNG: Remove unused register offset definition

 MAINTAINERS                                        |   1 +
 arch/arm/mach-exynos/Kconfig                       |   4 +-
 arch/arm/mach-exynos/Makefile                      |   2 +-
 arch/arm/mach-exynos/common.h                      |   1 -
 arch/arm/mach-exynos/exynos.c                      |  17 +-
 arch/arm/mach-exynos/firmware.c                    |   2 -
 arch/arm/mach-exynos/include/mach/map.h            |  14 +-
 arch/arm/mach-exynos/mcpm-exynos.c                 |   2 +-
 arch/arm/mach-exynos/platsmp.c                     |   3 +-
 arch/arm/mach-exynos/pm.c                          |   8 +-
 arch/arm/mach-exynos/pmu.c                         | 967 ---------------------
 arch/arm/mach-exynos/s5p-dev-mfc.c                 |   1 -
 arch/arm/mach-exynos/suspend.c                     |   4 +-
 arch/arm/mach-s3c24xx/include/mach/io.h            |   2 +-
 arch/arm/mach-s3c24xx/include/mach/map.h           |  11 -
 arch/arm/mach-s3c64xx/Kconfig                      |   3 +-
 arch/arm/plat-samsung/adc.c                        |   6 +-
 arch/arm/plat-samsung/include/plat/map-s3c.h       |   4 -
 arch/arm/plat-samsung/include/plat/map-s5p.h       |   5 -
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/samsung/Kconfig                        |  13 +
 drivers/soc/samsung/Makefile                       |   2 +
 drivers/soc/samsung/exynos-pmu.c                   | 141 +++
 drivers/soc/samsung/exynos-pmu.h                   |  44 +
 drivers/soc/samsung/exynos3250-pmu.c               | 175 ++++
 drivers/soc/samsung/exynos4-pmu.c                  | 222 +++++
 drivers/soc/samsung/exynos5250-pmu.c               | 195 +++++
 drivers/soc/samsung/exynos5420-pmu.c               | 280 ++++++
 .../linux/soc/samsung}/exynos-pmu.h                |   6 +-
 .../linux/soc/samsung/exynos-regs-pmu.h            |   6 +-
 31 files changed, 1103 insertions(+), 1040 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/pmu.c
 create mode 100644 drivers/soc/samsung/Kconfig
 create mode 100644 drivers/soc/samsung/Makefile
 create mode 100644 drivers/soc/samsung/exynos-pmu.c
 create mode 100644 drivers/soc/samsung/exynos-pmu.h
 create mode 100644 drivers/soc/samsung/exynos3250-pmu.c
 create mode 100644 drivers/soc/samsung/exynos4-pmu.c
 create mode 100644 drivers/soc/samsung/exynos5250-pmu.c
 create mode 100644 drivers/soc/samsung/exynos5420-pmu.c
 rename {arch/arm/mach-exynos => include/linux/soc/samsung}/exynos-pmu.h (81%)
 rename arch/arm/mach-exynos/regs-pmu.h => include/linux/soc/samsung/exynos-regs-pmu.h (99%)
