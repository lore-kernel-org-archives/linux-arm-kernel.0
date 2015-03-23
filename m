From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 23 Mar 2015 12:04:11 +0100
Subject: [GIT PULL] at91: cleanup for 4.1 #4
Message-ID: <1427108651-566-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Another cleanup pull-request for fixing some issues and stacking more PM
cleanup.
It is based on the previous "at91-cleanup3" tag sent last week (not inclueded
yet).

Thanks, best regards,

The following changes since commit 8590ca655a19f9e124b52bfbf28f14eb16a05bec:

  ARM: at91: remove useless include (2015-03-16 17:03:08 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-cleanup4

for you to fetch changes up to dd905bbb09383f9f62d7a6296f11788d8c283c86:

  ARM: at91/pm: move AT91_MEMCTRL_* to pm.h (2015-03-23 11:16:00 +0100)

----------------------------------------------------------------
Fourth batch of cleanup for 4.1:
- 2 issues revealed by the kbuild test robot fixed
- move of some functions and macros into relevant files to be able to
  streamline the at91 specific header afterwards

----------------------------------------------------------------
Alexandre Belloni (4):
      ARM: at91: fix pm_suspend.S compilation when ARMv6 is selected
      clocksource: atmel-st: select MFD_SYSCON
      ARM: at91/pm: move the standby functions to pm.c
      ARM: at91/pm: move AT91_MEMCTRL_* to pm.h

 arch/arm/mach-at91/Makefile                 |  3 +
 arch/arm/mach-at91/include/mach/at91_ramc.h |  4 --
 arch/arm/mach-at91/pm.c                     | 89 ++++++++++++++++++++++++++
 arch/arm/mach-at91/pm.h                     | 96 ++---------------------------
 drivers/clocksource/Kconfig                 |  1 +
 5 files changed, 97 insertions(+), 96 deletions(-)

-- 
Nicolas Ferre
