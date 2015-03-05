From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 5 Mar 2015 11:59:15 +0100
Subject: [GIT PULL] at91: fixes for 4.0 #2
Message-ID: <1425553155-30407-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Another batch of fixes that I have now, so it doesn't make sense to hold them
more.

Thanks, best regards,

The following changes since commit 2141102e045e622cac176891cb66c5bf08e439f5:

  ARM: at91/dt: keep watchdog running in idle mode (2015-03-04 11:20:52 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-fixes2

for you to fetch changes up to 5957457a2d96e4c9b2fecd40f29cdb3bb841d75e:

  ARM: at91/pm: MOR register KEY was missing (2015-03-05 11:43:02 +0100)

----------------------------------------------------------------
Second fixes batch for AT91 on 4.0:
- little fix for !MMU debug: may also help for randconfig
- fix of 2 errors in LCD clock definitions
- in PM code, not writing the key leads to not execute the action

----------------------------------------------------------------
Alexandre Belloni (1):
      ARM: at91: debug: fix non MMU debug

Boris BREZILLON (2):
      ARM: at91/dt: sama5d4: rename lcd_clk into lcdc_clk
      ARM: at91/dt: sama5d4: fix lcdck clock definition

Patrice Vilchez (1):
      ARM: at91/pm: MOR register KEY was missing

 arch/arm/boot/dts/sama5d4.dtsi    | 6 +++---
 arch/arm/include/debug/at91.S     | 5 ++++-
 arch/arm/mach-at91/pm_slowclock.S | 2 ++
 3 files changed, 9 insertions(+), 4 deletions(-)

-- 
Nicolas Ferre
