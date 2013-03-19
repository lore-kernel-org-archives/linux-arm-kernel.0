From: dianders@chromium.org (Doug Anderson)
Date: Tue, 19 Mar 2013 09:51:38 -0700
Subject: [PATCH 0/2] These two patches to s3c_pm_arch_prepare_irqs() were part
 of the work
Message-ID: <1363711900-25560-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

to make suspend/resume reliable on the ARM Chromebook
(exynos5250-snow).

A few more details:
- The first patch is not strictly needed but was a nice cleanup.  Our
  understanding was that EINT0 was originally turned on for exynos
  evt0 silicon and not needed for evt1.
- The second patch is more important and (also) more obvious.  The
  function was modifying the S5P_WAKEUP_MASK register and then
  clobbering its own modifications.

For some history, see:
- https://gerrit.chromium.org/gerrit/31337
- https://gerrit.chromium.org/gerrit/31341


Jonathan Kliegman (2):
  arm: exynos: Remove hardcode wakeup unmask for EINT_0
  arm: exynos: Clear ENABLE_WAKEUP_SW bit when entering suspend

 arch/arm/mach-exynos/include/mach/pm-core.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

-- 
1.8.1.3
