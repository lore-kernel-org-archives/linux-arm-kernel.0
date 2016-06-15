From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Tue, 14 Jun 2016 18:29:47 -0700
Subject: [PATCH v2 0/6] i.MX L2-cache code cleanups and performance tweaks
Message-ID: <1465954193-5894-1-git-send-email-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

Here's the second version of i.MX L2-cache related patches. Here's
what's new from v1:

 - Already existing, spelling error free (shame on me for not noticing
   that in previous version!), symbolic constant defintions are used

 - Increased scope of magic number replacement (additional instance in
   cache-l2x0.c)

 - Added patch to remove unnecessary bit clearing in cache-l2x0.c

 - Added patch to implement a cleanup as suggested by Arnd

 - Added patch to tweak prefetch settings to improve performance. I
   was originally going to post this patch separately. But now that
   there was a need for v2, I decided to include it in the series.

All the feedback is much appreciated.

Thank you,
Andrey Smirnov


Andrey Smirnov (6):
  i.MX: system.c: Convert goto to if statement
  i.MX: system.c: Remove redundant errata 752271 code
  i.MX: system.c: Replace magic numbers
  ARM: cache-l2x0: Do not clear bit 23 in prefetch control register
  i.MX: system.c: Tweak prefetch settings for performance
  i.MX: Do not explicitly call l2x0_of_init()

 arch/arm/include/asm/hardware/cache-l2x0.h |  1 +
 arch/arm/mach-imx/imx35-dt.c               | 10 +++----
 arch/arm/mach-imx/mach-imx6q.c             |  2 ++
 arch/arm/mach-imx/mach-imx6sl.c            |  2 ++
 arch/arm/mach-imx/mach-imx6sx.c            |  2 ++
 arch/arm/mach-imx/system.c                 | 42 ++++++++++++------------------
 arch/arm/mm/cache-l2x0.c                   |  5 ++--
 7 files changed, 28 insertions(+), 36 deletions(-)

-- 
2.5.5
