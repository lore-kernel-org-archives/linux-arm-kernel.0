From: khilman@linaro.org (Kevin Hilman)
Date: Wed,  3 Jul 2013 11:36:38 -0700
Subject: [PATCH 0/3] nohz/full: final Kconfig bits for ARM support
Message-ID: <1372876601-23881-1-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of v3.10, the core ARM support is in mainline for NO_HZ_FULL.  The
only remaining part is the removal of the hard-coded Kconfig
requirement on 64-bit platforms, which I believe can now be removed
after the nsec granularity cputime was made to work on non 64_BIT
(c.f. commit 8c23b80e, cputime_nsecs: use math64.h for nsec
resolution conversion helpers.)

This series makes the final Kconfig changes to bring NO_HZ_FULL
support to ARM.

Series applies to v3.10.

I will queue up the arch/arm patch for Russell separately once the
generic changes are accepted.

Kevin

 arch/arm/Kconfig    | 1 +
 init/Kconfig        | 2 +-
 kernel/time/Kconfig | 2 --
 3 files changed, 2 insertions(+), 3 deletions(-)

-- 
1.8.3
