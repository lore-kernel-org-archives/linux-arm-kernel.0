From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 17 Oct 2018 15:41:53 +0200
Subject: [PATCH v3 0/6] Proper arch timer support for Exynos5433-based
 TM2(e) boards
References: <CGME20181017134204eucas1p10d92a91f2b945afdc7b39ce6e7813a8e@eucas1p1.samsung.com>
Message-ID: <20181017134159.9656-1-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear All,

This patchset is an attempt to submit the last piece of missing code
to have proper support for Exynos5433 SoCs based TM2(e) boards. It
performs a cleanup of timer configuration, which so far needed various
out-of-tree workarounds. The fixes provided by this patchset are also
needed for add proper support for system suspend/resume.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Changelog:

v3:
- added patch, which splits resources and interrupts allocation
- simplified arch timer cooperation mode
- dropped CPU hotplug priority change patch, it is not really needed
- removed more non-dt dead code

v2:
- dropped arch timer patch, it will be discussed separately
- fixed issues pointed by Krzysztof Kozlowski

v1: https://patchwork.kernel.org/project/linux-samsung-soc/list/?series=27965&state=*&archive=both
- initial version


Patch summary:

Marek Szyprowski (6):
  clocksource: exynos_mct: Remove dead code
  clocksource: exynos_mct: Fix error path in timer resources
    initialization
  clocksource: exynos_mct: Refactor resources allocation
  clocksource: exynos_mct: Add arch_timer cooperation mode for ARM64
  arm64: dts: exynos: Move arch-timer node to right place
  arm64: platform: Add enable Exynos Multi-Core Timer driver

 arch/arm64/Kconfig.platforms               |  1 +
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 23 +++---
 drivers/clocksource/exynos_mct.c           | 81 ++++++++++++++--------
 3 files changed, 67 insertions(+), 38 deletions(-)

-- 
2.17.1
