From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 12 Jan 2013 19:50:03 +0800
Subject: [PATCH v2 0/3] Use helper clockevents_config_and_register()
Message-ID: <1357991406-22778-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clockevent core is able to figure out the best mult and shift,
calculate min_delta_ns and max_delta_ns, with the necessary info passed
into clockevents_config_and_register().  Use this handy helper to make
the drivers less error prone and save some LOC.

Changes since v1:
 - Add one patch to export clockevents_config_and_register for fixing
   the error [1] reported by Fengguang.
 - Add Acked-by and Tested-by tags given by people (Thanks!)

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/209152

Shawn Guo (3):
  clockevents: export clockevents_config_and_register for module use
  ARM: use clockevents_config_and_register() where possible
  clocksource: use clockevents_config_and_register() where possible

 arch/arm/mach-at91/at91rm9200_time.c     |    7 ++-----
 arch/arm/mach-cns3xxx/core.c             |   13 +++----------
 arch/arm/mach-exynos/mct.c               |   18 ++++--------------
 arch/arm/mach-footbridge/dc21285-timer.c |    6 +-----
 arch/arm/mach-imx/epit.c                 |   15 +++------------
 arch/arm/mach-imx/time.c                 |   15 +++------------
 arch/arm/mach-ixp4xx/common.c            |   11 ++---------
 arch/arm/mach-lpc32xx/timer.c            |    9 +--------
 arch/arm/mach-mmp/time.c                 |    7 ++-----
 arch/arm/mach-msm/timer.c                |    6 +-----
 arch/arm/mach-mxs/timer.c                |   24 +++++-------------------
 arch/arm/mach-netx/time.c                |   10 ++--------
 arch/arm/mach-omap1/time.c               |   11 ++---------
 arch/arm/mach-omap1/timer32k.c           |   12 ++----------
 arch/arm/mach-omap2/timer.c              |   13 +++----------
 arch/arm/mach-prima2/timer.c             |   10 ++--------
 arch/arm/mach-pxa/time.c                 |    8 ++------
 arch/arm/mach-sa1100/time.c              |    8 ++------
 arch/arm/mach-tegra/timer.c              |    8 ++------
 arch/arm/mach-vt8500/timer.c             |    9 ++-------
 arch/arm/mach-w90x900/time.c             |   10 ++--------
 arch/arm/plat-iop/time.c                 |    9 ++-------
 arch/arm/plat-orion/time.c               |    6 +-----
 arch/arm/plat-samsung/s5p-time.c         |    9 +--------
 arch/arm/plat-spear/time.c               |    8 +-------
 drivers/clocksource/cs5535-clockevt.c    |   11 ++---------
 drivers/clocksource/sunxi_timer.c        |   11 ++---------
 drivers/clocksource/tcb_clksrc.c         |    7 +------
 kernel/time/clockevents.c                |    1 +
 29 files changed, 59 insertions(+), 233 deletions(-)

-- 
1.7.9.5
