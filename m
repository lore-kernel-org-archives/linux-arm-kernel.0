From: david@lechnology.com (David Lechner)
Date: Fri, 25 May 2018 13:11:41 -0500
Subject: [PATCH 0/9] clk: davinci: outstanding fixes
Message-ID: <20180525181150.17873-1-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a resend of all of the outstanding DaVinci clock patches plus one new
patch. All of the patches (except the new one) have been reviewed and tested
by someone other than me.

The new patch ("clk: davinci: Fix link errors when not all SoCs are enabled")
should be fairly trivial.

I am resending them all in one series to hopefully make it easier to get them
picked up by having them in the correct order to avoid merge conflicts. This
series is based on the clk/clk-davinci-psc-da830 branch.

David Lechner (7):
  clk: davinci: pll-dm355: drop pll2_sysclk2
  clk: davinci: pll-dm355: fix SYSCLKn parent names
  clk: davinci: psc-dm355: fix ASP0/1 clkdev lookups
  clk: davinci: pll: allow dev == NULL
  clk: davinci: da850-pll: change PLL0 to CLK_OF_DECLARE
  clk: davinci: psc: allow for dev == NULL
  clk: davinci: Fix link errors when not all SoCs are enabled

Sekhar Nori (2):
  clk: davinci: pll-dm646x: keep PLL2 SYSCLK1 always enabled
  clk: davinci: psc-dm365: fix few clocks

 drivers/clk/davinci/pll-da830.c  |   5 +-
 drivers/clk/davinci/pll-da850.c  |  37 ++--
 drivers/clk/davinci/pll-dm355.c  |  22 ++-
 drivers/clk/davinci/pll-dm365.c  |   9 +-
 drivers/clk/davinci/pll-dm644x.c |   9 +-
 drivers/clk/davinci/pll-dm646x.c |  11 +-
 drivers/clk/davinci/pll.c        | 299 +++++++++++++++++++++----------
 drivers/clk/davinci/pll.h        |  41 +++--
 drivers/clk/davinci/psc-dm355.c  |   7 +-
 drivers/clk/davinci/psc-dm365.c  |  22 ++-
 drivers/clk/davinci/psc-dm644x.c |   3 +-
 drivers/clk/davinci/psc-dm646x.c |   3 +-
 drivers/clk/davinci/psc.c        |  72 ++++++--
 drivers/clk/davinci/psc.h        |  12 ++
 include/linux/clk/davinci.h      |  40 +++++
 15 files changed, 418 insertions(+), 174 deletions(-)
 create mode 100644 include/linux/clk/davinci.h

-- 
2.17.0
