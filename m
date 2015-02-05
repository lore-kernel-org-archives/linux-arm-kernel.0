From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 5 Feb 2015 13:59:36 +0800
Subject: [PATCH 0/3] at91-3.19: pm fixes
Message-ID: <1423115977-5852-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

The patch serial is to fix the pm issue.

It is based on the branch: at91-3.19-fixes
git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git

Peter Rosin (1):
  pm: at91: Workaround DDRSDRC self-refresh bug with LPDDR1 memories.

Sylvain Rochet (2):
  pm: at91: pm_slowclock: fix suspend/resume hang up in timeouts
  pm: at91: pm_slowclock: remove clocks which are already stopped when
    entering slow clock mode

 arch/arm/mach-at91/pm.c            |   12 +++++
 arch/arm/mach-at91/pm_slowclock.S  |  105 ++++++++++++++----------------------
 include/soc/at91/at91sam9_ddrsdr.h |    2 +-
 3 files changed, 54 insertions(+), 65 deletions(-)

-- 
1.7.9.5

Best Regards,
Wenyou Yang
