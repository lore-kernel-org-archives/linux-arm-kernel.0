From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Sun, 5 Apr 2015 22:17:23 +0200
Subject: [GIT PULL] at91: cleanup for 4.1 #4 (bis)
In-Reply-To: <20150403180556.GK23023@localhost>
References: <20150403180556.GK23023@localhost>
Message-ID: <1428265043-10366-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

This is a re-spin of my 4th "cleanup" pull-request following the comments made
by Olof.  So, now these patches about PM are based on the "at91-cleanup2" that
you would merge in your next/cleanup branch.

I'm preparing another pull-request for the other patch that would stack on our
at91/clocksource-driver branch.

Thanks for your advice, bye.

The following changes since commit 598e085590fc5ac1fecff00e842a8a6c2ae010e5:

  ARM: at91: remove old setup (2015-03-13 18:01:10 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-cleanup4_bis

for you to fetch changes up to 2e57dc087c27b8b0bd4a9e5f2c6f28f3cd0b47ff:

  ARM: at91/pm: move AT91_MEMCTRL_* to pm.h (2015-04-05 21:59:52 +0200)

----------------------------------------------------------------
Fourth batch of cleanup for 4.1:
- 1 issues revealed by the kbuild test robot fixed
- move of some functions and macros into relevant files to be able to
  streamline the at91 specific header afterwards

----------------------------------------------------------------
Alexandre Belloni (3):
      ARM: at91: fix pm_suspend.S compilation when ARMv6 is selected
      ARM: at91/pm: move the standby functions to pm.c
      ARM: at91/pm: move AT91_MEMCTRL_* to pm.h

 arch/arm/mach-at91/Makefile                 |  3 +
 arch/arm/mach-at91/include/mach/at91_ramc.h |  4 --
 arch/arm/mach-at91/pm.c                     | 89 ++++++++++++++++++++++++++
 arch/arm/mach-at91/pm.h                     | 96 ++---------------------------
 4 files changed, 96 insertions(+), 96 deletions(-)

-- 
Nicolas Ferre
