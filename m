From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 Jan 2013 20:41:35 +0800
Subject: [GIT PULL] clockevent driver cleanup for 3.9
Message-ID: <20130110124132.GA8680@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:

  Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/clean-clkevt-3.9

for you to fetch changes up to ab8e73c98749a58c242b187c9799db70cd903157:

  clocksource: use clockevents_config_and_register() where possible (2013-01-10 20:24:30 +0800)

----------------------------------------------------------------
As John has showed zero interest to collect clock event driver patches,
I send both patches through arm-soc tree here.

----------------------------------------------------------------
Shawn Guo (2):
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
 28 files changed, 58 insertions(+), 233 deletions(-)
