From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 15 Nov 2013 12:24:25 +0100
Subject: [GIT PULL] at91: non-critical fixes for 3.13 #1
Message-ID: <1384514665-32174-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

This is a pull-request for AT91 about non-critical fixes for 3.13. This means
that you can certainly plan it for early 3.14.
It is not a 3.13 regression as this issue has been present for ages. I have
tagged the patch for "-stable" down to 3.11.y as they need modification to
apply on older kernels.

Thanks, best regards,

The following changes since commit 15c03dd4859ab16f9212238f29dd315654aa94f6:

  Linux 3.12-rc3 (2013-09-29 15:02:38 -0700)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-fixes-non-critical

for you to fetch changes up to 94c4c79f2f1acca6e69a50bff5a7d9027509c16b:

  ARM: at91: fix hanged boot due to early rtt-interrupt (2013-11-15 12:13:33 +0100)

----------------------------------------------------------------
Fixes for RTT & RTC interrupts that can fire early
during boot process and kill the system.
This fix has been discussed for months and it is time
for it to reach mainline.

----------------------------------------------------------------
Johan Hovold (2):
      ARM: at91: fix hanged boot due to early rtc-interrupt
      ARM: at91: fix hanged boot due to early rtt-interrupt

 arch/arm/mach-at91/Makefile                   |  2 +-
 arch/arm/mach-at91/at91sam9260.c              |  2 +
 arch/arm/mach-at91/at91sam9261.c              |  2 +
 arch/arm/mach-at91/at91sam9263.c              |  3 ++
 arch/arm/mach-at91/at91sam9g45.c              |  3 ++
 arch/arm/mach-at91/at91sam9n12.c              |  6 +++
 arch/arm/mach-at91/at91sam9rl.c               |  3 ++
 arch/arm/mach-at91/at91sam9x5.c               |  6 +++
 arch/arm/mach-at91/generic.h                  |  2 +
 arch/arm/mach-at91/include/mach/at91sam9n12.h |  5 ++
 arch/arm/mach-at91/include/mach/at91sam9x5.h  |  5 ++
 arch/arm/mach-at91/include/mach/sama5d3.h     |  5 ++
 arch/arm/mach-at91/sama5d3.c                  |  6 +++
 arch/arm/mach-at91/sysirq_mask.c              | 71 +++++++++++++++++++++++++++
 14 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-at91/sysirq_mask.c

-- 
Nicolas Ferre
