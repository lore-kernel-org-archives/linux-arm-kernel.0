From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 21 May 2014 12:22:46 +0530
Subject: [PATCH 0/3] Exynos multi-platform support
Message-ID: <1400655169-21683-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patches in this series were earlier sent as part of other
series. Now that the other patches have been merged, re-sending
these after rebasing them on linux-next (20140519).
Tested on Exynos4210, 4412, 5250 and 5420 based boards.

A particular change in this series is the removal of single platform
support for Exynos as suggested by Arnd and Olof (patch 2/3). With
this change certain features (drivers) which are not yet multi-platform
aware like cpufreq, devfreq and DRM based gscaler will not be available
now.

Arnd Bergmann (1):
  ARM: EXYNOS: Enable multi-platform build support

Sachin Kamat (2):
  ARM: EXYNOS: Consolidate Kconfig entries
  ARM: multi_v7_defconfig: Enable Exynos platform

 arch/arm/Kconfig                    |   20 ----------
 arch/arm/configs/multi_v7_defconfig |   12 ++++++
 arch/arm/mach-exynos/Kconfig        |   73 +++++++++++++++--------------------
 arch/arm/mach-exynos/Makefile       |    2 +
 arch/arm/plat-samsung/Makefile      |    3 ++
 5 files changed, 49 insertions(+), 61 deletions(-)

-- 
1.7.9.5
