From: hramrach@gmail.com (Michal Suchanek)
Date: Wed, 12 Aug 2015 14:10:23 +0200
Subject: [PATCH 0/3] misc MMC fixes
Message-ID: <cover.1439381423.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The first sunxi patch from this series was rejected on the basis that this clock
gating functionality is obsolete and should be eventually removed.

However, the function still exists in the current code and until removed it
should be corrected to work properly. Turning off the clock may be used for
something other than the clock gating feature, too.

The next sunxi patch is for automatic clock gating on the controller which
should replace the in-kernel mmc clock gating we have now.

I looked at dw_mmc for how this is supposed to work and it turns out it's not
exactly clean there either.

Thanks

Michal

Michal Suchanek (3):
  mmc: sunxi: fix timeout in sunxi_mmc_oclk_onoff
  mmc: dw_mmc: simplify the SDMMC_CLKEN_LOW_PWR logic
  mmc: sunxi: use controller automatic clock gating.

 drivers/mmc/host/dw_mmc.c    | 33 +++++++++++++++------------------
 drivers/mmc/host/sunxi-mmc.c | 29 +++++++++++++++++++++++++----
 2 files changed, 40 insertions(+), 22 deletions(-)

-- 
2.1.4
