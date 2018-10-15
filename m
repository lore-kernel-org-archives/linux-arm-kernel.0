From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 15 Oct 2018 14:31:06 +0200
Subject: [PATCH v2 0/6] Proper arch timer support for Exynos5433-based
 TM2(e) boards
References: <CGME20181015123134eucas1p1bdc005e0c46e9b1b7895bf2526ba1f2c@eucas1p1.samsung.com>
Message-ID: <20181015123112.9379-1-m.szyprowski@samsung.com>
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
  clocksource: exynos_mct: Add arch_timer cooperation mode for ARM64
  clocksource: Change CPU hotplug priority of exynos_mct driver
  arm64: dts: exynos: Move arch-timer node to right place
  arm64: platform: Add enable Exynos Multi-Core Timer driver

 arch/arm64/Kconfig.platforms               |  1 +
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 23 ++++----
 drivers/clocksource/exynos_mct.c           | 68 +++++++++++++++-------
 include/linux/cpuhotplug.h                 |  2 +-
 4 files changed, 61 insertions(+), 33 deletions(-)

-- 
2.17.1
