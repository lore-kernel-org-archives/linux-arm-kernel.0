From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sun, 30 Jul 2017 18:41:46 +0200
Subject: [PATCH 0/4] clk: sunxi-ng: Fix issues with fractional mode
Message-ID: <20170730164150.26302-1-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During development of H3 HDMI driver, I found some issues with
setting video clock rate. It turned out that clock driver decided
to use fractional mode and selected right frequency, but it didn't
enable it. Additionally, fractional helpers don't wait on lock.

Patch 1 adds a call to N-M clock driver which enables fractional mode.
It also clears M factor before that as required by most SoCs.

Patch 2 adds a call to N clock driver which enables fractional mode.

Patch 3 makes fractional helpers less chatty.

Patch 4 adds a wait for lock to fractional helpers.

Jernej Skrabec (4):
  clk: sunxi-ng: Fix fractional mode for N-M clocks
  clk: sunxi-ng: multiplier: Fix fractional mode
  clk: sunxi-ng: Make fractional helper less chatty
  clk: sunxi-ng: Wait for lock when using fractional mode

 drivers/clk/sunxi-ng/ccu_frac.c | 14 ++++++++------
 drivers/clk/sunxi-ng/ccu_frac.h |  2 +-
 drivers/clk/sunxi-ng/ccu_mult.c | 10 +++++++---
 drivers/clk/sunxi-ng/ccu_nm.c   | 19 ++++++++++++++++---
 4 files changed, 32 insertions(+), 13 deletions(-)

-- 
2.13.3
