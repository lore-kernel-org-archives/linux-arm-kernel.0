From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Sun, 27 Nov 2011 04:32:26 +0100
Subject: [PATCH 0/5] ARM: OMAP1: Fix dpll1 reprogramming related issues
Message-ID: <1322364751-29980-1-git-send-email-jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After dpll1 reprogramming has been moved from setup_arch() to
kernel_init(), I've been observing several issues, resulting in
undesired system behaviour on my Amstrad Delta. This series fixes
those issues.

Janusz Krzysztofik (5):
  ARM: OMAP1: Fix dpll1 default rate reprogramming method
  ARM: OMAP1: Fix ckctl value used for dpll1 defualt rate
  ARM: OMAP1: Fix dpll1 reprogramming not actually allowed
  init/calibrate.c: allow for recalibration of loops per jiffy
  ARM: OMAP1: recalibrate loops per jiffy after dpll1 reprogram

 arch/arm/mach-omap1/clock.c      |   10 +---------
 arch/arm/mach-omap1/clock_data.c |    9 +++++++--
 arch/arm/plat-omap/sram.c        |    3 +++
 include/linux/delay.h            |    4 +++-
 init/calibrate.c                 |    6 ++++--
 5 files changed, 18 insertions(+), 14 deletions(-)

-- 
1.7.3.4
