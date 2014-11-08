From: amit.daniel@samsung.com (Amit Daniel Kachhap)
Date: Sat, 08 Nov 2014 18:46:35 +0530
Subject: [PATCH v2 0/6] exynos: Move pmu driver to driver/soc folder and add
 exynos7 support
Message-ID: <1415452601-13078-1-git-send-email-amit.daniel@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series[1 - 6] performs,

1) Moves pmu driver to driver/soc/samsung folder. Some discussion happened about
   this in the v1 version. Finally adding it in driver/soc folder as it too SoC
   specific and not a general driver. Entire discussion can be found here (A).
2) Registers this driver as MFD client driver. This will be used by clients like exynos pm
   sleep and pm domain driver.
3) Add exynos7 PMU support.

Changes from V1:
* Move pmu driver in driver/soc/samsung folder
* Removed the power domain features. They will posted as a separate series.
* Added exynos7 PMU support.
* Link to v1 can be found here (B)

This patch has dependency on following patches posted earlier by Pankaj (C),
which is accepted by maintainer.

Patch 6 was earlier posted by Abhilash (D) which has been reposted here with some
extra changes.

This complete patch series is rebased on linux-next.

(A) - http://www.spinics.net/lists/linux-samsung-soc/msg38444.html
(B) - http://www.spinics.net/lists/linux-samsung-soc/msg38442.html
(C) - https://lkml.org/lkml/2014/10/6/581
(D) - http://www.spinics.net/lists/arm-kernel/msg358230.html 

Amit Daniel Kachhap (6):
  ARM: EXYNOS: Move pmu specific header files under "linux/soc/samsung"
  drivers: soc: Add support for Exynos PMU driver
  drivers: soc: samsung: Fix a spelling mistake
  soc: samsung: exynos-pmu: Register exynos-pmu driver as a mfd driver
  driver: soc: exynos-pmu: Add an API to be called after wakeup
  drivers: soc: samsung: Add support for Exynos7 pmu

 .../devicetree/bindings/arm/samsung/pmu.txt        |    1 +
 arch/arm/mach-exynos/Makefile                      |    2 +-
 arch/arm/mach-exynos/exynos.c                      |    2 +-
 arch/arm/mach-exynos/mcpm-exynos.c                 |    2 +-
 arch/arm/mach-exynos/platsmp.c                     |    2 +-
 arch/arm/mach-exynos/pm.c                          |    4 +-
 arch/arm/mach-exynos/regs-pmu.h                    |  335 -----------
 arch/arm/mach-exynos/suspend.c                     |    3 +-
 drivers/soc/Kconfig                                |    1 +
 drivers/soc/Makefile                               |    1 +
 drivers/soc/samsung/Kconfig                        |   19 +
 drivers/soc/samsung/Makefile                       |    1 +
 .../pmu.c => drivers/soc/samsung/exynos-pmu.c      |  471 ++++++++++++++-
 .../linux/soc/samsung}/exynos-pmu.h                |    6 +
 include/linux/soc/samsung/exynos-regs-pmu.h        |  608 ++++++++++++++++++++
 15 files changed, 1109 insertions(+), 349 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/regs-pmu.h
 create mode 100644 drivers/soc/samsung/Kconfig
 create mode 100644 drivers/soc/samsung/Makefile
 rename arch/arm/mach-exynos/pmu.c => drivers/soc/samsung/exynos-pmu.c (50%)
 rename {arch/arm/mach-exynos => include/linux/soc/samsung}/exynos-pmu.h (78%)
 create mode 100644 include/linux/soc/samsung/exynos-regs-pmu.h

-- 
1.7.9.5
