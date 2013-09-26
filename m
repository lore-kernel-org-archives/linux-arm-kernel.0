From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 26 Sep 2013 02:37:38 +0200
Subject: [GIT PULL 3.12-rc2 fixes] clocksource: Several fixes for 3.12-rc2
Message-ID: <524381D2.7050604@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

this pull request contains several fixes for the clocksource/clockevent
drivers:

 - Jean Pihet fixed a missing Kconfig option preventing the Armada370/XP
to boot up.

 - Magnus Damm fixed the cpumask on the em_sti driver to have the
broadcast timer working on a SMP system

 - Sebastian Hesselbarth skipped the initialization of a timer for
uninitialized DT nodes

 - Tomasz Figa fixed the irq affinity failing on non online cpus

Thanks
  -- Daniel

-----------------------------------------------------------------------------

The following changes since commit 4a10c2ac2f368583138b774ca41fac4207911983:

  Linux 3.12-rc2 (2013-09-23 15:41:09 -0700)

are available in the git repository at:


ssh://daniel.lezcano at git.linaro.org//srv/git.linaro.org/git/people/dlezcano/linux.git
clockevents/3.12-rc2-fixes

for you to fetch changes up to 2199a5574b6d94b9ca26c6345356f45ec60fef8b:

  clocksource: em_sti: Set cpu_possible_mask to fix SMP broadcast
(2013-09-26 02:31:04 +0200)

----------------------------------------------------------------
Jean Pihet (1):
      arm: clocksource: mvebu: Use the main timer as clock source from DT

Magnus Damm (1):
      clocksource: em_sti: Set cpu_possible_mask to fix SMP broadcast

Sebastian Hesselbarth (1):
      clocksource: of: Respect device tree node status

Tomasz Figa (1):
      clocksource: exynos_mct: Set IRQ affinity when the CPU goes online

 drivers/clocksource/Kconfig      |    1 +
 drivers/clocksource/clksrc-of.c  |    3 +++
 drivers/clocksource/em_sti.c     |    2 +-
 drivers/clocksource/exynos_mct.c |   10 +++++++++-
 4 files changed, 14 insertions(+), 2 deletions(-)

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
