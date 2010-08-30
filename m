From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 30 Aug 2010 21:16:03 +0200
Subject: [GIT PULL] i.MX patches for 2.6.36
Message-ID: <20100830191603.GO1473@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please pull the following patches for 2.6.36.

Thanks
 Sascha

The following changes since commit d1b113bb028999e82a8528e1484be8c23fb5a7d9:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6 (2010-08-23 18:30:30 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git imx-for-2.6.36

Eric B?nard (1):
      eukrea-baseboards: fix the merge in one file

Hans J. Koch (1):
      mx35: Fix boot ROM hang in internal boot mode

Jason Wang (3):
      mxc/tzic: add base address when accessing TZIC registers
      mx5/clock: fix clear bit fields issue in _clk_ccgr_disable function
      ARM: imx: set cache line size to 64 bytes for i.MX5

Juergen Beisert (1):
      clock-imx35: Calculate the base clock rate for the IPU unit

Marc Kleine-Budde (2):
      clock-imx35: fix divider if ahb is source for ipg_per
      clock-imx35: correct arm and ahb clock calculation

Sascha Hauer (1):
      i.MX35: remove get_3_3_div helper function

 arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c      |    2 +-
 arch/arm/mach-mx25/mach-cpuimx25.c                 |    4 +-
 arch/arm/mach-mx3/clock-imx35.c                    |   77 ++++++++++++++------
 arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c       |    2 +-
 arch/arm/mach-mx3/mach-cpuimx35.c                  |    4 +-
 arch/arm/mach-mx5/clock-mx51.c                     |    2 +-
 arch/arm/plat-mxc/Kconfig                          |    1 +
 arch/arm/plat-mxc/include/mach/eukrea-baseboards.h |    4 +-
 arch/arm/plat-mxc/tzic.c                           |    5 +-
 9 files changed, 68 insertions(+), 33 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
