From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Fri, 31 Aug 2012 14:21:27 +0200
Subject: [PATCH 0/4] clk: Support for smp_twd clock for ux500
Message-ID: <1346415691-13371-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

To implement support for the smp_twd clock for ux500 several steps
was needed. This patchseries has also proposed some new changes in the
common clock core, which the ux500 smp_twd clock definition are
relying on.

Moreover some crossdepency exist to the ux500 prcmu mfd driver.
My idea is that the corresponding maintainers may be able to ack these
changes, if they like them of course, so we can merge this through
Mike Turquette's clk git tree. Otherwise I can happily set up some other
way forward, if that suits better.

Patches is based upon Linux 3.6 rc2. The clock patches specific for ux500,
is based upon the series [PATCH V2 0/4] clk: Convert ARM ux500 to common
clock.

Michel Jaouen (1):
  mfd: dbx500: Provide a more accurate smp_twd clock

Ulf Hansson (3):
  clk: Provide option for clk_get_rate to issue hw for new rate
  clk: ux500: Support for prmcu_rate clock
  clk: ux500: Define smp_twd clock for u8500

 drivers/clk/clk.c                |   43 +++++++++++++++++++++-----------------
 drivers/clk/ux500/clk-prcmu.c    |   14 +++++++++++++
 drivers/clk/ux500/clk.h          |    5 +++++
 drivers/clk/ux500/u8500_clk.c    |   12 +++++++----
 drivers/mfd/db8500-prcmu.c       |   42 +++++++++++++++++++++++++++++++++++++
 drivers/mfd/dbx500-prcmu-regs.h  |    4 +++-
 include/linux/clk-provider.h     |    1 +
 include/linux/mfd/dbx500-prcmu.h |    1 +
 8 files changed, 98 insertions(+), 24 deletions(-)

-- 
1.7.10
