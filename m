From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 26 Feb 2016 11:48:30 -0800
Subject: [GIT PULL] arm: Allwinner clocks changes for 4.6
Message-ID: <20160226194830.GA21652@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-clocks-for-4.6

for you to fetch changes up to 6e17b4181603d183d20c73f4535529ddf2a2a020:

  clk: sunxi: Add apb0 gates for H3 (2016-02-25 11:30:32 -0800)

----------------------------------------------------------------
Allwinner clocks additions for 4.6

A bunch of things, mostly:
  - Finally switched everything over to OF_CLK_DECLARE, which should remove
    orphans clocks entirely
  - Reworked the clk-factors to be able to add new parameters
  - Improved the error reporting
  - A bunch of new clocks for new SoCs.

----------------------------------------------------------------
Andre Przywara (4):
      clk: sunxi: improve error reporting for the mux clock
      clk: sunxi: improve mux_clk error handling and reporting
      clk: sunxi: improve divider_clk error handling and reporting
      clk: sunxi: Improve divs_clk error handling and reporting

Arnd Bergmann (1):
      clk: sunxi: don't mark sun6i_ar100_data __initconst

Chen-Yu Tsai (11):
      clk: sunxi: usb: Sort clk providers by chip family and name
      clk: sunxi: factors: Make struct clk_factors_config table const
      clk: sunxi: factors: Add clk cleanup in sunxi_factors_register() error path
      clk: sunxi: factors: Add unregister function
      clk: sunxi: factors: Consolidate get_factors parameters into a struct
      clk: sunxi: factors: Support custom formulas
      clk: sunxi: factors: Drop round_rate from clk ops
      clk: sunxi: rewrite sun6i-a31-ahb1-clk using factors clk with custom recalc
      clk: sunxi: rewrite sun6i-ar100 using factors clk
      clk: sunxi: rewrite sun8i-a23-mbus-clk using the simpler composite clk
      clk: sunxi: Fix sun8i-a23-apb0-clk divider flags

Krzysztof Adamski (1):
      clk: sunxi: Add apb0 gates for H3

Maxime Ripard (5):
      clk: sunxi: Make clocks setup functions return their clock
      clk: sunxi: Make clocks setup functions take const pointer
      clk: sunxi: convert current clocks registration to CLK_OF_DECLARE
      clk: sunxi: Remove old probe and protection code
      clk: sunxi: Remove clk_register_clkdev calls

Stephen Boyd (1):
      clk: sunxi: Drop clk.h include

Vishnu Patekar (2):
      clk: sunxi: Add apb0 gates for A83T
      clk: sunxi: add bus gates for A83T

 Documentation/devicetree/bindings/clock/sunxi.txt |   4 +
 drivers/clk/sunxi/clk-a10-hosc.c                  |   3 +-
 drivers/clk/sunxi/clk-a20-gmac.c                  |   2 -
 drivers/clk/sunxi/clk-factors.c                   | 123 ++-
 drivers/clk/sunxi/clk-factors.h                   |  26 +-
 drivers/clk/sunxi/clk-mod0.c                      |  23 +-
 drivers/clk/sunxi/clk-simple-gates.c              |   4 +
 drivers/clk/sunxi/clk-sun6i-apb0-gates.c          |   2 -
 drivers/clk/sunxi/clk-sun6i-ar100.c               | 235 ++----
 drivers/clk/sunxi/clk-sun8i-apb0.c                |   2 +-
 drivers/clk/sunxi/clk-sun8i-bus-gates.c           |   3 +-
 drivers/clk/sunxi/clk-sun8i-mbus.c                | 127 ++--
 drivers/clk/sunxi/clk-sun9i-core.c                |  86 +--
 drivers/clk/sunxi/clk-sunxi.c                     | 863 ++++++++++------------
 drivers/clk/sunxi/clk-usb.c                       |  24 +-
 15 files changed, 691 insertions(+), 836 deletions(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160226/30547b3f/attachment-0001.sig>
