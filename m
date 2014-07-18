From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Jul 2014 23:13:35 +0200
Subject: [GIT PULL] Allwinner clocks additions for 3.17
Message-ID: <20140718211335.GA29677@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Here is the first pull request for the Allwinner clocks changes 

Unless something major comes up, or we agree quickly on the MMC
changes I posted yesterday, there shouldn't be any follow up for the
3.17 relaese cycle.

Thanks!
Maxime

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-clocks-for-3.17

for you to fetch changes up to 6c1d66f0da59362cb33ce37d436cd28c77c2b2cb:

  clk: sunxi: sun6i-a31-apb0-gates: Add A23 APB0 support (2014-07-15 08:53:24 +0200)

----------------------------------------------------------------
Allwinner clocks additions for 3.17

This pull request adds support for the clocks found in the newly supported
Allwinner A23 clocks.

----------------------------------------------------------------
Chen-Yu Tsai (9):
      clk: sunxi: register clock gates with clkdev
      clk: sunxi: move "ahb_sdram" to protected clock list
      clk: sunxi: Support factor clocks with N factor starting not from 0
      clk: sunxi: Add support for table-based divider clocks
      clk: sunxi: Add A23 clocks support
      clk: sunxi: Add A23 APB0 divider clock support
      clk: sunxi: Fix gate indexing for sun6i-a31-apb0-gates
      clk: sunxi: sun6i-apb0-gates: use bitmaps for valid gate indices
      clk: sunxi: sun6i-a31-apb0-gates: Add A23 APB0 support

 Documentation/devicetree/bindings/clock/sunxi.txt |   7 ++
 drivers/clk/sunxi/Makefile                        |   4 +-
 drivers/clk/sunxi/clk-factors.c                   |   2 +-
 drivers/clk/sunxi/clk-factors.h                   |   1 +
 drivers/clk/sunxi/clk-sun6i-apb0-gates.c          |  76 ++++++++------
 drivers/clk/sunxi/clk-sun8i-apb0.c                |  68 +++++++++++++
 drivers/clk/sunxi/clk-sunxi.c                     | 119 ++++++++++++++++++++--
 7 files changed, 234 insertions(+), 43 deletions(-)
 create mode 100644 drivers/clk/sunxi/clk-sun8i-apb0.c

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140718/e46d69b5/attachment.sig>
