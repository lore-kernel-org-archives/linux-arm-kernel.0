From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 10 Jan 2018 17:51:45 +0100
Subject: [PATCH 0/2] 2c: mv64xxx: Fix clock resource for Armada 7K/8K
Message-ID: <20180110165147.26605-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This short series fixes the way the clocks are used for the mv64xxx
controller embedded in the Marvell Armada 7K/8K SoCs. On these SoCs a
second one is needed in order to clock the registers. It was not
noticed until now because we relied on the bootloader and also because
the clock driver was wrong.

Thanks to this fix, it would be possible to fix the clock driver
without introducing a regression.

The first patch is just a small cleanup found when I wrote the main
patch.

Thanks,

Gregory

Gregory CLEMENT (2):
  i2c: mv64xxx: Remove useless test before clk_disable_unprepare
  i2c: mv64xxx: Fix clock resource by adding an optional bus clock

 drivers/i2c/busses/i2c-mv64xxx.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

-- 
2.15.1
