From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 08 Oct 2018 14:50:02 +0200
Subject: [PATCH 0/7] Proper arch timer support for Exynos5433-based TM2(e)
 boards
References: <CGME20181008125045eucas1p12e1d77f5f605556d4cf6c3b87832fae3@eucas1p1.samsung.com>
Message-ID: <20181008125009.3721-1-m.szyprowski@samsung.com>
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


Patch summary:

Marek Szyprowski (7):
  clocksource: exynos_mct: Remove dead code
  clocksource: exynos_mct: Add arch_timer cooperation mode for ARM64
  clocksource: Change CPU hotplug priority of exynos_mct driver
  clocksource: arch_timer: Add support for not-fw-configured timer on
    ARM64
  arm64: dts: exynos: Move arch-timer node to right place
  arm64: dts: exynos: Mark arch_timer device as not-fw-configured on
    TM2(e)
  arm64: platform: Add enable Exynos Multi-Core Timer driver

 arch/arm64/Kconfig.platforms                  |  1 +
 .../dts/exynos/exynos5433-tm2-common.dtsi     |  1 +
 arch/arm64/boot/dts/exynos/exynos5433.dtsi    | 23 ++++++-------
 drivers/clocksource/Kconfig                   | 11 +++++++
 drivers/clocksource/arm_arch_timer.c          | 15 +++++++--
 drivers/clocksource/exynos_mct.c              | 32 +++++++++++++------
 include/linux/cpuhotplug.h                    |  2 +-
 7 files changed, 60 insertions(+), 25 deletions(-)

-- 
2.17.1
