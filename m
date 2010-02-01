From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 1 Feb 2010 16:47:02 +0100
Subject: Pull request
Message-ID: <20100201154702.GW19551@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please pull the following MXC related patches for -rc.

Sascha


The following changes since commit 004b35063296b6772fa72404a35b498f1e71e87e:
  Linus Torvalds (1):
        Merge branch 'drm-linus' of git://git.kernel.org/.../airlied/drm-2.6

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git for-rmk

Baruch Siach (4):
      mx25: remove unused mx25_clocks_init() argument
      mx25: properly initialize clocks
      mx25: fix time accounting
      mx25: make the FEC AHB clk secondary of the IPG

Mark Brown (4):
      mx31ads: Allow enable/disable of switchable supplies
      mx31ads: Provide a name for EXPIO interrupt chip
      mx31ads: Provide an IRQ range to the WM835x on the 1133-EV1 module
      MXC: Add AUDMUXv2 register decode to debugfs

Sascha Hauer (2):
      i.MX25: Allow secondary clocks in DEFINE_CLOCK
      i.MX25: implement secondary clocks for uarts and fec

Uwe Kleine-K?nig (1):
      mx35: add a missing comma in a pad definition

Vladimir Zapolskiy (1):
      ARM: MX3: Fixed typo in declared enum type name.

 arch/arm/mach-mx25/clock.c                      |   58 ++++++----
 arch/arm/mach-mx25/mx25pdk.c                    |    2 +-
 arch/arm/mach-mx3/mx31ads.c                     |    4 +
 arch/arm/plat-mxc/audmux-v2.c                   |  137 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/board-mx31lite.h |    2 +-
 arch/arm/plat-mxc/include/mach/common.h         |    2 +-
 arch/arm/plat-mxc/include/mach/iomux-mx35.h     |    2 +-
 arch/arm/plat-mxc/include/mach/irqs.h           |    5 +
 8 files changed, 187 insertions(+), 25 deletions(-)


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
