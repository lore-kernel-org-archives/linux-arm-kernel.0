From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Jan 2013 16:34:31 +0100
Subject: [GIT PULL] ux500 cpufreq and clksrc updates
Message-ID: <CACRpkda7zAD0yFD8LT7K-F9HhEmJPOfcQ9fA35h=Yp8ThMyP9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

here is a pile of patches which pertain to the ux500 cpufreq and clksrc
implementations. I have agreed with respective subsystem maintainer
to take this through ARM SoC since I also have additional dependencies
on top for multiplatform, which will likely build on top of these (but it's
nice to get this in first).

The clksrc and cpufreq changes are dependent on merge order and
thus cannot pass through different trees.

All of this is to be queued for-next (v3.9).

Please pull it in!

Yours,
Linus Walleij


The following changes since commit d1c3ed669a2d452cacfb48c2d171a1f364dae2ed:

  Linux 3.8-rc2 (2013-01-02 18:13:21 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-cpufreq-for-arm-soc

for you to fetch changes up to ec6691239373395d64fb73f50444f09a6f29d5ef:

  cpufreq: db8500: set CPUFREQ_CONST_LOOPS (2013-01-07 16:03:43 +0100)

----------------------------------------------------------------
These are cpufreq updates for the ux500
- Updates to the ux500 cpufreq driver
- Support for delay timers in the MTU clksrc
- Consequential updates to the cpufreq driver

----------------------------------------------------------------
Fabio Baltieri (2):
      clocksource: nomadik-mtu: support timer-based delay
      cpufreq: db8500: set CPUFREQ_CONST_LOOPS

Jonas Aaberg (1):
      cpufreq: dbx500: Minor code cleanup

Lee Jones (3):
      cpufreq: Give driver used for dbx500 family a more generic name
      mfd: db8500: Update cpufreq device name
      cpufreq: dbx500: Update file header

Ulf Hansson (1):
      cpufreq: dbx500: Move clk_get to probe

 drivers/clocksource/nomadik-mtu.c                  |  11 +++
 drivers/cpufreq/Makefile                           |   2 +-
 .../cpufreq/{db8500-cpufreq.c => dbx500-cpufreq.c} | 101 +++++++++++----------
 drivers/mfd/db8500-prcmu.c                         |   4 +-
 4 files changed, 65 insertions(+), 53 deletions(-)
 rename drivers/cpufreq/{db8500-cpufreq.c => dbx500-cpufreq.c} (62%)
