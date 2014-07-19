From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 19 Jul 2014 09:52:52 +0900
Subject: [GIT PULL 4/5] Samsung exynos_mct update for v3.17
Message-ID: <53C9C164.9030404@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Note that this is also based on 3.16-rc5 because of dependency with 
previous samsung fixes including exynos_mct already merged in mainline 
during -rc.

The following changes since commit 1795cd9b3a91d4b5473c97f491d63892442212ab:

   Linux 3.16-rc5 (2014-07-13 14:04:33 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/exynos-mct

for you to fetch changes up to 1a631118c1d085fe162f3b6d44f710c72206ef2d:

   clocksource: exynos_mct: Only use 32-bits where possible (2014-07-19 
03:07:52 +0900)

----------------------------------------------------------------
exynos_mct update for v3.17
- only use 32-bit access for performance benefits on exynos
   32-bit system and this means ARCH timer should be supported
   on exynos 64-bit system instead of current MCT.
- use readl_relaxed/writel_relaxed to consistently use the
   proper functions in exynos_mct.

----------------------------------------------------------------
Doug Anderson (2):
       clocksource: exynos_mct: use readl_relaxed/writel_relaxed
       clocksource: exynos_mct: Only use 32-bits where possible

  drivers/clocksource/Kconfig      |  1 +
  drivers/clocksource/exynos_mct.c | 63 
++++++++++++++++++++++++++++------------
  2 files changed, 45 insertions(+), 19 deletions(-)
