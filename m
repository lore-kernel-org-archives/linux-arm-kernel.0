From: amit.daniel@samsung.com (Amit Daniel Kachhap)
Date: Mon, 24 Nov 2014 07:36:10 +0530
Subject: [PATCH v4 0/5] exynos: Move pmu driver to driver/soc folder and add
 exynos7 support
Message-ID: <1416794775-1605-1-git-send-email-amit.daniel@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series [1 - 5] performs,

1) Moves pmu driver to driver/soc/samsung folder. This is needed as exynos7 is
   an arm64 based platform and hence PMU driver should be in driver folder.
   Some discussion happened about this in the v1 version. Finally adding it in
   driver/soc folder as it too SoC specific and not a general driver.
   Entire discussion can be found here (A).
2) Add exynos7 PMU support.
3) Enables the driver for 32bit arm exynos platforms.

Changes from V3:
* Fixed Kconfig as per Russell feedback
* Rebased the series against Pankaj SoC restart consolidation patches (D) as per
  Kukjin request.
* Link to V3 can be found here (C)

Changes from V2:
* Added review comment changes suggested by Pankaj.
* Removed mfd client support in this patch series. This will be added later in
  the power domain patch series.
* Link to V2 can be found here (B)

Changes from V1:
* Move pmu driver in driver/soc/samsung folder
* Removed the power domain features. They will posted as a separate series.
* Added exynos7 PMU support.
* Link to v1 can be found here (A)

This complete patch series is rebased on Kukjin for-next tree.

(A) - http://www.spinics.net/lists/linux-samsung-soc/msg38442.html
(B) - http://www.spinics.net/lists/arm-kernel/msg375910.html
(C) - http://www.spinics.net/lists/linux-samsung-soc/msg39237.html 
(D) - http://www.spinics.net/lists/linux-samsung-soc/msg39095.html

Amit Daniel Kachhap (5):
  ARM: EXYNOS: Move pmu specific header files under "linux/soc/samsung"
  drivers: soc: Add support for Exynos PMU driver
  driver: soc: exynos-pmu: Add an API to be called after wakeup
  drivers: soc: exynos-pmu: Add support for Exynos7
  arm: exynos: Select SOC_SAMSUNG config option

 .../devicetree/bindings/arm/samsung/pmu.txt        |    1 +
 arch/arm/mach-exynos/Kconfig                       |    1 +
 arch/arm/mach-exynos/Makefile                      |    2 +-
 arch/arm/mach-exynos/exynos.c                      |    2 +-
 arch/arm/mach-exynos/mcpm-exynos.c                 |    2 +-
 arch/arm/mach-exynos/platsmp.c                     |    2 +-
 arch/arm/mach-exynos/pm.c                          |    4 +-
 arch/arm/mach-exynos/suspend.c                     |    4 +-
 drivers/soc/Kconfig                                |    1 +
 drivers/soc/Makefile                               |    1 +
 drivers/soc/samsung/Kconfig                        |   20 +
 drivers/soc/samsung/Makefile                       |    1 +
 .../pmu.c => drivers/soc/samsung/exynos-pmu.c      |  442 +++++++++++++++++++-
 .../linux/soc/samsung}/exynos-pmu.h                |    1 +
 .../linux/soc/samsung/exynos-regs-pmu.h            |  273 ++++++++++++
 15 files changed, 744 insertions(+), 13 deletions(-)
 create mode 100644 drivers/soc/samsung/Kconfig
 create mode 100644 drivers/soc/samsung/Makefile
 rename arch/arm/mach-exynos/pmu.c => drivers/soc/samsung/exynos-pmu.c (64%)
 rename {arch/arm/mach-exynos => include/linux/soc/samsung}/exynos-pmu.h (89%)
 rename arch/arm/mach-exynos/regs-pmu.h => include/linux/soc/samsung/exynos-regs-pmu.h (63%)

-- 
1.7.9.5
