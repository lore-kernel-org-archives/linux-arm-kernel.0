From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Fri, 29 Mar 2013 22:40:15 +0530
Subject: [PATCH 0/2] ARM: OMAP2+: AM33xx: Add sysconf info to wdt1 hwmod data
Message-ID: <1364577017-22562-1-git-send-email-hvaibhav@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the recent submitted patch from Santosh Shilimkar,
"ARM: OMAP2+: hwmod: Don't call _init_mpu_rt_base if no sysc"
(commit: 4a98c2d89), kernel is crashing while accessing wdt1 module
without sysconf information, so add sysconf information to
the wdt1 hwmod data.

And also switch wdt1 parent clock to PRCM generated
32K clock-source during boot-time, as default On-Chip 32K RC Osc clock
is not an accurate by design.

Vaibhav Hiremath (2):
  ARM: OMAP2+: AM33xx: hwmod: Add missing sysc definition to wdt1 entry
  ARM: OMAP2+: am335x: Change the wdt1 func clk src to per_32k clk

 arch/arm/mach-omap2/cclock33xx_data.c      |    8 ++++++++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |   15 +++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)
