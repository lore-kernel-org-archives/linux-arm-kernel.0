From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Mon,  3 Feb 2014 12:25:27 +0100
Subject: [PATCH 0/3] clk: at91: various fixes and improvements
Message-ID: <1391426731-9392-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mike,

This series fixes a bug in the prog clk prepare function (the platform hangs
when preparing a prog clk).

It also implements the determine_rate callback for these prog clks and allow
system clk to propagate the rate change to its parent.

These modifications are needed to get the atmel_wm8904 driver working (this
driver make use of prog clks), and if possible, should be merged in the next
3.14 release (at least the first patch of this series).

Let me know if this is not possible.

Thanks.

Best Regards,

Boris

Boris BREZILLON (3):
  clk: at91: fix programmable clk irq handling
  clk: at91: replace prog clk round_rate with determine_rate
  clk: at91: propagate rate change on system clks

 drivers/clk/at91/clk-programmable.c |   61 ++++++++++++++++++-----------------
 drivers/clk/at91/clk-system.c       |    3 +-
 2 files changed, 34 insertions(+), 30 deletions(-)

-- 
1.7.9.5
