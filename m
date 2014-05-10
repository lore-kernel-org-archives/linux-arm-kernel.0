From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  9 May 2014 22:33:35 -0500
Subject: [PATCH 0/6] sunxi: clk: Various cleanup and rework
Message-ID: <1399692821-20988-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This patchset fixes a few things that have been pending for quite a
while in the clock driver.

First, it removes the clk_put calls in the clock protection
part. Since it's not really something that should be done, I guess
this patch is not very controversial.

Then, it starts splitting the huge clock driver file into separate,
smaller drivers when it makes sense.

Finally, it reworks the clock protection mechanism to handle
differences between SoC in a better way. This has been pretty
controversial because the first approach has been to move this to the
machine code. This is another attempt that leaves all the
modifications in the driver itself.

Thanks,
Maxime

Maxime Ripard (6):
  clk: sunxi: Remove calls to clk_put
  clk: sunxi: Move the 24M oscillator to a file of its own
  clk: sunxi: Move the GMAC clock to a file of its own
  clk: sunxi: Rework clock protection code
  clk: sun6i: Protect CPU clock
  clk: sun6i: Protect SDRAM gating bit

 drivers/clk/sunxi/Makefile       |   2 +
 drivers/clk/sunxi/clk-a10-hosc.c |  73 ++++++++++++
 drivers/clk/sunxi/clk-a20-gmac.c | 119 ++++++++++++++++++++
 drivers/clk/sunxi/clk-sunxi.c    | 233 ++++++++-------------------------------
 4 files changed, 240 insertions(+), 187 deletions(-)
 create mode 100644 drivers/clk/sunxi/clk-a10-hosc.c
 create mode 100644 drivers/clk/sunxi/clk-a20-gmac.c

-- 
1.9.1
