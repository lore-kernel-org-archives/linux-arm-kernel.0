From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 15 Apr 2014 19:34:27 +0200
Subject: [PATCH 0/5] Exynos4 SoC camera subsystem driver cleanups
Message-ID: <1397583272-28295-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series removes support for non-dt platforms from the
Exynos4/S5P SoC camera interface drivers and removes (ab)use
of "simple-bus" compatible string.

Sylwester Nawrocki (5):
  ARM: S5PV210: Remove camera support from mach-goni.c
  exynos4-is: Fix compilation for !CONFIG_COMMON_CLK
  exynos4-is: Remove support for non-dt platforms
  exynos4-is: Remove requirement for "simple-bus" compatible
  ARM: dts: exynos4: Remove simple-bus compatible from camera subsystem
    nodes

 .../devicetree/bindings/media/samsung-fimc.txt     |    6 +-
 Documentation/video4linux/fimc.txt                 |   30 --
 MAINTAINERS                                        |    1 -
 arch/arm/boot/dts/exynos4.dtsi                     |    2 +-
 arch/arm/boot/dts/exynos4x12.dtsi                  |    2 +-
 arch/arm/mach-s5pv210/mach-goni.c                  |   51 ---
 drivers/media/platform/exynos4-is/Kconfig          |    3 +-
 drivers/media/platform/exynos4-is/common.c         |   49 ++-
 drivers/media/platform/exynos4-is/common.h         |    6 +-
 drivers/media/platform/exynos4-is/fimc-core.h      |    2 +-
 drivers/media/platform/exynos4-is/fimc-is.c        |   12 +-
 drivers/media/platform/exynos4-is/fimc-isp-video.c |    2 +-
 drivers/media/platform/exynos4-is/fimc-isp.h       |    2 +-
 drivers/media/platform/exynos4-is/fimc-lite-reg.c  |    2 +-
 drivers/media/platform/exynos4-is/fimc-lite.c      |    2 +-
 drivers/media/platform/exynos4-is/fimc-lite.h      |    2 +-
 drivers/media/platform/exynos4-is/fimc-reg.c       |    2 +-
 drivers/media/platform/exynos4-is/media-dev.c      |  356 +++-----------------
 drivers/media/platform/exynos4-is/media-dev.h      |    2 +-
 drivers/media/platform/exynos4-is/mipi-csis.c      |   43 +--
 include/linux/platform_data/mipi-csis.h            |   28 --
 include/media/{s5p_fimc.h => exynos-fimc.h}        |   21 --
 22 files changed, 138 insertions(+), 488 deletions(-)
 delete mode 100644 include/linux/platform_data/mipi-csis.h
 rename include/media/{s5p_fimc.h => exynos-fimc.h} (87%)

--
1.7.9.5
