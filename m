From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Tue, 27 Sep 2011 16:22:41 -0400
Subject: [PATCH V2 0/3] S5P64X0 PM Support
Message-ID: <1317154964-22600-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patchset adds Power Mangement support for S5P64X0. The first
two patches lay the groundwork for adding PM support, while the
final patch adds the SoC specific PM code.

Changes since V1:
- Changed register naming as per User Manual.
- Dropped the pm-gpio warning patch as it will be taken care in the gpio
  movement patch by Kukjin Kim.
- Used soc_is_* for differentiating between 6440 and 6450.
- Merged all the sleep files of S5P SoCs while leaving the S3C64XX sleep
  code as is.

Abhilash Kesavan (3):
  ARM: S5P: Make the common S5P PM code conditionally compile
  ARM: S5P: Make the sleep code common for S5P series SoCs
  ARM: S5P64X0: Add Power Management support

 arch/arm/Kconfig                                |    2 +-
 arch/arm/mach-exynos4/Kconfig                   |    4 +
 arch/arm/mach-exynos4/Makefile                  |    2 +-
 arch/arm/mach-s5p64x0/Kconfig                   |    4 +
 arch/arm/mach-s5p64x0/Makefile                  |    1 +
 arch/arm/mach-s5p64x0/include/mach/map.h        |    1 +
 arch/arm/mach-s5p64x0/include/mach/pm-core.h    |  117 +++++++++++++
 arch/arm/mach-s5p64x0/include/mach/regs-clock.h |   33 ++++
 arch/arm/mach-s5p64x0/include/mach/regs-gpio.h  |   19 ++
 arch/arm/mach-s5p64x0/irq-eint.c                |    2 +
 arch/arm/mach-s5p64x0/irq-pm.c                  |   92 ++++++++++
 arch/arm/mach-s5p64x0/pm.c                      |  204 +++++++++++++++++++++++
 arch/arm/mach-s5pv210/Kconfig                   |    2 +
 arch/arm/mach-s5pv210/Makefile                  |    2 +-
 arch/arm/mach-s5pv210/sleep.S                   |   52 ------
 arch/arm/plat-s5p/Kconfig                       |   12 ++
 arch/arm/plat-s5p/Makefile                      |    4 +-
 arch/arm/{mach-exynos4 => plat-s5p}/sleep.S     |   13 +-
 18 files changed, 500 insertions(+), 66 deletions(-)
 create mode 100644 arch/arm/mach-s5p64x0/include/mach/pm-core.h
 create mode 100644 arch/arm/mach-s5p64x0/irq-pm.c
 create mode 100644 arch/arm/mach-s5p64x0/pm.c
 delete mode 100644 arch/arm/mach-s5pv210/sleep.S
 rename arch/arm/{mach-exynos4 => plat-s5p}/sleep.S (81%)
