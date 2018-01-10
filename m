From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 10 Jan 2018 18:07:41 +0100
Subject: [PATCH v2 0/2] i2c: mv64xxx: Fix clock resource for Armada 7K/8K
Message-ID: <20180110170743.27082-1-gregory.clement@free-electrons.com>
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

Changelog:
v1 -> v2:

 - Really add the binding documentation in the second patch, noticed
   by Thomas Petazzoni.

Gregory CLEMENT (2):
  i2c: mv64xxx: Remove useless test before clk_disable_unprepare
  i2c: mv64xxx: Fix clock resource by adding an optional bus clock

 .../devicetree/bindings/i2c/i2c-mv64xxx.txt          | 20 ++++++++++++++++++++
 drivers/i2c/busses/i2c-mv64xxx.c                     | 20 +++++++++++++-------
 2 files changed, 33 insertions(+), 7 deletions(-)

-- 
2.15.1
