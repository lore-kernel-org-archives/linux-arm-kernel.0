From: dinguyen@altera.com (dinguyen at altera.com)
Date: Mon, 7 Oct 2013 10:27:59 -0500
Subject: [GIT PULL]clocksource: dw_apb_timer_of: Fix read_sched_clock
Message-ID: <1381159679-6528-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Hi Thomas, John,

I am hoping you can pull in these 2 patches. These 2 patches have been floating
around for almost 2 months now. They are needed to get the Altera SOCFPGA
booting again because of a DTS binding change in 3.12.

The other change was correctly return the current clock counter.

The discussion thread can be found here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-September/198818.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-September/198903.html

This patch does not attempt or change the behaviour of the ordering of how a
clocksource or clockevent is use. These 2 patches only enables a platform to boot.

Thanks,
Dinh

The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  git://git.rocketboards.org/linux-socfpga-next.git tags/dw_apb_timer_fix_for_jstultz

for you to fetch changes up to c3c3e0d0fee2f4e1a9897094107dd8eae87503fb:

  clocksource: dw_apb_timer_of: Fix read_sched_clock (2013-10-07 09:57:15 -0500)

----------------------------------------------------------------
dw_apb_timer changes:
	- Move defines from dw_apb_timer.c to include/linux/dw_apb_timer.h
	- The dw_apb_timer implementation is a countdown timer. Fix the code
		to return the correct current counter.
	- Add backwards compatibilty for deprecated "snps,dw-apb-timer-osc"
		and "snps,dw-apb-timer-sp"
	- Add compatiblity for "snps,dw-apb-timer". This is the new binding
		to be used going forward.

----------------------------------------------------------------
Dinh Nguyen (2):
      clocksource: dw_apb_timer: Move timer defines to header file.
      clocksource: dw_apb_timer_of: Fix read_sched_clock

 drivers/clocksource/dw_apb_timer.c    |   19 -------------------
 drivers/clocksource/dw_apb_timer_of.c |    9 +++++----
 include/linux/dw_apb_timer.h          |   19 +++++++++++++++++++
 3 files changed, 24 insertions(+), 23 deletions(-)
