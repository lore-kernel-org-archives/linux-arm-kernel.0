From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 15 Nov 2018 16:11:29 +0100
Subject: [PATCH 0/9] ARM: SAMSUNG: add Exynos chipid driver
References: <CGME20181115151207epcas1p45adfa96d5b52e10fbb5ace76ebae5e3e@epcas1p4.samsung.com>
Message-ID: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset adds Exynos chipid driver and converts Exynos platform
code to use it. It is heavily based on "[PATCH v9 00/12] Introducing
Exynos ChipId driver" patchset [1] so most credits go to Pankaj Dubey.
The main difference in the current patchset is in taking simpler
approach to converting existing Exynos platform code to use the new
chipid driver. This results in much less code duplication.

The diffstat for "[PATCH v9 00/12] Introducing Exynos ChipId driver":

 14 files changed, 587 insertions(+), 255 deletions(-)

for the current patchset it is:

 14 files changed, 193 insertions(+), 195 deletions(-)

This patchset has been tested on Exynos4210 (including rev0),
Exynos3250, Exynos4412 & Exynos5422 SoCs.

[1] https://marc.info/?l=linux-arm-kernel&m=149087972213359&w=2

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (5):
  ARM: EXYNOS: use chipid driver
  ARM: EXYNOS: remove soc_is_exynos*() macros
  ARM: SAMSUNG: remove samsung_rev()
  ARM: SAMSUNG: remove s5p_init_cpu()
  ARM: EXYNOS: remove <mach/map.h> include

Pankaj Dubey (4):
  ARM: EXYNOS: remove secondary startup initialization from
    smp_prepare_cpus
  soc: samsung: add exynos chipid driver support
  ARM: EXYNOS: enable exynos_chipid for ARCH_EXYNOS
  ARM64: EXYNOS: enable exynos_chipid for ARCH_EXYNOS

 arch/arm/mach-exynos/Kconfig                 |   1 +
 arch/arm/mach-exynos/common.h                |  81 ++-----------------
 arch/arm/mach-exynos/exynos.c                |  75 ++++++++++--------
 arch/arm/mach-exynos/firmware.c              |   8 +-
 arch/arm/mach-exynos/include/mach/map.h      |  18 -----
 arch/arm/mach-exynos/platsmp.c               |  40 ++--------
 arch/arm/mach-exynos/pm.c                    |  25 +++---
 arch/arm/plat-samsung/cpu.c                  |  17 ----
 arch/arm/plat-samsung/include/plat/cpu.h     |   3 -
 arch/arm/plat-samsung/include/plat/map-s5p.h |   2 -
 arch/arm64/Kconfig.platforms                 |   1 +
 drivers/soc/samsung/Kconfig                  |   5 ++
 drivers/soc/samsung/Makefile                 |   1 +
 drivers/soc/samsung/exynos-chipid.c          | 111 +++++++++++++++++++++++++++
 14 files changed, 193 insertions(+), 195 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/include/mach/map.h
 create mode 100644 drivers/soc/samsung/exynos-chipid.c

-- 
1.9.1
