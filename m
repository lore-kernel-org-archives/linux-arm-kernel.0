From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 6 Oct 2015 17:28:41 +0200
Subject: [GIT PULL] at91: cleanup for 4.4 #1
Message-ID: <20151006152841.GA17947@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

A few cross subsystem cleanups to soon be able to get rid of a nasty
hack in the clock driver. To ease synchronisation, I'm planning to send
the hack removal to for 4.5.

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-cleanup-4.4

for you to fetch changes up to 7d8d05d11473a169ab4d53bc7fc23d1fe3f1959f:

  misc: atmel_tclib: get and use slow clock (2015-10-06 12:33:14 +0200)

----------------------------------------------------------------
First batch of cleanups for 4.4:
 - properly get the slow clock from timer-atmel-st, tcb_clksrc and pwm-atmel-tcb
 - small fix in an error path for tcb_clksrc

----------------------------------------------------------------
Alexandre Belloni (1):
      clocksource: atmel-st: get and use slow clock

Boris Brezillon (2):
      clocksource: tcb_clksrc: fix setup_clkevents error path
      misc: atmel_tclib: get and use slow clock

 drivers/clocksource/tcb_clksrc.c     | 12 ++++++++++--
 drivers/clocksource/timer-atmel-st.c | 31 ++++++++++++++++++++++---------
 drivers/misc/atmel_tclib.c           |  4 ++++
 drivers/pwm/pwm-atmel-tcb.c          | 26 +++++++++++++++++++-------
 include/linux/atmel_tc.h             |  1 +
 5 files changed, 56 insertions(+), 18 deletions(-)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
