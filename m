From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 19 Sep 2011 19:30:37 +0200
Subject: [PATCH v3 0/4] ARM: Samsung: Add board setup for M-5MOLS and
	NOON010PC30 camera sensors
Message-ID: <1316453441-13525-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

the following change set adds board setup code for NOOON01PC30 sensor on GONI 
and M-5MOLS on UNIVERSAL_C210 board.
Some clocks are modified in line with latest FIMC driver modifications for v3.2.

Changes since previous version:
 - improved error handling, switched to gpio_request_array()
 - created against git://github.com/kgene/linux-samsung.git for-next

Sylwester Nawrocki (4):
  ARM: S5PV210: Rename sclk_cam clocks for FIMC media driver
  ARM: S5PV210: Add support for NOON010PC30 sensor on GONI board
  ARM: EXYNOS4: Rename sclk_cam clocks for FIMC driver
  ARM: S5PV210: UNIVERSAL_C210: Add support for M-5MOLS image sensor

 arch/arm/mach-exynos4/Kconfig               |    3 +
 arch/arm/mach-exynos4/clock.c               |    6 +-
 arch/arm/mach-exynos4/mach-universal_c210.c |  206 +++++++++++++++++++++++++-
 arch/arm/mach-s5pv210/Kconfig               |    1 +
 arch/arm/mach-s5pv210/clock.c               |    6 +-
 arch/arm/mach-s5pv210/mach-goni.c           |   53 +++++++
 6 files changed, 259 insertions(+), 16 deletions(-)
-- 
1.7.6.3

The patches can be pulled from git://git.infradead.org/users/kmpark/linux-2.6-samsung, 
branch samsung-board-camera.

Thanks,
--
Sylwester Nawrocki
Samsung Poland R&D Center
