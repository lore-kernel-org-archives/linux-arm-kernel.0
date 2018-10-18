From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 18 Oct 2018 11:57:02 +0200
Subject: [PATCH v4 0/6] Proper arch timer support for Exynos5433-based
 TM2(e) boards
References: <CGME20181018095714eucas1p2019a898487b589ff402b70fae42cabaa@eucas1p2.samsung.com>
Message-ID: <20181018095708.1527-1-m.szyprowski@samsung.com>
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

v4:
- fixes lack of fixup in patch #3, pointed by Krzysztof Kozlowski

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
