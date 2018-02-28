From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 28 Feb 2018 15:27:21 +0100
Subject: [PATCH 0/2] hwrng: omap: Fix clock resource for Armada 7K/8K
Message-ID: <20180228142723.11562-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This short series fixes the way the clocks are used for the SafeXcel
IP-76 controller embedded in the Marvell Armada 7K/8K SoCs. On these
SoCs a second one is needed in order to clock the registers. It was
not noticed until now because we relied on the bootloader and also
because the clock driver was wrong.

Thanks to this fix, it would be possible to fix the clock driver
without introducing a regression.

The first patch is just a small cleanup found when I wrote the main
patch.

Gregory CLEMENT (2):
  hwrng: omap - Remove useless test before clk_disable_unprepare
  hwrng: omap - Fix clock resource by adding a register clock

 Documentation/devicetree/bindings/rng/omap_rng.txt |  7 ++++++-
 drivers/char/hw_random/omap-rng.c                  | 22 ++++++++++++++++++----
 2 files changed, 24 insertions(+), 5 deletions(-)

-- 
2.16.1
