From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 25 Aug 2014 16:30:21 +0900
Subject: [PATCHv4 0/4] thermal: exynos: Add support for TRIMINFO feature of
 Exynos3250
Message-ID: <1408951825-2639-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset add the support of TRIMINFO_RELOAD feature for Exynos3250.
But Exynos3250 has two TRIMINFO_CTRL register instead other Exynos has only one
TRIMINFO_CTRL register. So, this patchset support the some Exynos SoC which
has more than one TRIMINF_CTRL.

Also, this patchset fix wrong value of TRIMINFO_RELOAD_SHIFT and remove
duplicate code when reading triminfo register of Exynos5440.

Changes from v3:
- Add reviewed message of Amit Daniel Kachhap <amit.daniel@samsung.com>
- Split RELOAD patch as two patch
- Fix 'TRIMINFO_RELOAD_SHIFT' value
- This series includes separate patch[1]
  [1] https://lkml.org/lkml/2014/8/20/5
- Drop ACTIME bit setting because TRM includes not enough information of ACTIME bit.

Changes from v2:
- Fix build break because of missing 'or' operation.

Changes from v1:
- Add missing 'TMU_SUPPORT_TRIM_RELOAD' features

Chanwoo Choi (4):
  thermal: exynos: Fix wrong value of TRIMINFO_RELOAD_SHIFT
  thermal: exynos: Add support for many TRIMINFO_CTRL registers
  thermal: exynos: Add support for TRIM_RELOAD feature at Exynos3250
  thermal: exynos: Remove duplicate code when reading triminfo register
    of Exynos5440

 drivers/thermal/samsung/exynos_thermal_common.h |  1 +
 drivers/thermal/samsung/exynos_tmu.c            | 27 +++++++++++++++++++------
 drivers/thermal/samsung/exynos_tmu.h            |  9 +++++++--
 drivers/thermal/samsung/exynos_tmu_data.c       | 14 +++++++++++--
 drivers/thermal/samsung/exynos_tmu_data.h       | 12 ++++++++---
 5 files changed, 50 insertions(+), 13 deletions(-)

-- 
1.8.0
