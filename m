From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 01 Aug 2014 04:00:31 +0900
Subject: [GIT PULL] Samsung 2nd cleanup for v3.17
Message-ID: <53DA924F.40201@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

One more pull-request. Sorry.

Thanks,
Kukjin

The following changes since commit f1ff47454bb2fe0d5644f981679d1bea532816fd:

   clk: samsung: s5pv210: Remove legacy board support (2014-07-19 
04:32:19 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-cleanup-2

for you to fetch changes up to 3f47c65f86e7f85871432f7e2f6b3698f7c86021:

   ARM: S5PV210: move <mach/regs-clock.h> into mach-s5pv210/ (2014-08-01 
03:22:04 +0900)

----------------------------------------------------------------
Samsung 2nd cleanup for v3.17

- since <mach/memory.h> in mach-exynos is not included
   long time so can remove it

- move <mach/regs-clock.h> into mach-s5pv210 and now
   no more header files in mach-s5pv210/include/mach

Note move <mach/regs-clock.h> in mach-s5pv210 depends on
previous tags/s5pv210-dt which supports s5pv210 DT.

----------------------------------------------------------------
Kukjin Kim (1):
       ARM: S5PV210: move <mach/regs-clock.h> into mach-s5pv210/

Uwe Kleine-Koenig (1):
       ARM: EXYNOS: remove unused <mach/memory.h>

  arch/arm/mach-exynos/include/mach/memory.h         | 26 
----------------------
  arch/arm/mach-s5pv210/pm.c                         |  3 +--
  .../mach-s5pv210/{include/mach => }/regs-clock.h   |  3 +--
  arch/arm/mach-s5pv210/s5pv210.c                    |  2 +-
  4 files changed, 3 insertions(+), 31 deletions(-)
  delete mode 100644 arch/arm/mach-exynos/include/mach/memory.h
  rename arch/arm/mach-s5pv210/{include/mach => }/regs-clock.h (99%)
