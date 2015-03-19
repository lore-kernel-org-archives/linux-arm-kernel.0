From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 19 Mar 2015 18:14:29 +0100
Subject: [GIT PULL] at91: multiplatform for 4.1 #1
Message-ID: <1426785269-6484-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

This is the real switch to multi-platform for AT91: after all the preparation
work that has been done, here we are! And there's also an additional cleanup on
top of that...
I stacked this material on top of my previous "at91-cleanup3" tag that I had sent
you earlier this week. As all my cleanup material is also on top of the fixes
tags (that you already have), these patches are also adapted to match this
state and avoid conflicts.
So, you can have this tag in your "multiplatform" branch separated, like I did,
or simply stacked on top or the AT91 cleanup material.

Thanks, best regards,

The following changes since commit 88c5544ab2240cf2a2dc87b5af9cd7990d06d028:

  Merge tag 'at91-cleanup3' into at91-4.1-multiplatform (2015-03-16 18:09:48 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-multiplatform

for you to fetch changes up to 1164f672d71ac103d85207b0453f3127c0efefb3:

  ARM: at91: drop AT91_TIMER_HZ (2015-03-19 16:37:45 +0100)

----------------------------------------------------------------
This is the multi-platform support for AT91:
- reworked arch/arm/mach-at91/Kconfig and arch/arm/Kconfig to switch to
  multi-platform
- updated at91_dt_defconfig
- continue the cleanup of unneeded files and code chunks

----------------------------------------------------------------
Alexandre Belloni (7):
      ARM: at91: switch to multiplatform
      ARM: at91: switch at91_dt_defconfig to multiplatform
      ARM: at91: remove unused headers
      ARM: at91: remove useless mach/cpu.h
      ARM: at91: remove SoC headers
      ARM: at91: remove hardware.h
      ARM: at91: drop AT91_TIMER_HZ

 arch/arm/Kconfig                               |  15 +-
 arch/arm/configs/at91_dt_defconfig             |   5 +-
 arch/arm/mach-at91/Kconfig                     | 117 +++++--------
 arch/arm/mach-at91/Makefile                    |   2 +
 arch/arm/mach-at91/include/mach/at91_dbgu.h    |  63 -------
 arch/arm/mach-at91/include/mach/at91rm9200.h   | 103 ------------
 arch/arm/mach-at91/include/mach/at91sam9260.h  | 129 ---------------
 arch/arm/mach-at91/include/mach/at91sam9261.h  |  99 -----------
 arch/arm/mach-at91/include/mach/at91sam9263.h  | 117 -------------
 arch/arm/mach-at91/include/mach/at91sam9_smc.h |   2 -
 arch/arm/mach-at91/include/mach/at91sam9g45.h  | 143 ----------------
 arch/arm/mach-at91/include/mach/at91sam9n12.h  |  65 --------
 arch/arm/mach-at91/include/mach/at91sam9rl.h   | 105 ------------
 arch/arm/mach-at91/include/mach/at91sam9x5.h   |  71 --------
 arch/arm/mach-at91/include/mach/cpu.h          | 216 ------------------------
 arch/arm/mach-at91/include/mach/hardware.h     | 134 ---------------
 arch/arm/mach-at91/include/mach/sama5d3.h      |  86 ----------
 arch/arm/mach-at91/include/mach/sama5d4.h      |  33 ----
 arch/arm/mach-at91/include/mach/uncompress.h   | 218 -------------------------
 arch/arm/mach-at91/pm.c                        |  12 +-
 arch/arm/mach-at91/pm_suspend.S                |   1 -
 arch/arm/mach-at91/sama5.c                     |   2 -
 22 files changed, 57 insertions(+), 1681 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/at91_dbgu.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91rm9200.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9260.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9261.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9263.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9g45.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9n12.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9rl.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9x5.h
 delete mode 100644 arch/arm/mach-at91/include/mach/cpu.h
 delete mode 100644 arch/arm/mach-at91/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-at91/include/mach/sama5d3.h
 delete mode 100644 arch/arm/mach-at91/include/mach/sama5d4.h
 delete mode 100644 arch/arm/mach-at91/include/mach/uncompress.h

-- 
Nicolas Ferre
