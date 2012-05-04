From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 4 May 2012 19:05:33 +0200
Subject: [GIT PULL] clk for next
Message-ID: <20120504170533.GO4141@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Erm, no, this is not a pull request, more a request for a pull request.

Currently we are still missing the clk patches for next in -next. It
should be fine to have these in arm-soc since probably no non-arm
architecture will convert to the clock framework in the next two weeks.

Then finally we could merge SoC clk code in the arm-soc tree. BTW there
are lready spear clk patches in the arm-soc tree which conflict with
Mikes branch so Viresh might have to fix them (maybe he sent the fixes
already to the list, can't remember)


So Mike, please consider sending the following pull request to Arnd:

The following changes since commit 66f75a5d028beaf67c931435fdc3e7823125730c:

  Linux 3.4-rc4 (2012-04-21 14:47:52 -0700)

are available in the git repository at:

  git://git.linaro.org/people/mturquette/linux.git clk-next

for you to fetch changes up to 0e1c03017549a9df513622b3f15ff38eb8d35a62:

  clk: clk_set_rate() must fail if CLK_SET_RATE_GATE is set and clk is enabled (2012-05-01 18:13:38 -0700)

----------------------------------------------------------------
Mark Brown (2):
      clk: Remove comment for end of CONFIG_COMMON_CLK section
      clk: Constify parent name arrays

Mike Turquette (6):
      clk: core: correct clk_set_rate kerneldoc
      clk: core: remove dead code paths
      clk: core: clk_calc_new_rates handles NULL parents
      clk: core: enforce clk_ops consistency
      clk: core: copy parent_names & return error codes
      clk: basic: improve parent_names & return errors

Rajendra Nayak (2):
      clk: Make clk_get_rate() return 0 on error
      clk: constify parent name arrays in macros

Rob Herring (2):
      clk: select CLKDEV_LOOKUP for COMMON_CLK
      clk: remove trailing whitespace from clk.h

Saravana Kannan (1):
      clk: Use a separate struct for holding init data.

Shawn Guo (7):
      clk: use kzalloc in clk_register_mux
      clk: remove unnecessary EXPORT_SYMBOL_GPL
      clk: add "const" for clk_ops of basic clks
      clk: declare clk_ops of basic clks in clk-provider.h
      clk: always pass parent_rate into .round_rate
      clk: pass parent_rate into .set_rate
      clk: propagate round_rate for CLK_SET_RATE_PARENT case

Viresh Kumar (5):
      clk: Fix typo in comment
      clk: clk-gate: Create clk_gate_endisable()
      clk: clk-private: Add DEFINE_CLK macro
      clk: Don't set clk->new_rate twice
      clk: clk_set_rate() must fail if CLK_SET_RATE_GATE is set and clk is enabled

 drivers/clk/Kconfig          |    1 +
 drivers/clk/clk-divider.c    |   68 +++++------
 drivers/clk/clk-fixed-rate.c |   49 ++++----
 drivers/clk/clk-gate.c       |  104 ++++++++---------
 drivers/clk/clk-mux.c        |   26 +++--
 drivers/clk/clk.c            |  265 +++++++++++++++++++++++++++---------------
 include/linux/clk-private.h  |   79 +++++--------
 include/linux/clk-provider.h |   95 ++++++++-------
 include/linux/clk.h          |    6 +-
 9 files changed, 383 insertions(+), 310 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
