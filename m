From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 21 Jul 2016 08:28:01 +0200
Subject: [PATCH 0/3] mmc: sunxi: Changes in the host driver
Message-ID: <cover.1469082481.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While testing the eMMC access in a Banana Pi M3, I found and fixed
some problems:
- the driver was trying to set a strange rate when clk_round_rate()
  was returning an error
- the 'new timing mode' could not work because a register was not set
- with a parent clock at 1.2GHz, the output and sample phases were
  not correct for the A83T

Jean-Francois Moine (3):
  mmc: sunxi: Check the value returned by clk_round_rate
  mmc: sunxi: Set the 'New Timing' register for 8 bits DDR transfers
  mmc: sunxi: Add support to the Allwinner A83T

 drivers/mmc/host/sunxi-mmc.c | 45 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 7 deletions(-)

-- 
2.9.2
