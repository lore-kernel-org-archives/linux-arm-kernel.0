From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 Aug 2017 16:01:19 -0700
Subject: [PATCH 0/3] omap5 cpu off mode support
Message-ID: <20170817230122.30655-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are few patches to enable omap5 cpu off mode similar to
what we do for omap4. This seems to save about 0.2W power on
omap5-uevm while idle compared to retention idle.

Note that this won't work for dra7 as it does not support
deeper idle modes.

Regards,

Tony

clone of "next-bak-2017-07-17-20170717-001945"

Santosh Shilimkar (1):
  ARM: OMAP5: Add cpuidle assembly code

Tony Lindgren (2):
  ARM: OMAP2+: Separate dra7 cpuidle from omap5
  ARM: OMAP5: Enable CPU off idle states

 arch/arm/mach-omap2/common.h                |  11 +++
 arch/arm/mach-omap2/cpuidle44xx.c           |  56 ++++++++++++
 arch/arm/mach-omap2/omap-mpuss-lowpower.c   |   8 +-
 arch/arm/mach-omap2/omap-secure.h           |   6 ++
 arch/arm/mach-omap2/omap-wakeupgen.c        |   5 +-
 arch/arm/mach-omap2/pm44xx.c                |   2 +-
 arch/arm/mach-omap2/powerdomains54xx_data.c |  10 +-
 arch/arm/mach-omap2/sleep44xx.S             | 137 ++++++++++++++++++++++++++++
 8 files changed, 226 insertions(+), 9 deletions(-)

-- 
2.14.1
