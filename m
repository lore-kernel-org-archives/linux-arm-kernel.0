From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 11 Aug 2011 15:58:37 +0900
Subject: [GIT PULL] samsung: fixes for v3.1-rc1
Message-ID: <20110811065837.GA4989@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 322a8b034003c0d46d39af85bf24fee27b902f48:

  Linux 3.1-rc1 (2011-08-07 18:23:30 -0700)

are available in the git repository at:
  git://git.infradead.org/users/kmpark/linux-2.6-samsung for-arnd

Kyungmin Park (2):
      ARM: exynos4: universal: Use the correct regulator names
      ARM: exynos4: Use nr_irqs instead of NR_IRQS

Marek Szyprowski (5):
      ARM: Exynos4: add required chained_irq_enter/exit to eint code
      ARM: Samsung: Add chained enrty/exit call to timer interrupt handler
      ARM: S5P: add required chained_irq_enter/exit to gpio-int code
      ARM: Exynos4: use s5p-timer for UniversalC210 board
      ARM: Samsung: fix watchdog reset issue with clk_get()

Sylwester Nawrocki (1):
      ARM: EXYNOS4: Fix the IRQ definitions for MIPI CSIS device

 arch/arm/mach-exynos4/Kconfig                      |    3 +++
 arch/arm/mach-exynos4/clock.c                      |    1 +
 arch/arm/mach-exynos4/include/mach/irqs.h          |    5 ++---
 arch/arm/mach-exynos4/irq-combiner.c               |    2 +-
 arch/arm/mach-exynos4/irq-eint.c                   |    7 +++++++
 arch/arm/mach-exynos4/mach-universal_c210.c        |    8 +++++---
 arch/arm/mach-s3c2412/clock.c                      |    1 +
 arch/arm/mach-s3c2416/clock.c                      |    2 +-
 arch/arm/mach-s3c2443/clock.c                      |    1 +
 arch/arm/mach-s3c64xx/clock.c                      |    1 +
 arch/arm/mach-s5p64x0/cpu.c                        |    2 ++
 arch/arm/mach-s5pc100/clock.c                      |    1 +
 arch/arm/mach-s5pv210/clock.c                      |    1 +
 arch/arm/plat-s3c24xx/s3c2410-clock.c              |    1 +
 arch/arm/plat-s5p/irq-gpioint.c                    |    6 ++++++
 arch/arm/plat-samsung/clock.c                      |    9 +++++++++
 arch/arm/plat-samsung/include/plat/clock.h         |    2 ++
 .../arm/plat-samsung/include/plat/watchdog-reset.h |   10 +++-------
 arch/arm/plat-samsung/irq-vic-timer.c              |    5 +++++
 19 files changed, 53 insertions(+), 15 deletions(-)
