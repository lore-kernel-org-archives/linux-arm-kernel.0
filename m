From: l.krishna@samsung.com (Leela Krishna Amudala)
Date: Wed, 11 Jul 2012 15:12:14 +0530
Subject: [PATCH 0/7] Add device tree based discovery support for drm-fimd
Message-ID: <1341999741-15578-1-git-send-email-l.krishna@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leela Krishna <l.krishna@samsung.com>

The patches are created against "for-next" branch of Kukjin Kim's tree at:
 git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git

This patch set adds Backlight, LCD support and device tree based discovery 
support for drm-fimd

Leela Krishna (3):
  ARM: EXYNOS5: add device tree based discovery support for FIMD
  ARM: EXYNOS5: Add the bus clock for FIMD
  ARM: EXYNOS5: Set parent clock to fimd

Leela Krishna Amudala (4):
  ARM: SAMSUNG: add additional registers and SFR definitions for
    writeback
  ARM: EXYNOS5: add machine specific support for backlight
  ARM: EXYNOS5: add machine specific support for LCD
  ARM: EXYNOS: Adding DRM platform device

 arch/arm/boot/dts/exynos5250-smdk5250.dts       |   16 +++
 arch/arm/boot/dts/exynos5250.dtsi               |    7 ++
 arch/arm/mach-exynos/Kconfig                    |    1 +
 arch/arm/mach-exynos/clock-exynos5.c            |   30 ++++--
 arch/arm/mach-exynos/include/mach/map.h         |    1 +
 arch/arm/mach-exynos/mach-exynos5-dt.c          |  125 +++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/clock.h      |    2 +
 arch/arm/plat-samsung/include/plat/regs-fb-v4.h |   10 ++
 arch/arm/plat-samsung/include/plat/regs-fb.h    |   51 +++++++++
 drivers/video/Kconfig                           |    6 +
 10 files changed, 239 insertions(+), 10 deletions(-)
