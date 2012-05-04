From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri,  4 May 2012 19:18:39 +0200
Subject: [PATCH 0/2] ARM: OMAP3/4: cpuidle - misc fixes
Message-ID: <1336151921-9485-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two patches are coming from the series I previously
sent for the cpuidle OMAP3/4 cleanups.

The first one, move the powerdomain lookup check in the init
function, the second one fix the linkage error, when the
CONFIG_PM is not set while CONFIG_CPU_IDLE is. Omap's Kconfig
has been modified to select CONFIG_PM when CONFIG_CPU_IDLE is
set.

I compiled with different options but I was not able to boot
my board because the kernel panics for another reason.

Daniel Lezcano (2):
  ARM: OMAP3: cpuidle - check the powerdomain lookup
  ARM: OMAP3/4: consolidate cpuidle Makefile

 arch/arm/mach-omap2/Kconfig       |    2 ++
 arch/arm/mach-omap2/Makefile      |   11 +++++++----
 arch/arm/mach-omap2/cpuidle34xx.c |   11 +++--------
 arch/arm/mach-omap2/cpuidle44xx.c |    8 --------
 arch/arm/mach-omap2/pm.h          |   17 +++++++++++++++--
 5 files changed, 27 insertions(+), 22 deletions(-)

-- 
1.7.5.4
